# [Mevoric 调研笔记（原 agent-bridge-mcp）](https://github.com/Lloydm15/agent-bridge-mcp)

> 跨多个 Claude Code 窗口/进程的消息桥接 + 长期记忆 MCP server。
> 当前版本：**mevoric v2.3.0**（12 个工具）。
> 调研时间：2026-07-13。本机已从 agent-bridge-mcp v1.2.0 完成迁移。
> 命名历史：原仓库 `agent-bridge-mcp`（Lloydm15）已重命名为 `mevoric`，工具数 7→12（新增 memory + checkpoint）。

## 1. 它能干什么

跨多个 Claude Code 实例（不同窗口、不同 VSCode 实例、不同机器——只要共享同一个数据目录）实现：

**bridge（7 个，向后兼容 agent-bridge-mcp）**：
- **send_message(to, content)** / **broadcast(content)** / **read_messages(...)** / **register_agent(name)** / **list_agents()** / **share_context(content)** / **get_context(from)**

**checkpoint（2 个，新增）**：
- **save_checkpoint(...)** — 把工作状态（任务、改动文件、决策）打包存盘，24h 过期
- **load_checkpoint(id?)** — 恢复 checkpoint

**memory（3 个，新增，需要外部 HTTP backend）**：
- **retrieve_memories(query)** — 从远端 memory server 检索相关历史对话
- **store_conversation(user_message, assistant_response)** — 把当前对话写入远端
- **judge_memories(conversation_id, query_text, response_text)** — LLM 评分后回传 memory server

典型用法：让"开发者 agent"开发完代码后给"部署 agent"发指令；"部署 agent"回报部署结果。

## 2. 安装与配置（mevoric v2.3.0）

### 2.1 init 命令

```bash
npx mevoric init --server http://127.0.0.1:4000
```

⚠️ **init 有个 bug**：输出声称"写入 `~/.claude/.mcp.json`"，但 Claude Code 实际从 `~/.claude.json` 的 `mcpServers` 字段加载 MCP servers。**必须手动编辑 `~/.claude.json`**，否则 init 后工具集仍停在 agent-bridge（详见第 8 节迁移记录）。

### 2.2 `~/.claude.json` 的 mevoric 块（最终生效的）

```json
{
  "mcpServers": {
    "mevoric": {
      "type": "stdio",
      "command": "node",
      "args": [
        "E:\\nvm\\v24.16.0\\node_cache\\_npx\\a69d875ba82c6cfe\\node_modules\\mevoric\\server.mjs"
      ],
      "env": {
        "MEVORIC_SERVER_URL": "http://127.0.0.1:4000",
        "MEVORIC_DATA_DIR": "C:\\Users\\UryWu\\AppData\\Local\\agent-bridge"
      }
    }
  }
}
```

⚠️ `server.mjs` 在 npx 缓存里（`E:\nvm\v24.16.0\node_cache\_npx\<hash>\node_modules\mevoric\`），是 npx 的内容寻址缓存。被 GC 清掉后要重跑 `npx mevoric init` 让缓存重新生成。

### 2.3 `~/.claude/settings.json` 自动注入

`init` 在全局 settings.json 里追加：
- 12 条 `mcp__mevoric__*` allow 权限
- 3 个 hooks（SessionStart / UserPromptSubmit / Stop）

### 2.4 项目级 `settings.local.json`

mevoric init 不会自动改项目级 `settings.local.json`，但里面 SessionStart prompt 文案原本提到"agent-bridge"，需要手改成"mevoric"以保持一致（已修）。

## 3. 工具签名（mevoric v2.3.0，12 个）

bridge / context / checkpoint 9 个工具与 agent-bridge-mcp 向后兼容（同名同参）。memory 3 个是新增。

```typescript
// bridge (7)
register_agent({ name: string })
list_agents()
send_message({ to: string, content: string })
read_messages({ include_broadcasts?: boolean = true })
broadcast({ content: string })
share_context({ content: string })
get_context({ from?: string })

// checkpoint (2)
save_checkpoint({ task?: {description, status, steps_completed, steps_remaining},
                  files_touched?: string[], key_decisions?: string[], notes?: string })
load_checkpoint({ id?: string })

// memory (3, 需要 backend)
retrieve_memories({ query: string, user_id?: string })
store_conversation({ user_message: string, assistant_response: string,
                     user_id?: string, conversation_id?: string })
judge_memories({ conversation_id: string, query_text: string,
                 response_text: string, user_id?: string })
```

返回格式：`{messages: [...]}` / `{agents: [...]}` / `{memories: [...]}` / `{status: ...}` / `{registered: true, id, name}`。

`list_agents` 返回的对象新增了 `baseName` 字段（区别于 `name`，用于标识不带数字后缀的"基名"），其他字段与 agent-bridge 时代一致。

## 4. 存储位置

### 4.1 本地存储（bridge / context / checkpoint）

继续使用 `MEVORIC_DATA_DIR`（默认 `%LOCALAPPDATA%\agent-bridge\`）。mevoric 沿用了 agent-bridge 的目录结构，所以**升级不会丢旧数据**。

```
%LOCALAPPDATA%\agent-bridge\
├── agents\              ← 每个 agent 一个 JSON
├── messages\            ← 每条消息一个 JSON，<timestamp_ms>-<randomId>.json
├── context\             ← share_context
├── cursors\             ← read_messages 的 last-read 游标
└── checkpoints\         ← mevoric 新增
```

Agent JSON 格式新增 `baseName` 字段（与原 `name` 同义但用于稳定标识）。

### 4.2 长期记忆（memory 工具）

存储在**用户自建 backend**——mevoric 不自带 server，只调外部 HTTP。详见第 6 节。

### 4.3 关键行为（与 agent-bridge 兼容）

- 消息存盘 `<timestamp_ms>-<randomId>.json`，pull 模型不变
- agent 心跳更新 `lastHeartbeat`，stale 阈值 45s / dead 阈值更长（沿用原配置）
- 进程退出 `heartbeatTimer.unref()`，不影响父进程关闭
- mevoric 额外：每条 user prompt 写到 temp 文件 `mevoric-prompt-<sessionId>`，Stop hook 时读取、配对 final response、整段 POST 到 `/ingest`

## 5. push vs pull —— 仍然的设计

bridge 工具仍是 **pull-based message queue**：

```
[Agent A] send_message(B, "...")  ─→  [bridge storage: messages/*.json]
                                          │
                                          ▼
                                  Agent B 主动调 read_messages()
                                          │
                                          ▼
                                    才看到这条消息
```

含义不变：
- A 发完消息立刻返回，不阻塞、不等 B
- B 不读就永远看不到——消息存盘等下一轮拉取
- heartbeat 只用于 liveness，不投递消息

### 5.1 mevoric 的改进：UserPromptSubmit hook 唤醒

mevoric 注入的 `UserPromptSubmit` hook 会调 `--check-messages`：
- 对方 agent 收到任何用户输入（哪怕 `.` + Enter）都触发该 hook
- hook 把当前 agent 的"未读消息"自动塞到对话上下文
- **这变相实现了"对方自动 poll"**——agent-bridge 时代要手动敲 `.` 才能让对方醒

### 5.2 调试技巧（同前）

- 想让对方立即看到消息：去对方窗口输入任何东西（哪怕 `.`）按 Enter
- 看 `list_agents` 的 `lastHeartbeat` 时间戳：超过几分钟没跳说明它真的空闲或卡住
- 消息没投递成功：看 `%LOCALAPPDATA%\agent-bridge\messages\` 目录有没有对应 timestamp 文件

## 6. 自建的 Memory backend

mevoric 不自带 memory server。我搭了一个最小 FastAPI + SQLite 实现（2026-07-13）：

### 6.1 文件位置

| 文件 | 路径 |
|---|---|
| 后端代码 | `C:\Users\UryWu\.mevoric-backend\server.py`（110 行） |
| 数据库 | `C:\Users\UryWu\.mevoric-backend\memories.db`（SQLite） |
| 运行日志 | `C:\Users\UryWu\.mevoric-backend\server.log` |
| 进程 PID | `26292`（uvicorn 主进程） |

### 6.2 启动方式

```bash
PY="g:/Projects/projects_ai/data_sim_card_purchase_provide_data/.venv/Scripts/python.exe"
nohup "$PY" -m uvicorn --app-dir "C:/Users/UryWu/.mevoric-backend" server:app \
  --host 127.0.0.1 --port 4000 --log-level info \
  > "C:/Users/UryWu/.mevoric-backend/server.log" 2>&1 &
```

复用主项目 `.venv` 的 fastapi 0.135.1 / uvicorn 0.41.0，不再独立装。

### 6.3 4 个端点（与 mevoric server.mjs 对应）

| 端点 | 调用者 | 入参 | 出参 |
|---|---|---|---|
| `POST /retrieve` | retrieve_memories | `{query, user_id, conversation_id, project, limit}` | `{memories: [{mem0_id, memory, score}]}` |
| `POST /ingest` | store_conversation + Stop hook | `{messages, user_id, conversation_id, project}` | `{status: "stored", stored, total}` |
| `POST /feedback` | Stop hook（fire-and-forget） | `{conversation_id, user_id, query_text, response_text}` | any |
| `POST /api/verdict` | judge_memories 后台 | `{mem0_id, conversation_id, user_id, verdict, judge_note, corrected_content, action_taken}` | any |

### 6.4 SQLite schema

- `memories(mem0_id PK, content, user_id, conversation_id, project, created_at)`
- `feedback(id PK auto, conversation_id, query_text, response_text, user_id, created_at)`
- `verdicts(id PK auto, mem0_id, conversation_id, verdict, judge_note, corrected_content, action_taken, created_at)`

### 6.5 检索策略

AND-关键词 LIKE（中文按字符切分）。score 简单赋 [0.5, 0.95] 区间。无 FTS、无向量。百级数据无感，万级以上要换方案（建议 FTS5 或换专用向量库）。

### 6.6 实测验证（2026-07-13）

| 工具 | 结果 |
|---|---|
| `mcp__mevoric__store_conversation` | HTTP 200，入库 2 条（user_msg + assistant_response 各一） |
| `mcp__mevoric__retrieve_memories` | HTTP 200，召回 1 条，score=0.95 |
| `mcp__mevoric__judge_memories` | HTTP 200（后台），verdict=`strengthen`，action_taken=`logged` |

## 7. 典型工作流（dev → deploy 模式）

agent-bridge 时代的痛点（收不到对方消息需手动敲 `.`）由 UserPromptSubmit hook 自动解决：

```
dev-agent                              deploy-agent
─────────────────────────────────      ─────────────────────────
[开发完成 v0.4.2]
  ↓
register_agent("dev-agent")
  ↓
send_message("deploy-agent", "
  /fastapi-vue-docker-compose-deploy-strategy
  main HEAD: b722755, tag v0.4.2
  ...")
  ↓
                                       [用户切到 deploy-agent 窗口]
                                          ↓
                                          输入 "看下" Enter
                                          ↓
                                          UserPromptSubmit hook 触发
                                          --check-messages 把未读消息塞进上下文
                                          ↓
                                          Claude 思考 + 开始执行
                                          ↓
                                          send_message("dev-agent", "
                                            上传完成,rebuild 跑中...")
                                          ↓
read_messages()
  ↓
看到部署进度
  ↓
[继续对话]                                [跑完]
                                          ↓
                                          send_message("dev-agent", "
                                            部署完成 ✅
                                            http://...")
                                          ↓
                                       Stop hook 触发
                                       --ingest POST /ingest + /feedback
```

`Stop hook` 同时把整段对话 POST 到 memory backend 的 `/ingest`，是 dev → deploy 流程之外另一条"持久化轨迹"。

## 8. 实际迁移记录（2026-07-13）

从 agent-bridge-mcp v1.2.0 迁到 mevoric v2.3.0。过程发现 init 的 bug：

1. **备份**：`~/.claude/settings.json` + 主项目 `settings.local.json` / `settings.json` 复制为 `.pre-mevoric.bak`
2. **跑 init**：`npx mevoric init --server http://127.0.0.1:4000`，输出"写入 `~/.claude/.mcp.json`" + "在 `~/.claude/settings.json` 加 12 权限 + 3 hooks"
3. **第一次重启 VSCode**：❌ 工具集仍是 agent-bridge。原因——`~/.claude/.mcp.json` Claude Code 不读
4. **诊断**：读 `~/.claude.json` 第 1021 行 `mcpServers`，找到 `agent-bridge` 块没被 init 改
5. **手动改 `~/.claude.json`**：把 `agent-bridge` 块替换为 `mevoric` 块（用 init 写到 `~/.claude/.mcp.json` 的同一段 stdio 配置）
6. **第二次重启**：✅ 工具集切到 mevoric，旧数据（agent-46bfe5 等）自动从旧 data dir 复用
7. **修项目 `settings.local.json`**：把 SessionStart prompt 文案里的"agent-bridge"改为"mevoric"
8. **删 `~/.claude/.mcp.json`**：init 写到错位置的冗余文件，不再需要
9. **写 memory backend**：建 `~/.mevoric-backend/server.py`，uvicorn 启动在 127.0.0.1:4000
10. **端到端验证**：3 个 memory 工具全绿

### 教训

mevoric init 的输出"1. Global MCP config (~/.claude/.mcp.json) Updated mevoric entry"是误导。`~/.claude/.mcp.json` Claude Code 不读；真读的是 `~/.claude.json` 的 `mcpServers`。这是 mevoric 2.3.0 的已知 bug（或者目标 Claude Code 版本不同——Claude Code 2.1.207 实测读 `~/.claude.json`）。

## 9. mevoric 新增的 3 个 hooks 详解

`init` 在 `~/.claude/settings.json` 注入：

| Hook | 触发 | 命令 | 作用 |
|---|---|---|---|
| **SessionStart** | Claude Code 启动 | `node mevoric/server.mjs --bootstrap-context` | 加载上下文（待办消息、最近 checkpoint） |
| **UserPromptSubmit** | 用户发 prompt | `--capture-prompt` 写 temp + `--check-messages` 自动投消息 | **自动唤醒对方 agent**（agent-bridge 时代痛点解决） |
| **Stop** | session 结束 | `--ingest` 整段对话 POST `/ingest` + fire-and-forget `/feedback` | 持久化记忆到 backend |

⚠️ 对方也要跑 mevoric（agent-bridge 没这机制，混合部署时 hook 不生效）。

## 10. 实测陷阱（更新版）

| 陷阱 | 现象 | 解决 |
|---|---|---|
| init 输出骗了你 | "写入 ~/.claude/.mcp.json" 但 Claude Code 不读 | 手动改 `~/.claude.json`（见第 8 节） |
| npx 缓存被 GC | server.mjs 路径失效 | 重跑 `npx mevoric init` 让缓存重新生成 |
| memory 工具 graceful error | 后端没起（127.0.0.1:4000 没监听） | 启动 `~/.mevoric-backend/server.py`（见第 6 节） |
| judge 后台慢 | judge_memories 返回"judging"几秒到十几秒才出 verdict | 正常，等 `/api/verdict` 进 SQLite 即可 |
| 旧 `agent-*.json` 残留 | 进程下线后文件还在 dir | mevoric 会按 lastHeartbeat 自己 GC stale |
| 端口 4000 被占用 | uvicorn 启动失败 | 改端口或在 `MEVORIC_SERVER_URL` 里同步 |

## 11. 什么时候不该用

- **同一个任务并行分解**：用 Agent 工具更快（共享上下文）
- **需要同步等待结果**：bridge 是异步的，不适合
- **机器间通信**：需要共享数据目录（NFS / Windows 共享），安全风险自己评估

跨机器 + 安全敏感的场景自己再写一层加签名 + TLS。

## 12. 参考链接（更新版）

- mevoric npm：`https://www.npmjs.com/package/mevoric`（v2.3.0，2026-03 发布）
- mevoric 仓库：`https://github.com/Lloydm15/mevoric`
- 本机 mevoric 代码：`E:\nvm\v24.16.0\node_cache\_npx\a69d875ba82c6cfe\node_modules\mevoric\server.mjs`（1709 行）
- 数据目录：`C:\Users\UryWu\AppData\Local\agent-bridge\`
- 自建 backend 代码：`C:\Users\UryWu\.mevoric-backend\server.py`（110 行）
- backend 数据库：`C:\Users\UryWu\.mevoric-backend\memories.db`
- 备份（迁移前）：`*.pre-mevoric.bak` 在项目 `.claude/` 和 `~/.claude/`