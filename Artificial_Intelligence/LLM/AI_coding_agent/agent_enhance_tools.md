## [Playwright CLI 让 Claude Code 终于能「自己看网页」了](https://zhuanlan.zhihu.com/p/2010717224810353568)

### 安装就一行命令：

```text
npm install -g @playwright/cli@latest
playwright-cli install-browser
```

装好之后，Claude Code 可以直接在终端里执行：

```text
playwright-cli open https://localhost:3000 --headed
playwright-cli snapshot        # 获取页面结构
playwright-cli click e21       # 点击某个元素
playwright-cli fill e15 "hello"  # 填写输入框
playwright-cli screenshot      # 截图
```

`e21`、`e15` 是 Playwright 给页面元素自动分配的编号。Claude Code 先用 `snapshot` 看一眼页面有哪些元素，然后直接用编号操作——不用写 CSS 选择器，不用找 DOM 路径。

### 场景一：改完样式，让 AI 自己验证

以前的流程：

1. 让 Claude Code 改 CSS
2. 自己去浏览器刷新
3. 不对，截图粘贴给 Claude Code
4. 它再改
5. 重复 2-4

现在的流程：

1. 让 Claude Code 改 CSS
2. 它自己用 `playwright-cli open` 打开页面
3. 用 `snapshot` 看页面结构，用 `screenshot` 截图确认
4. 发现不对，自己改
5. 自己验证，直到正确

**你只需要在最后看一眼最终效果就行。**

### 场景二：表单功能测试

让 Claude Code 帮你测一个注册表单：

```text
playwright-cli open https://localhost:8000/register --headed
playwright-cli snapshot
playwright-cli fill e12 "test@example.com"
playwright-cli fill e15 "password123"
playwright-cli click e18          # 点击注册按钮
playwright-cli snapshot           # 看看跳转到哪了
playwright-cli screenshot         # 截图留档
```

这一套操作，Claude Code 可以完全自主完成。你不用打开浏览器，不用手动填表单，不用截图粘贴。

### 场景三：线上页面巡检

你可以让 Claude Code 帮你检查线上页面有没有异常：

> 「用 playwright-cli 打开 [https://example.com，检查首页是否正常加载，导航链接是否都能点，截几张图给我看看」](https://link.zhihu.com/?target=https%3A//example.xn--com%2C%2C%2C-1t3e178vkobo1gca258fu0qzlhvsdjyqbmaj1uyonga403gwzex3s5g5a596aa7505chsmkjiw81ikzjbj6ab5xzqi/)

它会自己打开页面，逐个点击导航，遇到报错自动记录，最后给你一份完整的检查报告。

------

### 有头模式 vs 无头模式

默认情况下，Playwright CLI 以无头模式运行——浏览器在后台工作，你看不到窗口。

如果你想看到 Claude Code 在操控浏览器的实时画面（确实挺有意思的），加个 `--headed` 参数：

```text
playwright-cli open https://example.com --headed
```

两种模式对 token 消耗没有任何影响，区别只在于你能不能肉眼看到浏览器窗口。调试的时候建议开 headed，日常跑任务用 headless 就行。

------

### 在 Claude Code 里怎么配置？

最简单的方式是安装官方的 Skill：

```text
playwright-cli install --skills
```

这会在你的项目里生成一个 `.claude/skills/playwright-cli/SKILL.md` 文件。Claude Code 读了这个文件之后，就知道所有可用的命令和用法了。

之后你只需要用自然语言告诉它：

> 「帮我测一下登录页面」 「打开首页，检查所有链接是否正常」 「把当前页面截个图」

它会自动调用 Playwright CLI 完成操作。



### 不只是看——完整的浏览器控制能力

Playwright CLI 能做的远不止打开页面和截图：

- **表单操作**：`fill`、`check`、`uncheck`、`select`
- **键盘操作**：`type`、`press`
- **鼠标操作**：`click`、`dblclick`、`hover`、`drag`
- **导航控制**：`goto`、`go-back`、`go-forward`、`reload`
- **多标签页**：`tab-new`、`tab-list`、`tab-select`
- **网络调试**：`network`（查看请求）、`route`（mock 请求）、`console`（查看控制台日志）
- **状态管理**：`state-save`、`state-load`（保存/恢复登录状态）
- **录制追踪**：`tracing-start`、`tracing-stop`（录制操作轨迹用于排查问题）

对于前端开发来说，这基本覆盖了日常调试的所有需求。

## [程序员狂喜🔥GitNexus给AI装架构眼，掌控全局不踩坑](https://www.bilibili.com/video/BV1rswszFEba/)

[网页app](https://gitnexus.vercel.app/)

使用：

```bash
npx gitnexus analyse
```

像openclaw太复杂的工程需要另起目录：

```bash
mkdir -p ~/tmp-gitnexus
cd ~/tmp-gitnexus
npm init -y
npx gitnexus@latest analyze "/Users/shenwangjie/Desktop/my-lessons/AI/OpenClaw/openClaw"
```

