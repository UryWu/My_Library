

## [Qwen3 Coder！开源模型挑战 Claude 4](https://mp.weixin.qq.com/s/feoAQV5qJoJ5xfZIEDinKw)

命令行启动命令：

```
qwen
```

## claude 2.x

本文参考：

[claudecode安装教程国内使用绕过登录实现模型自【超详细安装步骤】](https://www.bilibili.com/video/BV19vc5zUEeQ/)

### 安装



cmd打开命令行，查看当前node环境：

```shell
nvm list
```

output:

```
C:\Users\UryWu>nvm list

    24.13.1
  * 20.4.0 (Currently using 64-bit executable)
    18.16.1
```

安装claude-code 2.0

```shell
npm uninstall -g claude-code-router
```

查看当前node环境安装的所有包：

```shell
npm list -g --depth=0
```

output:

```
E:\nodejs -> .\
+-- @anthropic-ai/claude-code@2.1.69
+-- @qwen-code/qwen-code@0.9.0
+-- corepack@0.19.0
+-- npm-check-updates@16.10.15
+-- npm@9.8.0
+-- openskills@1.5.0
`-- yarn@1.22.22
```

往[.claude.json](C:\Users\UryWu\.claude.json)里面的最后增加配置项：

```json
"hasCompletedOnboarding":true
```



### 打开claude

cmd命令行输入：

```shell
claude
```

### [接入deepseek大模型](https://www.bilibili.com/video/BV19vc5zUEeQ?t=343.4)

打开claude后会显示未登录：

```
  ? for shortcuts                                   Not logged in · Run /login
```

需要安装[CC-Switch-v3.11.1-Windows.msi](https://github.com/farion1231/cc-switch/releases/download/v3.11.1/CC-Switch-v3.11.1-Windows.msi)，安装包根据你的系统选择，我这里是windows10。

CC-Switch默认安装位置：

```shell
C:\Users\UryWu\AppData\Local\Programs\CC Switch\

C:\Users\UryWu\AppData\Local\Programs\CC Switch\cc-switch.exe
```

打开CC-Switch后，按照视频的步骤添加deepseek的api key。

再次打开claude后，不显示未登录红色Not logged in提示。

### [在vs code中使用claude code](https://www.bilibili.com/video/BV19vc5zUEeQ?t=487.6)

在vs code中搜索插件：Claude Code for VS Code

注意发布者是：Anthropic anthropic.com





## claude 1.x

### 弃用1.x的卸载记录

我已经把ubuntu WSL里面的claude-code和claude-code-router卸载了。

按下windows键位，敲入ubuntu，双击选择。

查看当前使用的node：

```shell
nvm current
```

output:

```
v22.17.0
```

列出当前node安装的所有包：

```shell
npm list -g --depth=0
```

output:

```
/home/ury/.nvm/versions/node/v22.17.0/lib
├── @anthropic-ai/claude-code@1.0.51
├── @musistudio/claude-code-router@1.0.15
├── clawdbot@2026.1.24-3
├── corepack@0.33.0
├── npm@11.4.2
└── openclaw@2026.2.2-3
```

卸载两个包：

```shell
npm uninstall -g @anthropic-ai/claude-code
npm uninstall -g @musistudio/claude-code-router
```



在WSL中如何打开图形化的资源管理器？输入：

```shell
cd /home/ury/.nvm/versions/node/
explorer.exe .
```



### [musistudio/claude-code-router](https://github.com/musistudio/claude-code-router?tab=readme-ov-file)

过程参考标题链接。



#### api、模型配置文件在：

```
/home/ury/.claude-code-router/config.json
```

或：

```shell
~/.claude-code-router/config.json
```

#### 启动服务：

```bash
ccr code
```

下面这个命令不用打，ccr code之后，自动会启动服务，如果ccr code没用，就先打下面的这个命令：

```bash
ccr start --debug
```



然后在你要编辑的代码项目那里再打开一个wsl，然后输入：

```shell
claude
```

或者：

```shell
ccr code
```

这时还要输入一次选择模型的语句：

```shell
/model deepseek,deepseek-chat
```

注意deepseek和deepseek-chat之间不能有空格，否则报错。他们之间只有一个逗号。



#### 查看服务状态

```shell
ccr status
```

或者：

```shell
ccr code
```

之后，再输入：

```shell
/status
```



#### 查看claude-code信息：

```shell
npm show @@anthropic-ai/claude-code
```



```shell
npm show @musistudio/claude-code-router
```



#### 安装带剪贴板的vim

```shell
sudo apt install vim-gtk3
```

##### 方法一：Vim 命令模式粘贴剪贴板

1. **按 `Esc`** 进入普通模式，记住这里不是命令/末行模式 shift+:
2. 输入以下命令粘贴：

```bash
"+p
```

说明：

- `"+` 表示系统剪贴板（和 Ctrl+C/Ctrl+V 通用）
- `p` 表示“put”（粘贴）

你也可以使用 `"*p` 粘贴“选择板”内容（苹果系统的程序复制行为会进入不同的寄存器）

------

##### 方法二：复制 Vim 中的内容到剪贴板

- 选中文本（按 `v` 进入可视模式）
- 移动光标选中文本
- 然后复制到剪贴板：

```bash
"+y
```

说明：

- `y` 表示“yank”（复制）
- `"+` 表示复制到系统剪贴板

##### [批量复制](https://www.bilibili.com/video/BV1P741187Bh/)

怎样在vim中复制内容到系统剪贴板
按v进入visual模式
选取要复制的内容
直接连续输入 (不是在命令行模式中)"+y
复制所有内容命令是 gg"+yG
可以把编辑.vimrc把命令map到ctrl+c
如果用苹果的OS X系统命令为"*y

#### 配置模型文件

```
vim ~/.claude-code-router/config.json
```

##### deepseek和gemini的配置

<>中为需要填入的api key。

```json
{
  "LOG": false,
  "OPENAI_API_KEY": "",
  "OPENAI_BASE_URL": "",
  "OPENAI_MODEL": "",
    
    "Providers": [
        {
          "name": "deepseek",
          // IMPORTANT: api_base_url must be a complete (full) URL.
          "api_base_url": "https://api.deepseek.com/chat/completions",
          "api_key": "<api_key>",
          "models": ["deepseek-chat", "deepseek-reasoner"],
          "transformer": {
            "use": ["deepseek"],
            "deepseek-chat": {
              // Enhance tool usage for the deepseek-chat model using the ToolUse transformer.
              "use": ["tooluse"]
            }
          }
        },
        {
            "name": "gemini",
            // IMPORTANT: api_base_url must be a complete (full) URL.
            "api_base_url": "https://generativelanguage.googleapis.com/v1beta/models/",
            "api_key": "<api_key>",
            "models": ["gemini-2.5-flash", "gemini-2.5-pro"],
            "transformer": {
            "use": ["gemini"]
            }
        }
      ],
      "Router": {
        "default": "deepseek,deepseek-chat", // IMPORTANT OPENAI_MODEL has been deprecated
        "think": "deepseek,deepseek-reasoner",
        "longContext": "gemini,gemini-2.5-flash"
      }

    
}
```



<>中为需要填入的api key。

```bash
export ANTHROPIC_BASE_URL=https://api.deepseek.com/chat/completions

export ANTHROPIC_AUTH_TOKEN=<api_key>
```



##### 可用的旧deepseek的配置

<>中为需要填入的api key。

```json
{
  "LOG": false,
  "OPENAI_API_KEY": "",
  "OPENAI_BASE_URL": "",
  "OPENAI_MODEL": "",
  "Providers": [
    {
      "name": "deepseek",
      "api_base_url": "https://api.deepseek.com/chat/completions",
      "api_key": "<api_key>",
      "models": ["deepseek-chat", "deepseek-reasoner"],
      "transformer": {
        "use": ["deepseek"],
        "deepseek-chat": {
          "use": ["tooluse"]
        }
      },
      "max_tokens": 8192
    }
  ],
  "Router": {
    "default": "deepseek,deepseek-chat",
    "think": "deepseek,deepseek-reasoner"
  }
}
```



##### 不可用的旧gemini的配置

<>中为需要填入的api key。

```json
{
  "LOG": false,
  "OPENAI_API_KEY": "",
  "OPENAI_BASE_URL": "",
  "OPENAI_MODEL": "",
  "Providers": [
    {
      "name": "gemini",
      "api_base_url": "https://generativelanguage.googleapis.com/v1beta/models/",
      "api_key": "<api_key>",
      "models": ["gemini-2.5-flash", "gemini-2.5-pro"],
        "transformer": {
            "use": ["gemini"],
            "gemini-2.5-flash": {
            "use": ["tooluse"]
        	}
        }
      },
      "max_tokens": 8192
    }
  ],
  "Router": {
    "default": "gemini,gemini-2.5-flash",
    "think": "gemini,gemini-2.5-pro"
  }
}
```

#### curl测试模型链接

```shell
curl http://127.0.0.1:3456/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"model":"deepseek-chat", "messages":[{"role":"user","content":"hello"}]}'
```

<>中为需要填入的api key。

```shell
curl "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent" \
  -H 'Content-Type: application/json' \
  -H 'X-goog-api-key: <api_key>' \
  -X POST \
  -d '{
    "contents": [
      {
        "parts": [
          {
            "text": "Explain how AI works in a few words"
          }
        ]
      }
    ]
  }'
```



### 使用

#### 🚀 1. 启动后进入交互模式

```
ccr code
```

这会启动 Claude Code 的 REPL（命令行交互界面），你可以直接进行对话、提需求、让它编写代码等。

------

#### 🔧 2. 切换模型（可选）

使用 `/model` 命令切换路由中的模型与提供者。例如：

```
/model openrouter,anthropic/claude-3.5-sonnet
```

这告诉 Claude Code 用 `openrouter` 提供者下的 `anthropic/claude-3.5-sonnet` 模型来处理后续所有任务 [YouTube+15GitHub+15GitHub+15](https://github.com/musistudio/claude-code-router?utm_source=chatgpt.com)。

------

#### 🛠 3. 常用命令和最佳实践

这些用法和原生 Claude Code 相同，CCR 保留了所有交互功能：

- **`/init`**：生成一个初始的 `CLAUDE.md`，便于项目内容注入上下文 [GitHub+2Anthropic+2harper.blog+2](https://www.anthropic.com/engineering/claude-code-best-practices?utm_source=chatgpt.com)。
- **`/permissions`**：管理文件编辑、Bash、网络请求等权限，确保只有信任工具被执行 [Anthropic+1Anthropic+1](https://www.anthropic.com/engineering/claude-code-best-practices?utm_source=chatgpt.com)。
- **`#`、`think`、`ultrathink`** 等：开启规划或深入思考模式，帮助模型“慢思考” [Reddit](https://www.reddit.com/r/ClaudeAI/comments/1lkfz1h/how_i_use_claude_code/?utm_source=chatgpt.com)。

------

#### 📄 4. 使用 `CLAUDE.md` 提升上下文质量

在项目根目录设置 `CLAUDE.md` 来定义常用脚本、项目结构、开发规范等，启动后 Claude 会自动加载这些文件，提高指导质量 [GitHub+3Anthropic+3Anthropic+3](https://www.anthropic.com/engineering/claude-code-best-practices?utm_source=chatgpt.com)。

------

#### 📌 小结流程表

| 步骤 | 操作命令                                                |
| ---- | ------------------------------------------------------- |
| 1    | `ccr code` → 进入 Claude Code 的命令行界面              |
| 2    | 使用 `/model provider,model` 在配置的模型间切换（可选） |
| 3    | 发起命令（如“帮我写个函数”“修复这个 bug” 等）           |
| 4    | 使用 `/permissions`, `/init`, `think` 等管理行为        |



------

#### ✅ 最终提示

CCR 相当于在原生 Claude Code 基础上添加了「路由功能」，你只需按常规使用 Claude Code 即可。而 CCR 提供的 `/model` 命令，可以自由在你配置文件（`~/.claude-code-router/config.json`）中定义的模型间切换 [Anthropic+12GitHub+12GitHub+12](https://github.com/musistudio/claude-code-router?utm_source=chatgpt.com)[Anthropic](https://www.anthropic.com/engineering/claude-code-best-practices?utm_source=chatgpt.com)。

如果你希望 CCR 自动接受文件编辑、自动 commit，建议检查 `.claude/settings.json` 或项目中的 `.claude/settings.local.json`，确保 `defaultMode`、`permissions` 设置允许自动写入和应用编辑 [Hacker News+11Anthropic+11Anthropic+11](https://docs.anthropic.com/en/docs/claude-code/settings?utm_source=chatgpt.com)。

------

如你在使用过程中遇到“能看到 Claude Code 打印 `file edited` 但实际并未改动文件”之类问题，可能是权限配置或自动认可机制没开启，建议检查 `/permissions` 和 `auto-accept` 设置；也可参考社区 Issue #95 对应的提问 [GitHub](https://github.com/musistudio/claude-code-router/issues/95?utm_source=chatgpt.com)。

如果还有具体需求或者遇到报错，随时告诉我，我可以帮你一步步排查！

### bug

#### bug:启动失败没有use "transformer"

##### **description:**



When execute code:





Exception output:





##### **solution:**

[API Error 404 - No endpoints found that support cache control. CCR -v 1.0.14 #122](https://github.com/musistudio/claude-code-router/issues/122)

musistudio 2025年07月12日 周六 15时19分06秒 5 days ago
Owner
I fixed it in version 1.0.15.



robertheessels 2025年07月12日 周六 15时19分21秒 4 days ago
In 1.0.15 this still happens for openrouter,openai/o4-mini-high and my other openrouter models.

I did not have this in my config:

      "transformer": {
        "use": ["openrouter"]
      }
I think my config was created by ccr start.

After I added that, the problem was solved.

#### ccr中并没有实现websearch

musistudio 2025年07月12日 周六 15时24分51秒 last week
Owner
目前ccr中并没有实现webfetch和websearch，这是下一步的计划

#### deepseek的api_base_url

musistudio 2025年07月12日 周六 15时29分16秒 last week
Owner
由于新版本没有使用各类SDK，所以api_base_url需要填写完整的URL地址，deepseek的是
https://api.deepseek.com/chat/completions



