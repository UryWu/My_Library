### agent-skills-cli安装pdf skill
使用 agent-skills-cli（功能最全，支持10种AI助手）这是目前最主流、最省事的方法。有多个工具可选，本质上都是帮你把技能文件下载到正确的位置。
这是专门为多AI助手设计的通用CLI工具，可以精准安装到Claude Code。
#### npm install -g agent-skills-cli
cmd输入：
```bash
npm install -g agent-skills-cli
```
此时我用的是默认的node v24
#### 查看可供安装的skill
```bash
npx ai-agent-skills list
```

output:
```bash
Available Skills (47 total)

BUSINESS
  brand-guidelines ✓
    Applies official brand colors, typography, and styling to artifac...
  internal-comms ✓
    Write internal communications using company formats. Use for stat...
  competitive-ads-extractor
    Extract and analyze competitors' ads from ad libraries. Understan...
  domain-name-brainstormer
    Generate creative domain name ideas and check availability across...
  lead-research-assistant
    Identify and qualify high-quality leads. Analyze products, search...

CREATIVE
  canvas-design ✓
    Create beautiful visual art in .png and .pdf documents using desi...
  algorithmic-art ✓
    Creating algorithmic art using p5.js with seeded randomness and i...
  image-enhancer
    Improve image and screenshot quality. Enhance resolution, sharpne...
  slack-gif-creator
    Create animated GIFs optimized for Slack. Validators for size con...
  theme-factory
    Apply professional font and color themes to artifacts. 10 pre-set...
  video-downloader
    Download videos from YouTube and other platforms. Various formats...

DEVELOPMENT
  react-best-practices * ✓ [react, typescript, nextjs]
    React development guidelines with hooks, component patterns, stat...
  web-design-guidelines ✓ [react, nextjs, typescript]
    Modern web design principles for responsive layouts, accessibilit...
  vercel-deploy * ✓ [nextjs, node, typescript]
    Deploy applications to Vercel with edge functions, serverless, an...
  expo-app-design * ✓ [expo, react, typescript]
    Build beautiful cross-platform mobile apps with Expo Router, Nati...
  expo-deployment * ✓ [expo, react, node]
    Deploy Expo apps to iOS App Store, Android Play Store, and web. C...
  upgrading-expo ✓ [expo, react, typescript]
    Guidelines for upgrading Expo SDK versions and fixing dependency ...
  frontend-design * ✓ [react, typescript, nextjs]
    Create distinctive, production-grade frontend interfaces with hig...
   * ✓ [python, typescript, node]
    Guide for creating high-quality MCP (Model Context Protocol) serv...
  skill-creator * ✓
    Guide for creating effective skills that extend Claude's capabili...
  webapp-testing ✓ [typescript, node, react]
    Toolkit for interacting with and testing local web applications u...
  code-review * ✓
    Automated code review for pull requests using specialized review ...
  python-development [python]
    Modern Python development with Python 3.12+, Django, FastAPI, asy...
  javascript-typescript [typescript, react, node]
    JavaScript and TypeScript development with ES6+, Node.js, React, ...
  backend-development [node, python, typescript]
    Backend API design, database architecture, microservices patterns...
  database-design
    Database schema design, optimization, and migration patterns for ...
  code-refactoring
    Code refactoring patterns and techniques for improving code quali...
  llm-application-dev * [python, typescript, node]
    Building applications with Large Language Models - prompt enginee...
  artifacts-builder [react, typescript]
    Create elaborate HTML artifacts using React, Tailwind CSS, and sh...
  changelog-generator
    Create user-facing changelogs from git commits. Transforms techni...

DOCUMENT
  pdf * ✓ [python]
    Comprehensive PDF manipulation toolkit for extracting text and ta...
  xlsx ✓
    Comprehensive spreadsheet creation, editing, and analysis with su...
  docx ✓
    Comprehensive document creation, editing, and analysis with suppo...
  pptx ✓
    Presentation creation, editing, and analysis for PowerPoint files...
PRODUCTIVITY
  doc-coauthoring * ✓
    Structured workflow for co-authoring documentation, proposals, te...
  code-documentation
    Writing effective code documentation - API docs, README files, in...
  jira-issues * ✓
    Create, update, and manage Jira issues from natural language. Use...
  qa-regression * ✓ [typescript, node]
    Automate QA regression testing with reusable Playwright tests. Lo...
  job-application * ✓
    Write tailored cover letters and job applications using your CV a...
  ask-questions-if-underspecified * ✓ [clarification, requirements, workflow]
    Clarify requirements before implementing. Ask 1-5 must-have quest...
  best-practices * ✓ [prompts, workflow, productivity]
    Transform vague prompts into optimized Claude Code instructions. ...
  content-research-writer
    Research and write high-quality content with citations. Improves ...
  developer-growth-analysis
    Analyze developer growth metrics and patterns. Track progress and...
  file-organizer
    Intelligently organize files and folders. Find duplicates and sug...
  invoice-organizer
    Organize invoices and receipts for tax prep. Read files, extract ...
  meeting-insights-analyzer
    Analyze meeting transcripts for behavioral patterns. Speaking rat...
  raffle-winner-picker
    Randomly select winners for giveaways and contests. Cryptographic...

* = featured  ✓ = verified
```

#### claude的skill安装目录
```bash
C:\Users\UryWu\.claude\skills\
```

先进入项目目录：
```bash
cd /d G:\Projects\projects_ai\data_sim_card_purchase_provide_data
```
output:
```bash
(data_sim_card_purchase_provide_data) G:\Projects\projects_ai\data_sim_card_purchase_provide_data>
```
#### 安装skill


例子，安装pdf解析器：
```bash
# 仅为claude安装
npx ai-agent-skills install pdf --agent claude

# 为所有agent安装
npx ai-agent-skills install pdf

# 安装其他东西
npx ai-agent-skills install backend-development frontend-design llm-application-dev webapp-testing skill-creator mcp-builder web-design-guidelines code-review database-design --agent claude
```

output:
```bash
npm warn Unknown user config "perfix". This will stop working in the next major version of npm.
Need to install the following packages:
ai-agent-skills@1.9.2
Ok to proceed? (y) y

Installed: pdf
Agent: claude
Location: C:\Users\UryWu\.claude\skills\pdf
Size: 2.4 KB

The skill is now available in Claude Code.
Just mention "pdf" in your prompt and Claude will use it.

Installed: pdf
Agent: cursor
Location: G:\Projects\projects_ai\data_sim_card_purchase_provide_data\.cursor\skills\pdf
Size: 2.4 KB

The skill is installed in your project's .cursor/skills/ folder.
Cursor will automatically detect and use it.

Installed: pdf
Agent: amp
Location: C:\Users\UryWu\.amp\skills\pdf
Size: 2.4 KB

The skill is now available in Amp.

Installed: pdf
Agent: vscode
Location: G:\Projects\projects_ai\data_sim_card_purchase_provide_data\.github\skills\pdf
Size: 2.4 KB

The skill is installed in your project's .github/skills/ folder.

Installed: pdf
Agent: copilot
Location: G:\Projects\projects_ai\data_sim_card_purchase_provide_data\.github\skills\pdf
Size: 2.4 KB

The skill is installed in your project's .github/skills/ folder.

Installed: pdf
Agent: project
Location: G:\Projects\projects_ai\data_sim_card_purchase_provide_data\.skills\pdf
Size: 2.4 KB

The skill is installed in .skills/ in your current directory.
This makes it portable across all compatible agents.

Installed: pdf
Agent: goose
Location: C:\Users\UryWu\.config\goose\skills\pdf
Size: 2.4 KB

The skill is now available in Goose.

Installed: pdf
Agent: opencode
Location: C:\Users\UryWu\.config\opencode\skill\pdf
Size: 2.4 KB

The skill is now available in OpenCode.

Installed: pdf
Agent: codex
Location: C:\Users\UryWu\.codex\skills\pdf
Size: 2.4 KB

The skill is now available in Codex.

Installed: pdf
Agent: letta
Location: C:\Users\UryWu\.letta\skills\pdf
Size: 2.4 KB

The skill is now available in Letta.

Installed: pdf
Agent: gemini
Location: C:\Users\UryWu\.gemini\skills\pdf
Size: 2.4 KB

The skill is now available in Gemini CLI.
Make sure Agent Skills is enabled in your Gemini CLI settings.
```

#### 生成的skills目录
此时C:\Users\UryWu\目录下会生成多个隐藏目录来放pdf skill，而自己项目下会生成三个目录：

```bash
Agent: vscode
Location: G:\Projects\projects_ai\data_sim_card_purchase_provide_data\.github\skills\pdf

Agent: copilot
Location: G:\Projects\projects_ai\data_sim_card_purchase_provide_data\.github\skills\pdf
```
这个给vscode或copilot用的。

```bash
Agent: claude
Location: C:\Users\UryWu\.claude\skills\pdf
```
这个给claude用。

```bash
Agent: cursor
Location: G:\Projects\projects_ai\data_sim_card_purchase_provide_data\.cursor\skills\pdf
```
这个给cursor用。
所有的pdf目录里的文档和代码模板一模一样。


#### 需要为每个代理单独卸载：

##### 方法1：指定代理类型卸载


```bash
卸载 cursor 的 pdf 技能
npx ai-agent-skills uninstall pdf --agent cursor
卸载 amp 的 pdf 技能  
npx ai-agent-skills uninstall pdf --agent amp
卸载 vscode 的 pdf 技能
npx ai-agent-skills uninstall pdf --agent vscode
卸载 copilot 的 pdf 技能
npx ai-agent-skills uninstall pdf --agent copilot
卸载 project 的 pdf 技能
npx ai-agent-skills uninstall pdf --agent project
卸载 goose 的 pdf 技能
npx ai-agent-skills uninstall pdf --agent goose
卸载 opencode 的 pdf 技能
npx ai-agent-skills uninstall pdf --agent opencode
卸载 codex 的 pdf 技能
npx ai-agent-skills uninstall pdf --agent codex
卸载 letta 的 pdf 技能
npx ai-agent-skills uninstall pdf --agent letta
卸载 gemini 的 pdf 技能
npx ai-agent-skills uninstall pdf --agent gemini
```

##### 方法2：手动删除所有位置

根据安装时显示的路径，手动删除：

```bash
删除各个位置的 pdf 技能文件夹
rmdir /s /q "C:\Users\UryWu\.claude\skills\pdf"
rmdir /s /q "G:\Projects\projects_ai\data_sim_card_purchase_provide_data\.cursor\skills\pdf"
rmdir /s /q "C:\Users\UryWu\.amp\skills\pdf"
rmdir /s /q "G:\Projects\projects_ai\data_sim_card_purchase_provide_data\.github\skills\pdf"
rmdir /s /q "G:\Projects\projects_ai\data_sim_card_purchase_provide_data\.skills\pdf"
rmdir /s /q "C:\Users\UryWu\.config\goose\skills\pdf"
rmdir /s /q "C:\Users\UryWu\.config\opencode\skill\pdf"
rmdir /s /q "C:\Users\UryWu\.codex\skills\pdf"
rmdir /s /q "C:\Users\UryWu\.letta\skills\pdf"
rmdir /s /q "C:\Users\UryWu\.gemini\skills\pdf"
```

##### 方法3：查看所有已安装的技能

```bash
# 查看每个代理已安装的技能
npx ai-agent-skills list --agent cursor
npx ai-agent-skills list --agent claude
```