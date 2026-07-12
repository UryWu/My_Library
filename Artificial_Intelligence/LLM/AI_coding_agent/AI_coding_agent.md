



# agent code

## [OpenCode 开源项目技术文档](https://www.yuque.com/marion-luo/kfcqme/hupbr5k33x1tg139?singleDoc#)





## [【Claude Code】—— Claude Code 最全启动参数+权限配置｜彻底告别确认弹窗，实现全自动执行](https://blog.csdn.net/Lvyizhuo/article/details/158509613)

五、持久化配置（一次配置，永久生效）
创建全局配置文件，无需每次输参数：

5.1 配置路径

项目级（仅当前项目）

```bash
./.claude/settings.json

全局级（所有项目生效，Ubuntu/Mac）

~/.claude/settings.json
```

5.2 推荐配置（直接复制）

```json
{
  "permissions": {
    "initialPermissionMode": "acceptEdits",
    "allow": [
      "Read",
      "Write",
      "Edit",
      "Bash",
      "Git",
      "Npm",
      "Pip",
      "Grep",
      "Glob",
      "_comment": "下面这两个是qt编译用的",
      "Bash(mingw32-make)",
      "Bash(./telegram_explorer.exe)",
      "_comment": "下面这两个是提交代码用的",
      "Bash(git add *)",
      "Bash(git commit *)"
    ],
    "deny": [
      "Rm",
      "Ssh",
      "Sud"
    ]
  }
}
```





## memory.md、rules.md、Claude.md、Agents.md有什么区别？

这是一个很好的问题！这些文件在AI开发和工作流中扮演着不同的角色：
### 区别

#### **memory.md（记忆文件）**
- **功能**：记录对话历史、项目上下文、用户偏好和关键决策
- **特点**：动态更新，随时间积累，帮助AI保持对话连贯性
- **用途**：让AI“记住”之前讨论过的内容，避免重复询问

#### **rules.md（规则文件）**
- **功能**：定义AI的行为准则、输出格式、限制条件
- **特点**：静态规则，通常不经常变动
- **用途**：确保AI的回答风格一致，符合项目规范

#### **Claude.md（Claude专属配置）**
- **功能**：专门针对Claude模型的特定配置和优化
- **特点**：包含Claude特有的功能调用、API参数设置
- **用途**：最大化Claude模型在特定任务上的表现

#### **Agents.md（代理配置文件）**
- **功能**：定义AI代理的角色、工具使用权限、任务分解方式
- **特点**：描述AI如何自主执行复杂任务，调用外部工具
- **用途**：配置AI代理的行为，如联网搜索、代码执行等能力

#### **简单类比**
如果把AI比作一个员工：
- **memory.md** = 工作日记（记录做过什么）
- **rules.md** = 员工手册（规定不能做什么）
- **Claude.md** = 个人简历和特长说明
- **Agents.md** = 岗位职责和工具使用权限

这些文件通常用于Cline、Cursor等AI编程工具中，帮助AI更好地理解项目上下文和任务要求。

### 简单例子
好的，我来为每个文件举一个简单的例子：

#### **memory.md 示例**
```markdown
# 项目记忆

## 用户偏好
- 喜欢简洁的代码，偏好函数式编程风格
- 前端使用React + TailwindCSS
- 命名习惯：使用camelCase，避免缩写

## 关键决策
- 2024-03-15：决定使用Supabase作为后端数据库
- 2024-03-16：采用JWT而非Session进行身份验证

## 项目上下文
- 正在开发电商后台管理系统
- 已完成用户认证模块
- 下一步计划实现商品管理功能

## 已知问题
- 商品图片上传偶尔超时，需要优化
- 移动端菜单响应式有问题
```

#### **rules.md 示例**
```markdown
# AI行为规则

## 代码规范
- 所有函数必须写JSDoc注释
- 使用2个空格缩进，不要使用Tab
- 每行代码不超过80个字符

## 回答规范
- 先给出简短结论，再详细解释
- 重要内容用粗体标注
- 代码块必须标明语言类型

## 安全规则
- 永远不要在代码中硬编码API密钥
- 不要建议使用已弃用的npm包
- 敏感信息必须用环境变量存储

## 限制条件
- 不要生成超过200行的代码块
- 每次只重构一个函数
- 必须解释代码变更的原因
```

#### **Claude.md 示例**
```markdown
# Claude 3.5 Sonnet 配置

## 系统提示优化
你是一个专业的Python后端开发者，擅长FastAPI框架。

## 响应格式
{
  "thinking": "思考过程",
  "code": "生成的代码",
  "explanation": "简单解释"
}

## 功能调用配置
- 支持使用`get_weather`工具查询天气
- 支持使用`search_docs`工具搜索文档
- 最大token限制：4096

## 特殊指令
- 当用户问“怎么做”时，先分析需求再给代码
- 复杂问题分步骤回答，每步都要确认
```

#### **Agents.md 示例**
```markdown
# AI代理配置

## 角色定义
你是一个全栈开发助手，可以独立完成小型项目开发。

## 可用工具
- 文件操作：读写、创建、删除文件
- 终端命令：可以执行npm、git等命令
- 网络搜索：当遇到未知问题时可以联网搜索

## 任务执行流程
1. 分析用户需求
2. 规划实现步骤
3. 逐步执行，每步完成后等待确认
4. 提供测试用例

## 自主决策范围
- 可以自主选择技术栈（基于项目需求）
- 遇到错误可以自行尝试修复3次
- 超过3次失败需要请求人工帮助

## 特定场景处理
当用户说“帮我创建一个React项目”时：
1. 询问项目类型（SPA/SSR）
2. 询问是否需要路由、状态管理
3. 生成基础项目结构
4. 提供启动说明
```

这些文件通常放在项目的根目录或`.ai`文件夹中，AI工具会自动读取并遵循其中的配置。

## Agents.md应该放在哪里？

`AGENTS.md` 的作用类似 **给 AI / 开发者的项目规则说明**，通常放在 **仓库根目录**，这样所有 Agent 或开发工具都能看到。

### 1️⃣ 最推荐的位置（仓库根目录）

```
your-project/
│
├─ AGENTS.md
├─ README.md
├─ package.json
├─ src/
│   ├─ main.ts
│   └─ utils.ts
└─ tests/
```

**原因：**

- AI 工具通常会先扫描 **项目根目录**
- 和 `README.md`、`CONTRIBUTING.md` 类似
- 对整个项目生效

------

### 2️⃣ 如果只想限制某个目录

也可以放在子目录：

```
your-project/
│
├─ src/
│   ├─ AGENTS.md
│   ├─ api/
│   └─ utils/
│
└─ scripts/
    └─ AGENTS.md
```

含义：

- `src/AGENTS.md` → 只规范 `src` 代码
- `scripts/AGENTS.md` → 只规范脚本

很多 **Agent系统会按目录向上查找规则**。

------

### 3️⃣ 实际 AI 工具的读取方式

一般是：

```
当前文件目录
   ↑
父目录
   ↑
项目根目录
```

如果发现 `AGENTS.md` 就会应用规则。

------

### 4️⃣ 推荐结构（最佳实践）

```
your-project/
│
├─ README.md        # 项目介绍
├─ AGENTS.md        # AI编码规则
├─ .gitignore
├─ package.json
│
├─ src/
│   ├─ api/
│   ├─ core/
│   └─ utils/
│
└─ tests/
```

------

✅ **结论：**

最简单做法：

```
项目根目录/AGENTS.md
```

------

💡 另外告诉你一个 **90%人不知道的技巧**：
如果你想让 AI **100%强制写中文注释**，`AGENTS.md` 可以写成 **“硬规则版本”**，AI基本不敢违反。

## agents.md 和 .cursor/rules、CLAUDE.md 的区别

| 文件            | 作用                           |
| --------------- | ------------------------------ |
| `AGENTS.md`     | 通用 AI Agent 规则（通用标准） |
| `.cursor/rules` | Cursor 专用规则                |
| `CLAUDE.md`     | Claude Code 专用规则           |
| `README.md`     | 人类看的项目介绍               |



## 作为一名程序员，如何在AI统治人类的大潮中生存？

qwen3-max的回答：

✅**成为“AI 的指挥官”，而非“被 AI 指挥的码农”**

- 精通 **Prompt Engineering + AI 工作流设计**：
  不是让 AI 写代码，而是设计“人类 + AI 协作流程”。
- 掌握 **AI 应用开发**：RAG、Agent、微调、评估——构建 AI 原生应用。
- 学会 **验证、测试、调试 AI 生成的代码**：AI 会犯隐蔽错误，你需要“守门”。

> 🛠️ 你的新角色：**AI 软件工程师（AI Software Engineer）** 



✅**构建“反脆弱”职业护城河**

|              |                |
| ------------ | -------------- |
| 写样板代码   | 定义问题边界   |
| 查文档调 API | 设计系统架构   |
| 修简单 Bug   | 调试分布式死锁 |
| 执行需求     | 质疑需求合理性 |
| 单打独斗     | 跨领域整合     |

**策略：主动做右边的事。**

## [在PyCharm中提升编程效率：通义灵码（DeepSeek）助手全攻略（新版）](https://www.cnblogs.com/alisystemsoftware/p/18791469)

