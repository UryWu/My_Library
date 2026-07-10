### 1. 安装

uv add claude-conversation-extractor

### 2. 核心命令与使用场景

工具安装后，你主要通过 `claude-extract` 命令来操作。

| 常用命令      | 作用                                     | 示例                                         |
| :------------ | :--------------------------------------- | :------------------------------------------- |
| `--list`      | 列出所有可导出的对话列表                 | `claude-extract --list`                      |
| `--extract N` | 导出指定编号的对话                       | `claude-extract --extract 1`                 |
| `--recent N`  | 导出最近 N 个对话                        | `claude-extract --recent 5`                  |
| `--all`       | 导出所有对话                             | `claude-extract --all`                       |
| `--format`    | 指定导出的格式（markdown, json, html）   | `claude-extract --extract 1 --format json`   |
| `--output`    | 指定输出目录                             | `claude-extract --all --output ~/my_backup/` |
| `--detailed`  | 导出更详细的内容（如工具调用、系统消息） | `claude-extract --extract 1 --detailed`      |
| `--search`    | 在对话内容中搜索关键词                   | `claude-extract --search "error handling"`   |



### 3. 典型工作流程

#### 场景一：快速备份最近的对话

最直接的使用方法是导出最近的几条记录，备份或分享。

bash

```
# 1. 先看看有哪些对话
claude-extract --list --limit 10
# 2. 导出最近 3 个对话为 Markdown
claude-extract --recent 3 --output ~/Desktop/claude_backup/
```



工具会自动在 `~/.claude/projects/` 目录下找到所有对话记录 。

#### 场景二：搜索并导出特定会话

如果你需要找回之前讨论过的某个技术点，可以先搜索再导出。

bash

```
# 1. 搜索包含 "API integration" 的对话
claude-extract --search "API integration"
# 2. 根据搜索结果的编号，导出该对话
claude-extract --extract 5 --format html --detailed
```



使用 `--detailed` 可以包含完整的工具调用和命令输出，适合深度复盘 。

#### 场景三：使用交互式界面

如果你不确定要导出哪个，或者想更直观地浏览会话内容，可以使用交互式界面。

bash

```
# 启动交互式界面
claude-extract --interactive
# 或直接使用专用命令
claude-start
```

### 这个spacy是用于NLP任务的

 Install spacy for enhanced semantic search capabilities

```shell
uv add spacy && uv add click && uv run python -m spacy download en_core_web_sm
```

#### 为什么需要 spaCy？

这个工具的核心搜索功能默认是基于**关键词匹配**的。安装 `spaCy` 和 `en_core_web_sm` 模型后，可以解锁更强大的**语义搜索（Semantic Search）** 能力。

简单来说，两者的区别是：

- **关键词搜索**：只能找到包含你输入的特定词语的对话。
- **语义搜索**：能理解你的搜索意图，找到意思相近但用词不同的对话。例如，搜索“修复bug”，可能会同时找到包含“debug”、“修复问题”等内容的对话。

1. **确认安装**：你可以通过运行以下命令，再次确认模型已安装成功：

   ```python
   uv run python -c "import spacy; nlp = spacy.load('en_core_web_sm'); print('语义搜索增强已就绪')"
   ```

2. **开始使用**：现在你可以正常使用 `claude-conversation-extractor` 的搜索功能了。例如，启动交互式界面进行实时搜索：

    ```bash
    claude-start
    ```

	或者使用命令行直接搜索：

    ```bash
    claude-extract search "你的搜索关键词"
	```

**注意**：这个工具是为 **Claude Code**（桌面版应用）设计的，它读取的是你电脑本地 `~/.claude/projects/` 目录下的日志文件，不能用于网页版 Claude
