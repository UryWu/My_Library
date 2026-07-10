在 Claude Code 中使用 `playwright-cli` 分为三个步骤：先全局安装工具，再为 Claude Code 注入技能包，最后通过 MCP 配置实现浏览器自动化集成。

---

## 一、准备工作：确保环境就绪

在执行安装前，请确认满足以下条件：
- **Node.js 18 或更高版本**（可通过 `node --version` 检查）
- **Claude Code 已安装并配置好认证**

> 💡 如果你使用的是 Windows 且尚未安装 Node.js，建议通过 `nvm-windows` 管理版本。

---

## 二、安装 `playwright-cli` 全局工具

在终端中运行以下命令进行全局安装：

```bash
npm install -g @playwright/cli@latest
```

我安装在：

```
E:\nvm\v24.16.0\node_modules\@playwright\cli
```

和这里：

```
E:\nvm\v20.4.0\node_modules\@playwright\cli
```

安装完成后，验证是否成功：

```bash
playwright-cli --help
```

如果看到帮助信息，说明全局工具已就绪。



npm查看安装的包：

```
npm list -g --depth=0
```

-g是全局的意思，不加-g，则会无法扫描出playwright-cli

输出：

```
C:\Users\UryWu>npm list -g --depth=0
E:\nodejs -> .\
+-- @playwright/cli@0.1.14
+-- corepack@0.35.0
`-- npm@11.13.0
```

---

## 三、为 Claude Code 安装技能包

这一步是关键——它会将 `playwright-cli` 的专用技能安装到 Claude Code 的技能目录中，让 Claude Code 理解如何使用这些命令。

在你的**项目根目录**下运行：

```bash
playwright-cli install --skills
```

执行成功后，你会在 `.claude/skills/`（或 `.claude/skill/`）目录下看到 `playwright-cli` 相关的技能文件。这样一来，Claude Code 就能识别并调用 `playwright-cli` 的能力了。

---

执行输出：

```
G:\Projects\projects_ai\data_sim_card_purchase_provide_data>playwright-cli install --skills
✅ Workspace initialized at `G:\Projects\projects_ai\data_sim_card_purchase_provide_data`.
✅ Skills installed to `.claude\skills\playwright-cli`.
✅ Found chrome, will use it as the default browser.
```

skill都安装在G:\Projects\projects_ai\data_sim_card_purchase_provide_data\.claude\skills\playwright-cli目录下。

其实我觉得还是安装在C盘的.claude里面好，更通用。

## 四、（可选）配置 Playwright MCP 服务

MCP（Model Context Protocol）可以进一步提升集成体验，让 Claude Code 能够**自主调用**浏览器自动化操作（如截图、点击、填表等），而无需每次手动输入命令。

编辑 MCP 配置文件（通常在 `~/.claude.json` 或项目内的 `.claude/` 相关配置），在 `mcpServers` 中添加以下内容：

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": [
        "@playwright/mcp@latest"
      ]
    }
  }
}
```

配置完成后，Claude Code 就能通过 MCP 协议直接与 Playwright 交互，实现端到端的自动化浏览器操作。

---

## 总结

| 步骤                | 命令/操作                                    | 说明                       |
| ------------------- | -------------------------------------------- | -------------------------- |
| 1. 全局安装         | `npm install -g @playwright/cli@latest`      | 安装 CLI 工具              |
| 2. 验证安装         | `playwright-cli --help`                      | 确认工具可用               |
| 3. 注入技能         | `playwright-cli install --skills`            | 让 Claude Code 理解该工具  |
| 4. MCP 配置（可选） | 编辑 `~/.claude.json` 添加 `playwright` 服务 | 实现 Claude 自主调用浏览器 |

