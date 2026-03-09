### openclaw

[Clawdbot（Openclaw）安装与接入飞书、deepseek教程](https://zhuanlan.zhihu.com/p/2001383801151058763)

不使用clawbot了，直接用openclaw。

本文讲解如何安装使用最近大火的clawdbot，中间由于和Claude code的法律纠纷改名为moltbot，这两天又又又改名为openclaw。本文以最新的openclaw为例，详细介绍Mac上如何安装openclaw并配置飞书为聊天工具。废话不说这就开始。

mv OpenClaw /mnt/g/Projects/projects_ai/openclaw



本机位置：

/mnt/g/Projects/projects_ai/openclaw

G:\Projects\projects_ai\openclaw



#### 安装后

State dir: /home/ury/.clawdbot → /home/ury/.openclaw (legacy path now symlinked)



工作目录：/mnt/g/Projects/projects_ai/openclaw/workspace



#### 安装配置

url:https://portal.qwen.ai/v1. 

Override models.providers.qwen-portal.baseUrl if needed.



Default model:qwen-portal/coder-model

Gateway port:18789

Gateway bind:Loopback (127.0.0.1)

Gateway auth:Token



Gateway token (blank to generate)

Needed for multi-machine or non-loopback access



◇  Channel status ────────────────────────────╮
│                                             │
│  Telegram: not configured                   │
│  WhatsApp: not configured                   │
│  Discord: not configured                    │
│  Google Chat: not configured                │
│  Slack: not configured                      │
│  Signal: not configured                     │
│  iMessage: not configured                   │
│  Feishu: install plugin to enable           │
│  Google Chat: install plugin to enable      │
│  Nostr: install plugin to enable            │
│  Microsoft Teams: install plugin to enable  │
│  Mattermost: install plugin to enable       │
│  Nextcloud Talk: install plugin to enable   │
│  Matrix: install plugin to enable           │
│  BlueBubbles: install plugin to enable      │
│  LINE: install plugin to enable             │
│  Zalo: install plugin to enable             │
│  Zalo Personal: install plugin to enable    │
│  Tlon: install plugin to enable

​	

#### 大模型Oauth

打开命令：

vim ~/.openclaw/agents/main/agent/auth-profiles.json

```json
{
  "version": 1,
  "profiles": {
    "qwen-portal:default": {
      "type": "oauth",
      "provider": "qwen-portal",
      "access": "",
      "refresh": "",
      "expires": 1770201949250
    }
  }
}
```



#### 大模型配置

vim ~/.openclaw/agents/main/agent/models.json

```json
{
  "providers": {
    "qwen-portal": {
      "baseUrl": "https://portal.qwen.ai/v1",
      "api": "openai-completions",
      "models": [
        {
          "id": "coder-model",
          "name": "Qwen Coder",
          "reasoning": false,
          "input": [
            "text"
          ],
          "cost": {
            "input": 0,
            "output": 0,
            "cacheRead": 0,
            "cacheWrite": 0
          },
          "contextWindow": 128000,
          "maxTokens": 8192
        },
        {
          "id": "vision-model",
          "name": "Qwen Vision",
          "reasoning": false,
          "input": [
            "text",
            "image"
          ],
          "cost": {
            "input": 0,
            "output": 0,
            "cacheRead": 0,
            "cacheWrite": 0
          },
          "contextWindow": 128000,
          "maxTokens": 8192
        }
      ],
      "apiKey": "qwen-oauth"
    }
  }
}

```

### bugs

#### bug无法安装飞书插件:

##### **description:**



When execute code:

当ubuntu子系统输入以下命令：

```
openclaw onboard
```



Exception output:

无法安装feishu插件

```bash
◇  Install Feishu plugin?
│  Download from npm (@openclaw/feishu)
Downloading @openclaw/feishu…
Extracting /tmp/openclaw-npm-pack-CS5w5f/openclaw-feishu-2026.2.2.tgz…
Installing to /home/ury/.openclaw/extensions/feishu…
12:37:51 [plugins] feishu failed to load from /home/ury/.openclaw/extensions/feishu/index.ts: Error: Cannot find module 'zod'
Require stack:
- /home/ury/.openclaw/extensions/feishu/src/config-schema.ts
│
◇  Channel setup ───────────────────────────╮
│                                           │
│  feishu does not support onboarding yet.  │
│                                           │
├───────────────────────────────────────────╯
```



##### **solution:**





### 📍 **OpenClaw 安装位置**

#### **1. 可执行文件位置：**

```
/home/ury/.nvm/versions/node/v22.17.0/bin/openclaw
```

这是一个符号链接，指向真正的入口文件。

#### **2. 真实入口文件位置：**

```
/home/ury/.nvm/versions/node/v22.17.0/lib/node_modules/openclaw/openclaw.mjs
```

这是实际的 JavaScript 入口文件。

#### **3. npm 全局模块位置：**

```
/home/ury/.nvm/versions/node/v22.17.0/lib/node_modules/openclaw/
```

这是 OpenClaw 的完整安装目录。

#### **4. 版本信息：**

```
2026.2.2-3
```

---

### 🔍 **关于你的环境**

从输出可以看出：

1. 你使用的是 **nvm**（Node Version Manager）管理 Node.js
2. Node.js 版本是 `v22.17.0`
3. 安装方式是 **npm 全局安装**（不是 git 方式）
4. 安装位置是 nvm 的版本特定目录

---

### 📂 **完整的安装路径结构**

```
/home/ury/.nvm/versions/node/v22.17.0/
├── bin/
│   └── openclaw (符号链接)
├── lib/
│   └── node_modules/
│       └── openclaw/ (完整模块目录)
│           ├── openclaw.mjs (入口文件)
│           ├── package.json
│           ├── dist/
│           └── ... (其他文件)
```

---

### 🔧 **如何验证和访问**

```bash
## 1. 查看完整的安装目录
ls -la /home/ury/.nvm/versions/node/v22.17.0/lib/node_modules/openclaw/

## 2. 查看符号链接详细信息
ls -la $(which openclaw)

## 3. 查看包信息
cd /home/ury/.nvm/versions/node/v22.17.0/lib/node_modules/openclaw
cat package.json | grep -E '"name"|"version"'

## 4. 查看所有全局安装的包
npm list -g --depth=0
```

---

### ⚠️ **注意事项**

1. **这是 nvm 的标准目录结构**：nvm 为每个 Node.js 版本创建独立的目录

2. **如果你想卸载**：

   ```bash
   npm uninstall -g openclaw
   ```

3. **如果你想查看配置文件**：配置文件通常在 `~/.openclaw/` 目录下，而不是安装目录

4. **如果你切换 Node.js 版本**：需要重新安装 OpenClaw，因为每个 nvm 版本有独立的全局模块目录

---

所以总结来说，你的 **OpenClaw 安装在 nvm 的版本特定目录中**，这是完全正常的 nvm 使用方式！🎯