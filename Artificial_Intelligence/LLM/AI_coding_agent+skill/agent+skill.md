
# agent+skill
skill本质是提示词，带有很多提示模板。



## [25% → 90%！别让 Skills 吃灰：Hooks + Commands + Agents 协同激活 AI 全部能力：Claude Code 工程化实践](https://blog.csdn.net/leoisaking/article/details/156203326)

[对应演示视频](https://www.bilibili.com/video/BV1rnBKB2EME)

作者推荐的ruoyi ai原生开发项目：
[【企业级】RuoYi-Vue-Plus AI 智能开发助手 | Claude Code + Codex 双引擎 | 40+ 专业技能包 | 10 大快捷命令 | 开箱即用](https://blog.csdn.net/leoisaking/article/details/157911968)


Skills 只是"可选参考"，AI 会根据自己的判断决定是否调用。而 AI 的判断标准往往是"这个问题看起来需不需要"，而不是"项目规范要求我必须这样做"。

解决方案：强制评估钩子
我们在 .claude/hooks/ 目录下创建了一个关键文件：skill-forced-eval.js。

这个钩子挂载在 UserPromptSubmit 事件上，也就是用户每次提交问题时自动触发。它的作用是：在 AI 开始思考之前，强制输出一段"技能评估指令"。

核心代码逻辑：
```javascript
// skill-forced-eval.js 核心逻辑
const instructions = `## 指令：强制技能激活流程（必须执行）

### 步骤 1 - 评估
针对以下每个技能，陈述：[技能名] - 是/否 - [理由]

可用技能列表：
- crud-development: CRUD/业务模块开发
- api-development: API设计/RESTful规范
- database-ops: 数据库/SQL/建表
- ui-pc: 前端组件/AForm/AModal
- ui-mobile: 移动端/WD UI组件
...（共26个技能）

### 步骤 2 - 激活
如果任何技能为"是" → 立即使用 Skill() 工具激活
如果所有技能为"否" → 说明"不需要技能"并继续

### 步骤 3 - 实现
只有在步骤 2 完成后，才能开始实现。`;

console.log(instructions);

```




## [Agent Skills (Claude Skills) 详细攻略，一期视频精通](https://www.bilibili.com/video/BV1HuiyBQE9G/)


### Skill目录结构

[视频时间戳：](https://www.bilibili.com/video/BV1HuiyBQE9G?t=66.6)

| 类型               | 加载方式 | 位置  |
| :--------------- | :--- | :-- |
| 元数据 (Metadata)   | 必定加载 | 目录  |
| 指令 (Instruction) | 按需加载 | 正文  |
| 资源 (Resource)    | 按需加载 | 附录  |
agent的skills的最大好处是大幅降低了token，每个skill!只占约100 Tokens。

### 安装Claude Code
在VS code、cursor的插件市场里面也能安装。免登录设置同本方法。
[另外的这个文档则通过npm安装](F:\Files\My_Library\Artificial_Intelligence\AI编程工具开发与对比\claude-code_debug.md)

[视频时间戳：](https://www.bilibili.com/video/BV1HuiyBQE9G?t=101.6)
```bash
irm https://claude.ai/install.ps1 iex
```
新建`C:\Users\UryWu\.claude\settings.json`
linux平台：`~/.claude/settings.json`

```json
{ 
	"env": { 
		"ANTHROPIC_AUTH_TOKEN": "", 
		"ANTHROPIC_BASE_URL": "https://open.bigmodel.cn/api/anthropic", 
		"API_TIMEOUT_MS": "3000000", 
		"CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": 1 
	} 
}
```
写入智谱平台的token。
打开：`C:\Users\UryWu\.claude.json`
linux平台：`~/.claude.json`

json中增加以下设置则能跳过登录：
```json
"hasCompletedOnboarding":true,
```


[视频时间戳：](https://www.bilibili.com/video/BV1HuiyBQE9G?t=173.6)
项目目录/.claude/skills/skill-name1/ 

元数据 + 指令
SKILL.md

资源层 (可选) 
scripts/main.py
references/doc.md
assets/pic.png

项目目录/.claude/skills/skill-name2/SKILL.md

### Skill的渐进式设计
[视频时间戳：](https://www.bilibili.com/video/BV1HuiyBQE9G?t=375.5)
![[Pasted image 20260316054646.png]]
也就是SKILLS.md这个文件的下半部分，发给大模型。这里体现了skill提示词，按需加载渐进式披露的设计模式。

技能只给本地项目使用skill则这样放：
`项目目录\.claude\skills\`
全局使用这样放：
`C:\Users\UryWu\.claude\.claude\skills\`

### 技能跨平台迁移
把skills从cloud code迁移到codex，非常的简单，只需要把路径里面的点cloud改成点codex就行了：
项目目录/.claude/skills/skill-name1/
项目目录/.claude/skills/skill-name2/
->
项目目录/.codex/skills/skill-name1/
项目目录/.codex/skills/skill-name2/

#### codex cli使用skills
[视频时间戳：](https://www.bilibili.com/video/BV1HuiyBQE9G?t=474.8)
![[Pasted image 20260316060849.png]]
![[Pasted image 20260316060900.png]]

#### [awesome cloud skills](https://github.com/ComposioHQ/awesome-claude-skills)
千万star skillk库
下载下来，直接放到skills文件夹里。

### 进阶用法资源层
[视频时间戳：](https://www.bilibili.com/video/BV1HuiyBQE9G?t=525.9)

资源层 (可选) 
scripts/main.py
references/doc.md
assets/pic.png

#### 视频转笔记的skill

上一个视频转笔记生成出来的 Markdown 文件中，需要截图的位置都使用了标记占位符，并没有真正的图片。这里我写了一个 Python 脚本，调用 **FFmpeg** 对视频进行截图，然后把标记出来的位置替换成图片的实际链接，这样就可以生成一个图文版的 Markdown 笔记了。

视频转笔记生成出来的 Markdown 文件：
![[Pasted image 20260316062028.png]]

Python 脚本：
![[Pasted image 20260316062055.png]]

新建一个skill，添加调用脚本的提示词：
![[Pasted image 20260316061825.png]]


[视频时间戳：](https://www.bilibili.com/video/BV1HuiyBQE9G?t=638.1)
scripts里面的脚本执行的时候，不占用大模型的token，本地执行的脚本。
![[Pasted image 20260316061613.png]]

### 字幕文件直接拖动到claude code终端窗口
[视频时间戳：](https://www.bilibili.com/video/BV1HuiyBQE9G?t=616.1)
![[Pasted image 20260316062451.png]]

![[Pasted image 20260316062523.png]]

我们注意到，Agent 的 Skills 执行了这个 Python 脚本，而脚本内部的代码并不作为上下文传递给 AI。这样可以在最大程度上降低 SK 的上下文使用量。最后，生成了一个含图片的 Markdown 文件，这样一个带图片的 Markdown 笔记就生成成功了。
![[Pasted image 20260316062739.png]]

### 复制后直接粘贴进claude code终端窗口操作
[视频时间戳：](https://www.bilibili.com/video/BV1HuiyBQE9G?t=683.4)
![[Pasted image 20260316063040.png]]

### skill资源层调用过程
[视频时间戳：](https://www.bilibili.com/video/BV1HuiyBQE9G?t=733.5)
![[Pasted image 20260316063138.png]]
我们再来分析一下它的调用过程。在这个例子里，前面部分的调用过程跟之前是一样的。当 AI 选择了一个 Skill 以后，Cloud Code 把 Skill 的指令细节发送给 AI。由于用户提供的材料是软件相关的，AI 根据指令，意识到需要读取 references 目录里面的范文，学习行文风格。接下来，AI 调用了 read 方法，读取了范文内容。这里体现的是资源层的按需加载，也就是渐进式披露：AI 按照指令的需要，只把它认为必要的文档加载进上下文，最后综合以上所有的信息给出了最终回答。

### Agent Skill与MCP对比
[视频时间戳：](https://www.bilibili.com/video/BV1HuiyBQE9G?t=803.0)

|              | 侧重点  | 类比      | Token消耗 | 核心主体       | 编写难度 |
| ------------ | ---- | ------- | ------- | ---------- | ---- |
| Agent Skills | 提示词  | 带目录的说明书 | 低       | Markdown文件 | 低    |
| MCP          | 工具调用 | 标准化工具箱  | 高       | 软件包        | 高    |
| MCP 2.0 ??   |      | 低       |         |            | 低    |

弹幕：mcp也没多少上下文啊，不都是函数名和函数作用简单说明。
弹幕：这俩确实本来就不冲突,甚至可以相互混合。
弹幕：把代码执行引擎也搞上来，那么Skills 就完美了 

### agent skills跟MCP配合工作
[视频时间戳：](https://www.bilibili.com/video/BV1HuiyBQE9G?t=809.3)
[github-mcp-server](https://github.com/github/github-mcp-server)
这是一个skill里面写提示词，调用github-mcp-server里面的的上传文件工具，上传文件到github的功能的例子。
skill写提示词，mcp-server作为工具。
#### 1 Claude Application Page
打开上面那个github-mcp-server链接，找到Claude Applications并点击。
- [Claude Applications](https://github.com/github/github-mcp-server/blob/main/docs/installation-guides/install-claude.md)- Installation guide for Claude Desktop and Claude Code CLI

在[Claude Applications](https://github.com/github/github-mcp-server/blob/main/docs/installation-guides/install-claude.md)中找到：Remote Server Setup (Streamable HTTP)
1. Run the following command in the terminal (not in Claude Code CLI) 在claude code终端中运行:

```shell
claude mcp add-json github '{"type":"http","url":"https://api.githubcopilot.com/mcp","headers":{"Authorization":"Bearer YOUR_GITHUB_PAT"}}'
```

#### 2 Set GitHub Personal Access Token
最后的YOUR_GITHUB_PAT，需要在[Claude Applications](https://github.com/github/github-mcp-server/blob/main/docs/installation-guides/install-claude.md)中点击[GitHub Personal Access Token](https://github.com/settings/personal-access-tokens/new)：

设置好Token name，比如claude code key
![[Pasted image 20260316065438.png]]

注意在下面把仓库权限改成所有仓库：
![[Pasted image 20260316065552.png]]

[视频时间戳：](https://www.bilibili.com/video/BV1HuiyBQE9G?t=832.3)
在下面的permission里面，我们找到这个管理员的，还有一个内容的：
![[Pasted image 20260316065527.png]]
![[Pasted image 20260316065621.png]]

我们把这两个权限都弄成读写，然后点击创建：
![[Pasted image 20260316065740.png]]

把这个API可以复制下来，填写到命令里面：
![[Pasted image 20260316065820.png]]
这样回车，我们github的MCP server就安装完成了。
```shell
claude mcp add-json github '{"type":"http","url":"https://api.githubcopilot.com/mcp","headers":{"Authorization":"Bearer github_pat_xxxxxxxxxxx"}}'
```
#### 3 skill中写后续上传结果文档处理：
```markdown
## 后续处理
你先检查我名下有没有ai-docs的Github仓库，如果没有就用create_repository MCP工具来创建一个仓库，然后把你刚才写好的文件，用create_or_update_file MCP工具上传到这个仓库。
```

在mcp server的首页一般都有详细的工具介绍
skill写提示词，mcp-server作为工具。

我的例子：

```
你先检查我名下有没有跟本项目根目录同名的Github仓库，如果没有就用create_repository MCP工具来创建一个仓库，然后把git status输出的Changes not staged for commit的所有文件都git add .后，用create_or_update_file MCP工具上传到这个根目录同名的我名下的仓库。
```

```shell
claude mcp add-json github '{"type":"http","url":"https://api.githubcopilot.com/mcp","headers":{"Authorization":"Bearer github_pat_xxxxxxxxxx"}}'
```
#### 评论

#### memory、MCP、SKILL、subagent、claude.md、plug功能冗余
bili_276049285
memory、MCP、SKILL、subagent、claude.md、plug,这些功能多多少少都有点重合了,我能感受到claude公司很想把编程这件事做好,但发力方向又很混乱,这些工具我学了两天总结下来就是相当于我们以前coding时封装的一堆功能函数和目录,如果不是为了节省时间和token,这些完全都没必要存在,这些工具注定是过程产物
2026-01-07 21:55 👍145

再刷是狗
 回复 @bili_276049285 : 非也，mcp的定制化程度远远不如skill，开发难度更是天差地别。尤其是如果不把视野局限在编程范围以内（skills也在Claude客户端里可以得到非常好的使用反馈），skills可以给大模型的加持并不是mcp能比的。
举个例子，我在一小时内定制了我个人的写作skill，润色skill，research skill，甚至prompt generator skill，等七八个skill，并且可以让Claude根据实际需要随时调用它们。 甚至迭代也可以直接让Claude收集信息后直接在内部迭代，然后在客户端里一键更新即可。光是这个开发难度和迭代速度，就意味着它的进化水准绝不是mcp所能比拟的。
还有一点我很同意你说的，为了节省时间和token，这两个恰恰是限制当前大模型最重要的两个条件。
memory是内部索引，mcp是定制难度较高的外部端点索引，skills是高度定制的外接大脑，subagent是随时调用的上下文干净的独立agent，claude.md是独立项目属性索引，plugin目前叠加了mcp，Claude code中的很多plugin本来就是mcp。
我觉得工具多不是坏事，而且目前opus4.5的高智商可以很好的把控这些工具。
2026-01-08 06:01 👍24

何以谓
能发我一下这个hook吗 我理解在rules里面做hook就行
2026-01-12 17:36
#### 强制skill检查的hook提高skill激活率到90%
纸糊糖浆
补充一个从别人项目学来的小知识点：可以增加一个强制skill检查的hook，效果是对每次用户提问回答前都让ai先判断本次交互可能用到的skill并输出理由，然后再正式开启任务。不然很有可能你精心设置的许多skill只有30%的激活率，这样显性认知后能提高到90%正确skill激活
2026-01-07 21:48 👍37
[25% → 90%！别让 Skills 吃灰：Hooks + Commands + Agents 协同激活 AI 全部能力：Claude Code 工程化实践](https://www.bilibili.com/video/BV1rnBKB2EME)

#### 很少项目需要用到大量skill script直接写在项目Claude.md
Marc_hn
我感觉很少项目需要用到大量skill，一般你做之前就知道这件事会用到一两个具体的skill，但如果只用一两个skill意义就不大了，试想如果一本书只有两页，创建一个目录(skill本质就是promt目录)还有必要吗，reference/script这一层的披露直接写在项目Claude.md或者readme不也一样效果吗
2026-01-07 19:09 👍91


UFOTECH
 是的 项目提示词 项目记忆md 和skill 都会有重合，还有一个subagnent呢[doge]本质都是 提示词+工具教程
2026-01-07 19:14 👍16


## agent+skill 实践

### [如何在 Qoder、Cursor、Trae、Windsurf 等 AI Coding 工具中使用 Claude Skills](https://blog.csdn.net/w605283073/article/details/156068170)



### [5 分钟上手 VS Code + Claude Skill，附简单示例](https://zhuanlan.zhihu.com/p/1982218970732986754)

打开 VS Code Insider 里的 Settings, 搜索 **skill ,** 把 "**Use Claude Skills**" 选项勾上

#### **例子 A：**

- 创建一个空文件夹 skill_test, 用 VS Code Insider 打开 skill_test
- 在 skill_test 文件夹下创建 .claude/skills 文件夹
- 我们接着从刚才拉取的 claude skills 仓库中，把 skill-creator 的内容拷贝过来, 顾名思义这个是用来创建skill的skill，我们把内容放到 skills 文件夹下



- 给 VS Code Insider 发如下内容

> create a new skill about pdf text extraction for me

- 查看结果

#### **例子 B:**

- 这次不使用官方给的例子，我们让 gpt 随便写一个简单的，比如修正 md 文件的格式
- 文件内容如下

SKILL.md

~~~text
---
name: format_readme
description: Format and normalize the README markdown file
license: Complete terms in LICENSE.txt
---

# Format README Skill

## Overview
This Claude Skill formats and normalizes README.md files using a custom Python script (`format_readme.py`).

## Purpose
- Remove trailing spaces
- Ensure consistent newline at file end
- Normalize documentation formatting

## Files
- `format_readme.json`: Claude skill definition
- `format_readme.py`: Python script that performs formatting
- `SKILL.md`: This documentation

## Usage
Once installed under `.claude/skills`, you can ask Claude:

"Format my README file."

Claude will automatically invoke:
```
python3 .claude/skills/format_readme.py README.md
```

## Parameters
- `path` (optional): Path to the README file. Defaults to `README.md`.

## Safety
This script only modifies the specified markdown file and does not delete any files.
~~~



format_readme.py

```python
import sys
from pathlib import Path

def format_readme(path: str):
    p = Path(path)
    if not p.exists():
        print(f"[ERROR] File not found: {path}")
        return

    content = p.read_text(encoding="utf-8")

    formatted = "\n".join(line.rstrip() for line in content.splitlines()).strip() + "\n"

    p.write_text(formatted, encoding="utf-8")
    print(f"[OK] README formatted: {p.resolve()}")

if __name__ == "__main__":
    target = sys.argv[1] if len(sys.argv) > 1 else "README.md"
    format_readme(target)
```



接着发送如下消息

> Format my README file

查看执行过程如下，并且 README.md 也可以 format



### [Kiro 深度使用介绍 | 亚马逊挑战Cursor重建开发流程](https://blog.csdn.net/heiyeshuwu/article/details/149491228)

#### 第一步：原始需求

假设我们的spec（需求规格如下，示例）：

```
### 用户注册功能规格说明书
 
#### 1. 需求概述
用户可以通过邮箱和密码创建账户，并接收验证邮件。
 
#### 2. 功能细节
- **输入字段**：
  - 邮箱地址（格式验证）
  - 密码（至少8位，包含字母和数字）
  - 确认密码
  - 同意隐私政策（勾选框）
 
- **业务逻辑**：
  - 邮箱已注册时提示错误
  - 密码不一致时提示错误
  - 注册成功后发送验证邮件
  - 用户需点击邮件中的链接激活账户
 
#### 3. 技术实现
- **API 接口**：
  - POST /api/register
    - 请求参数：{ email, password, agreeTerms }
    - 响应：201（成功）或 400（错误）
 
- **数据库表**：
  - users 表：id, email, password_hash, is_verified, created_at
```

然后它就会在 .kiro/specs 目录下面创建一个用户注册目录下面生产对应的需求文档：

#### 扩充需求

它针对我们上面模糊的需求文档明显做了很多的扩充工作，变成了一个个的用户故事，它扩充后的：

```
# 需求文档
 
## 介绍
 
用户注册功能允许新用户通过提供邮箱地址和密码来创建账户。系统将验证用户输入的信息，创建账户后发送验证邮件，用户需要通过邮件激活账户才能完成注册流程。
 
## 需求
 
### 需求 1
 
**用户故事：** 作为一个新用户，我希望能够使用邮箱和密码注册账户，以便我可以访问系统功能。
 
#### 验收标准
 
1. 当用户访问注册页面时，系统应当显示包含邮箱、密码、确认密码和隐私政策同意选项的注册表单
2. 当用户输入邮箱地址时，系统应当验证邮箱格式的有效性
3. 当用户输入密码时，系统应当验证密码至少包含8个字符且包含字母和数字
4. 当用户输入确认密码时，系统应当验证确认密码与原密码一致
5. 当用户未勾选隐私政策同意选项时，系统应当阻止注册并显示错误提示
 
### 需求 2
 
**用户故事：** 作为系统管理员，我希望防止重复邮箱注册，以便维护用户数据的唯一性。
 
#### 验收标准
 
1. 当用户使用已注册的邮箱地址注册时，系统应当返回错误信息"该邮箱已被注册"
2. 当用户使用未注册的邮箱地址时，系统应当允许继续注册流程
3. 系统应当在数据库中检查邮箱地址的唯一性
 
### 需求 3
 
**用户故事：** 作为一个新注册用户，我希望收到邮箱验证邮件，以便我可以激活我的账户。
 
#### 验收标准
 
1. 当用户成功提交注册信息时，系统应当创建未激活状态的用户账户
2. 当账户创建成功时，系统应当向用户邮箱发送包含激活链接的验证邮件
3. 当用户点击邮件中的激活链接时，系统应当将用户账户状态更新为已激活
4. 当用户尝试使用未激活账户登录时，系统应当提示"请先激活您的账户"
 
### 需求 4
 
**用户故事：** 作为开发者，我希望有清晰的API接口来处理用户注册，以便前端可以正确调用注册功能。
 
#### 验收标准
 
1. 当前端发送POST请求到/api/register端点时，系统应当接收包含email、password和agreeTerms字段的JSON数据
2. 当注册成功时，系统应当返回HTTP状态码201和成功消息
3. 当注册失败时，系统应当返回HTTP状态码400和具体的错误信息
4. 当服务器内部错误时，系统应当返回HTTP状态码500和通用错误消息
 
### 需求 5
 
**用户故事：** 作为系统架构师，我希望有合适的数据库结构来存储用户信息，以便支持用户管理功能。
 
#### 验收标准
 
1. 系统应当创建users表包含以下字段：id（主键）、email（唯一索引）、password_hash、is_verified、created_at
2. 当存储用户密码时，系统应当使用安全的哈希算法而不是明文存储
3. 当创建新用户记录时，系统应当自动设置created_at为当前时间戳
4. 当用户激活账户时，系统应当将is_verified字段更新为true
```



#### 第二步：进行技术设计（Design）



我们跟Kiro讲继续下一步，它会进入技术设计：

![Image](72e43035b6d1fa580943c6544c816dc1.png)

如果对它产出的技术设计不满意，还可以互动迭代修改：

调整技术设计，数据库使用QLit,去掉邮件发送服务，增加短信发送服务（调用阿里云短信发送服务），前端库增加Tailwind、Nextjs、ShadCN



Kiro 经过几轮迭代后生成的完整设计：
[[agent+skill：设计文档]]
[agent+skill：设计文档.md](F:\Files\My_Library\Artificial_Intelligence\LLM\AI_coding_agent+skill\agent+skill：设计文档.md)

#### 第三步：制定实施计划（Task）

下一步就是生成实施计划，就是生成执行中需要的Task：

检查没问题，最后生产的 task.md 内容如下：
[[agent+skill：实施计划]]
[agent+skill：实施计划.md](F:\Files\My_Library\Artificial_Intelligence\LLM\AI_coding_agent+skill\agent+skill：实施计划.md)

#### 第四步：按照实施计划进行最终编程开发（Code）

执行实施计划：

指定某一项进行执行，在task.md文件打开它在每个section上面都有一个 Start task 按钮，点击即可执行这个环节中的任务：

```markdown
Start task
[ ] 11. 全局错误处理中间件
- 实现全局错误捕获和处理中间件
- 创建标准化错误响应格式
- 实现不同类型错误的分类处理
- 实现错误日志记录功能
- 编写错误处理中间件测试用例
- _需求: 需求4.2, 需求4.3, 需求4.4_

Start task
[ ] 12. 前端Zustand状态管理store
- 创建用户注册相关的Zustand状态store
- 实现表单数据状态管理
- 实现API调用状态管理（loading、error、success状态）
- 实现验证码发送状态和倒计时管理
- 编写状态管理逻辑单元测试
- _需求: 需求1.1, 需求3.1_
```

也可以直接指令，然后从头开始一个个执行：

约定好执行以后，它就会像 Cursor/Winsurf/Augment 一样去执行任务：

会自动生成对应的项目README，在中间也包含了项目任务进展：



中间如果它停止或者是某些 task.md 没有顺利完成，那么就需要人工让它更新 task.md 和按照对应步骤进行执行：

在所有代码完成以后，还需要让它跟需求、设计等进行比对，看是否完整实现了：

## agent+skill 理论

[官网](https://agentskills.io/)

[github例子](https://github.com/anthropics/skills/blob/main/skills/algorithmic-art/SKILL.md)

### [重点 别再造Agent了！关于Agent Skills的详细总结来了](https://zhuanlan.zhihu.com/p/1986802048608527579)

#### 二、什么是 Agent Skills？

##### 1. 核心设计理念

**Agent Skills 是一种标准化的程序性知识封装格式**。如果说 MCP 为智能体提供了"手"来操作工具，那么 Skills 就提供了"操作手册"或"SOP（标准作业程序）"，教导智能体如何正确使用这些工具。

这种设计理念源于一个简单但深刻的洞察：**连接性（Connectivity）与能力（Capability）应该分离**。MCP 专注于前者，Skills 专注于后者。这种职责分离带来了清晰的架构优势：

- **MCP 的职责**：提供标准化的访问接口，让智能体能够"够得着"外部世界的数据和工具
- **Skills 的职责**：提供领域专业知识，告诉智能体在特定场景下"如何组合使用这些工具"

#### 三、Agent Skills vs MCP：本质区别与协作关系

1. 从工程视角理解差异

让我们通过一个具体的例子来理解这种差异。假设你要构建一个智能体来帮助团队进行代码审查：

**MCP 的职责**：

```
# MCP 提供对 GitHub 的标准化访问 github_mcp = MCPTool(server_command=["npx","-y","@modelcontextprotocol/server-github"]) # MCP 暴露的工具（简化示例）： # - list_pull_requests(repo, state) # - get_pull_request_details(pr_number) # - list_pr_comments(pr_number) # - create_pr_comment(pr_number, body) # - get_file_content(repo, path, ref) # - list_pr_files(pr_number)
```

MCP 让智能体"能够"访问 GitHub，能够调用这些 API。但它不知道"应该"做什么。

**Skills 的职责**：

`--- name: code-review-workflow description: 执行标准的代码审查流程，包括检查代码风格、安全问题、测试覆盖率等 --- # 代码审查工作流 ## 审查清单 当执行代码审查时，按以下步骤进行： 1.**获取 PR 信息**：调用`get_pull_request_details`了解变更背景 2.**分析变更文件**：调用`list_pr_files`获取文件列表 3.**逐文件审查**： -对于`.py`文件：检查是否符合 PEP 8，是否有明显的性能问题 -对于`.js/.ts`文件：检查是否有未处理的 Promise，是否使用了废弃的 API -对于测试文件：验证是否覆盖了新增的代码路径 4.**安全检查**： -是否硬编码了敏感信息（密钥、密码） -是否有 SQL 注入或 XSS 风险 5.**提供反馈**： -严重问题：使用`create_pr_comment`直接评论 -建议改进：在总结中提出 ## 公司特定规范 -所有数据库查询必须使用参数化查询 -API 端点必须有权限验证装饰器 -新功能必须附带单元测试（覆盖率 > 80%） ## 示例评论模板 **严重问题**： ⚠️ 安全风险：第 45 行直接拼接 SQL 字符串，存在注入风险。 建议改用参数化查询：`cursor.execute("SELECT * FROM users WHERE id = ?", (user_id,))``

Skills 告诉智能体"应该"做什么、如何组织审查流程、需要关注哪些公司特定的规范。它是领域知识和最佳实践的容器。

![img](v2-f740a85a64e55fec0bf514183046f3c5_1440w.jpg)



#### 七、Agent Skills 和 MCP 总结与选型

Agent Skills 和 MCP 代表了智能体技术栈中两个关键的抽象层：

- **MCP（Model Context Protocol）**：解决"连接性"问题，是智能体与外部世界交互的标准化接口，相当于"神经系统"或"双手"
- **Agent Skills**：解决"能力"问题，是领域知识和工作流的封装，相当于"大脑皮层"或"操作手册"

![img](v2-90e2f9eb7fc891d8276d78eca88ac5df_1440w.jpg)



#### **实践建议**：

- 对于**外部服务连接**（数据库、API、云服务），优先使用 MCP
- 对于**复杂工作流**（多步骤任务、领域专业知识），优先使用 Skills
- 在**上下文受限**的场景（长对话、大量工具），使用 Skills 进行渐进式管理
- 构建**企业级智能体**时，采用 MCP + Skills 的分层架构





### 多agent的问题，agent+skill和web单体、微服务区别

下面我分 **「讨论共识 → 分歧点 → 核心原理 → 用工程视角还原 skills 到底解决了什么」** 四个层次，把整段讨论压缩成一个**可理解、可复用的认知模型**，尽量不用营销话术，也不站队。

------

#### 一、这场讨论的**共识**是什么？

其实你们已经达成了不少一致，只是表述角度不同。

##### 1️⃣ 大模型能力本身没有质变

- 依然是 **token 预测**
- 没有“因为 skills 就突然变聪明”
- 不存在“AI 逻辑层面革命”

✔️ 这是所有人都同意的

------

##### 2️⃣ Anthropic 的 skills 不是“新能力”，而是**工程组织方式的变化**

- 不等于功能升级
- 更像一种 **Agent 的工程范式**
- 解决的是“怎么把能力组织起来、用得更稳定”

✔️ 你把它类比成：

- 微服务 → 单体多模块
- agent mesh → agent + skills
  这个类比在**结构层面**是成立的

------

#### 二、真正的分歧点在哪里？

分歧**不在“结构像不像 Web”**，而在这一句：

> **skills 只是工程结构优化，不能解决功能性问题吗？**

你认为：

> *它解决的是“怎么写代码”，不是“能不能把事做好”*

vicat_47 的核心反驳是：

> *在 AI Agent 里，「工程结构」本身就是「能力的一部分」，因为它直接决定上下文质量*

👉 **分歧的本质不是“要不要 skills”，而是：**

> **你是否把「上下文」视为 Agent 的核心能力载体**

------

#### 三、关键概念拆解：AI 里的「上下文」到底是什么？

这是理解 skills 的**钥匙**

##### ❌ 不是只有 Prompt

上下文 ≠ 一段提示词
而是一个**动态演化的信息集合**

##### ✅ AI Agent 的上下文通常包含：

1. **当前任务目标**
2. **已完成步骤 & 中间推理结果**
3. **可用工具 / 能力列表**
4. **环境状态（文件、代码、外部系统返回）**
5. **约束条件 & 不该做什么**
6. **长期 or 短期记忆**

👉 换句话说：

> **Agent 的“能力” = 模型能力 × 上下文质量**

------

#### 四、为什么「多 Agent」会把上下文问题放大？

这是你直觉里觉得“多 agent 很麻烦”的根源。

##### 多 Agent 的典型问题

假设是 **Plan → Sub-agent 执行 → 汇总**

那么每一步都要面对：

- ❓ 要不要把所有上下文传给子 agent？
- ❓ 传多少？（token 爆炸）
- ❓ 子 agent 产生的新信息怎么回流？
- ❓ 多个 agent 的理解是否一致？
- ❓ 中间状态是否丢失、被简化、被误解？

📌 这不是「实现麻烦」
而是 **上下文天然会被切碎**

------

#### 五、skills 真正解决的不是「功能」，而是这个问题

##### 👉 skills 的核心目标只有一个：

> **在“尽量少的上下文切割”前提下，让 Agent 做复杂事**

它做的事情包括：

##### 1️⃣ 渐进式披露（Progressive Disclosure）

- 不一次性把所有能力、规则、工具塞进 prompt
- **只在需要时加载 skill**
- 减少 token 噪声，提升注意力密度

------

##### 2️⃣ 上下文可控加载 / 卸载

- skill 本质上是：
  - 一段结构化能力描述
  - - 使用约束
  - - 输入输出语义
- 它们被**明确标注进同一个上下文空间**

👉 而不是散落在多个 agent 的 prompt 里

------

##### 3️⃣ 单一推理主体（Single Reasoning Thread）

- 仍然是 **一个模型在连续思考**
- skill ≠ agent
- skill 不“思考”，只是被调用

📌 这点非常关键
也是你把 skill 类比成 **jar / npm 包** 时，**最接近本质的地方**

------

#### 六、用一句话精确评价你的理解

> **你的结构类比是对的，但你低估了“上下文一致性”在 AI Agent 中的重要性**

换成工程语言就是：

> 在 Web 中，架构主要影响 **可维护性、扩展性、部署**
> 在 AI Agent 中，架构直接影响 **推理正确率、稳定性和可复现性**

------

#### 七、最终结论（不站队版本）

##### ✅ 你说对的部分

- skills 确实不是能力跃迁
- 更像工程范式统一
- agent + skills ≈ 单体多模块 + 插件
- MCP ≈ 远程能力调用协议

##### ✅ vicat_47 说对的部分

- 在 Agent 场景下，**工程结构 = 上下文工程**
- 上下文质量直接决定“功能是否能跑通”
- 多 agent 带来的上下文碎片化，往往得不偿失

------

#### 八、一句话总结这整场讨论

> **Anthropic 不是在说“别做 Agent”，而是在说：
> 别把「上下文管理失败」包装成「多 Agent 架构」**

如果你愿意，下一步我可以帮你画一个：

- **多 Agent vs 单 Agent + skills 的上下文流动对比图**
- 或者用 **ReAct / Plan-Execute** 实际拆一遍你熟悉的工程场景

你这套问题，已经明显不是“入门视角”了。

### [Anthropic 官宣！别再造 Agent 了，通用 Agent + Skills 才是未来（底层逻辑拆解）](https://www.bilibili.com/video/BV1gjB5BpE1j/)



[时间戳：](https://www.bilibili.com/video/BV1gjB5BpE1j?t=1014.2)

4. 第四单元：组织变革——PM、架构师与开发者的角色重写

5. 产品经理 (PM)：规划技能资产组合
   护城河正在从模型能力切换到技能资产密度。PM 关注：覆盖面（SOP）、复用率（跨部门）、质量标准（验收口径）。

6. 架构师：企业治理
   技能可插拔后，需要解决：谁能用？谁能改？风险审计？
   Skill Registry 权限模型 发布流水线 可观测性

7. 开发者：知识工程
   以前调模型/堆 Prompt，现在重心变了：

- 写可执行 SOP (Skill.md)
- 写确定性脚本 (Runtime)
- 分层编排上下文



全篇总结
未来真正拉开差距的不是你有多少Agent，而是你把多少组织经验沉淀成了可复
用、可治理、可分发的Skills。
