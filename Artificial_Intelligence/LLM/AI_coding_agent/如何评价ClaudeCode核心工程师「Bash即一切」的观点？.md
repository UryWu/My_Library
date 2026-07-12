[Thariq Shihipar](https://zhida.zhihu.com/search?content_id=764475824&content_type=Answer&match_order=1&q=Thariq+Shihipar&zhida_source=entity)是真能说，其实就是很简单的一个事，说了差不多2个小时。

他的和核心观点就是：[Bash](https://zhida.zhihu.com/search?content_id=764475824&content_type=Answer&match_order=1&q=Bash&zhida_source=entity) 是最强大的 Agent 工具。

其实这个跟我们的想法是一样的，因为Bash 本来就是全能的，因为他能执行任何命令

## 他核心观点

传统的 Agent 设计思路是：为每个用例创建一个专门的工具。需要搜索？创建搜索工具。需要 lint？创建 lint 工具。需要执行代码？创建执行工具。

但这种方法有严重的问题：

- 上下文占用高：50+ 个工具会占用大量上下文窗口，模型容易混淆
- 不可发现：模型需要”知道”有哪些工具可用
- 不可组合：工具之间无法灵活组合

而 Bash 则完全不同。Claude 可以直接使用 `grep` 来搜索，用 `npm run lint` 来检查代码，用 `npm install eslint` 来安装工具。这些命令可以通过管道符自由组合，实现几乎无限的功能。

Bash 脚本是静态的，不占用上下文窗口。Agent 可以通过 `--help` 命令来发现工具的功能，而不是一开始就加载所有工具的定义。

这种”渐进式上下文披露（Progressive Context Disclosure）“的模式非常高效：

- Agent 知道自己有一个 Bash 工具
- 需要特定功能时，它会主动查询帮助文档
- 只有真正需要的信息才会进入上下文

Bash 让 Agent 可以直接使用我们积累的大量工具：

- `ffmpeg` 处理视频
- `jq` 解析 JSON
- `awk` 处理文本
- `curl` 发送网络请求
- `LibreOffice` 处理文档

他还举了个例子

假设你要构建一个邮件 Agent，用户问：”我这周在打车上花了多少钱？”

传统工具方法：

1. 调用 `search_emails(query="Uber OR Lyft")` 工具
2. 返回 100 封邮件
3. 模型硬着头皮一封封读取、提取价格、求和
4. 精度和召回率都很难保证

Bash 方法：

1. 调用 Gmail 搜索脚本，获取相关邮件
2. 将结果保存到文件
3. 使用 `grep` 提取价格
4. 使用管道计算总和
5. 还可以将每一步结果保存到文件中，方便回溯检查

关键区别事Bash 允许 Agent 像人一样工作——保存中间结果、使用工具组合、验证自己的工作。

## 我的一些看法

首先我觉得他说的对，我也非常喜欢用Bash，因为Bash非常强大。我现在启动llama.cpp之类的也都是直接写成shell脚本，直接执行就好了。因为llama.cpp更新太快了我甚至是写了一个自动判断文件夹里最新版本的脚本，这样就解压然后删除旧版，在重启就直接运行的是新版了。这就是因为Bash强大，而且我也懒。

但是你看他里面说的一个重要问题：

> Bash 脚本是静态的，不占用上下文窗口。Agent 可以通过 `--help` 命令来发现工具的功能，而不是一开始就加载所有工具的定义。

虽然不占用上下文窗口，但是Agent 要通过--help` 命令来发现工具的功能 这个可是要多次交互的，这里可不省Token，咱们可不是Claude 员工，他可以这么用，咱们没这资本，不如设计好用具调用和描述，每次只附带需要的工具，这样是真正的省Token。

只不过你的工具实现是写代码还是写Bash脚本，就这么一个区别而已

## 其他一些有用的信息

他说的有2个是我觉得非常有用的信息：

**1、文件系统是 Agent 的外部记忆**

他说在 [Claude Code](https://zhida.zhihu.com/search?content_id=764475824&content_type=Answer&match_order=1&q=Claude+Code&zhida_source=entity) 中：

1. 工具调用的结果保存到文件
2. Agent 可以随时回顾和搜索这些结果
3. 用户的偏好和历史可以存储在文件中
4. Skills（技能）本质上就是 Agent 可以"cd 进去并阅读"的文件夹

这解决了一个关键问题：**上下文窗口是有限的，但文件系统是无限的**

**2、Anthropic 发现了一个有趣的现象，虽然 Claude Code 是为编码设计的，但财务、数据科学、市场营销等非技术部门也在大量使用它。**

代码生成不仅仅是为了写代码，而是一种通用的问题解决范式，高层次来说，代码生成就是组合 API。几乎任何使用场景，我们都可以用代码生成来解决。

这个跟我们看到的一些文章很类似，有用Claude Code 炒股的，做排名监控的，打Kaggle比赛的，我觉得就是把Claude Code 当Agent来用了。

## 总结

我个人觉得 "Bash Is All You Need" 是一个非常实在的观点，它不是说 Bash 真的是唯一需要的东西，而是强调了通用工具胜过专用工具的设计理念：要从“保姆式”的定义工具，转向提供一个“通用环境”

当你有了一个能读写文件、能执行命令、能联网、还能自己查 `--help` 的 Agent，你就不再是在写一个聊天机器人了，你是在培养一个数字员工。（不过我还是那句话，我可没那么多钱让Agent看Help，Opus可太贵了）

以上简单总结，供参考



[发布于 2026-01-08 00:44](https://www.zhihu.com/question/1992208967498236682/answer/1992396321282357047)