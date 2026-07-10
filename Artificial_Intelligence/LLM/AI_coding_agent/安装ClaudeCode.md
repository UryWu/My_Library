## 1 安装claude code

### 方法1 脚本安装Claude Code

此处参考：[视频时间戳](https://www.bilibili.com/video/BV1HuiyBQE9G?t=101.6)

cmd中安装claude code的命令：

```bash
irm https://claude.ai/install.ps1 iex
```
### 方法2 npm安装

此处参考：

[npm安装claude code](F:\Files\My_Library\Artificial_Intelligence\LLM\AI_coding_agent\claude-code_debug.md)

[claudecode安装教程国内使用绕过登录实现模型自【超详细安装步骤】](https://www.bilibili.com/video/BV19vc5zUEeQ/)



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
npm install -g @anthropic-ai/claude-code
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

查看claude版本：

```shell
claude --version
```



### 方法3 VS code、cursor插件安装

在VS code、cursor的插件市场里面也能安装。免登录设置同本方法。

在vs code中搜索插件安装即可：Claude Code for VS Code

注意发布者是：Anthropic anthropic.com





## 2 设置api

### 方法1 修改setting.json文件

新建`C:\Users\UryWu\.claude\settings.json`
linux平台：`~/.claude/settings.json`

```json
{ 
	"env": { 
		"ANTHROPIC_AUTH_TOKEN": "<your token>", 
		"ANTHROPIC_BASE_URL": "https://open.bigmodel.cn/api/anthropic", 
		"API_TIMEOUT_MS": "3000000", 
		"CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": 1 
	} 
}
```

#### MiniMax-M3[1m]

1m是1m上下文的意思。

```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://api.minimaxi.com/anthropic",
    "ANTHROPIC_AUTH_TOKEN": "sk-cp-xxxxxxxxxxxx",
    "API_TIMEOUT_MS": "3000000",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1",
    "CLAUDE_CODE_AUTO_COMPACT_WINDOW": "1000000",
    "ANTHROPIC_MODEL": "MiniMax-M3[1m]",
    "ANTHROPIC_SMALL_FAST_MODEL": "MiniMax-M3[1m]",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "MiniMax-M3[1m]",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "MiniMax-M3[1m]",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "MiniMax-M3[1m]"
  },
}
```

CLAUDE_CODE_AUTO_COMPACT_WINDOW必须设置为1000000才能让claude code使用模型的1m上下文能力，不然MiniMax-M3默认为512k的上下文调用，[参见](https://platform.minimaxi.com/docs/token-plan/claude-code#%E6%89%8B%E5%8A%A8%E7%BC%96%E8%BE%91%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6%EF%BC%88%E6%8E%A8%E8%8D%90%EF%BC%89)。

##### [api价格](https://platform.minimaxi.com/docs/guides/pricing-paygo)

MiniMax-M3默认512k费用比MiniMax-M3[1m]低。

| 模型                                     | 输入价格（百万 tokens） | 输出价格（百万 tokens） | 缓存读取（百万 tokens） |
| ---------------------------------------- | ----------------------- | ----------------------- | ----------------------- |
| MiniMax-M3（上下文 ≤ 512K，永久五折）    | ¥4.2 / ¥2.1             | ¥16.8 / ¥8.4            | ¥0.84 / ¥0.42           |
| MiniMax-M3（上下文 512K ~ 1M，永久五折） | ¥8.4 / ¥4.2             | ¥33.6 / ¥16.8           | ¥1.68 / ¥0.84           |



#### DeepSeek-v4-pro

```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://api.deepseek.com/anthropic",
    "ANTHROPIC_AUTH_TOKEN": "sk-xxxxxxxxxxx",
    "API_TIMEOUT_MS": "3000000",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1",
    "ANTHROPIC_MODEL": "DeepSeek-v4-pro",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "DeepSeek-v4-pro",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "DeepSeek-v4-pro",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "DeepSeek-v4-pro"
  },
}
```

DeepSeek-v4-pro默认使用1m上下文。

##### [api价格](https://api-docs.deepseek.com/quick_start/pricing/)

根据2026年7月10日中国人民银行公布的汇率中间价，1美元约等于**6.7989元人民币**，[人民币换算汇率参考](https://www.pbc.gov.cn/zhengcehuobisi/125207/125217/125925/2026071009003741941/index.html)。

| 模型                  | 输入价格（人民币/百万tokens） | 输出价格（人民币/百万tokens） | 缓存读取（人民币/百万tokens） |
| :-------------------- | :---------------------------- | :---------------------------- | :---------------------------- |
| **DeepSeek-V4-Flash** | **¥0.95**                     | **¥1.90**                     | **¥0.019**                    |
| **DeepSeek-V4-Pro**   | **¥2.96**                     | **¥5.92**                     | **¥0.025**                    |



### 方法2 使用CC-Switch

CC-Switch安装完后还要配置.claude.json里面增加hasCompletedOnboarding=true，比较麻烦，建议直接用方法1。



安装[CC-Switch-v3.11.1-Windows.msi](https://github.com/farion1231/cc-switch/releases/download/v3.11.1/CC-Switch-v3.11.1-Windows.msi)，安装包根据你的系统选择，我这里是windows10。

CC-Switch默认安装位置：

```shell
C:\Users\UryWu\AppData\Local\Programs\CC Switch\

C:\Users\UryWu\AppData\Local\Programs\CC Switch\cc-switch.exe
```

打开CC-Switch后，按照视频的步骤添加deepseek的api key，[视频时间戳：](https://www.bilibili.com/video/BV19vc5zUEeQ?t=380.5)。

再次打开claude后，不显示未登录红色Not logged in提示。



编辑或新增 `.claude.json` 文件（MacOS & Linux 为 `~/.claude.json`，Windows 为 `用户目录/.claude.json`），新增 `hasCompletedOnboarding` 参数。

```json
{
  "hasCompletedOnboarding": true
}
```

## 3 设置跳过新手指引

打开：`C:\Users\UryWu\.claude.json`
linux平台：`~/.claude.json`

json中增加以下设置则能跳过登录，注意逗号隔开：

```json
"hasCompletedOnboarding":true,
```

这个Onboarding是新手指引，为true就直接跳过。

这个方法来源：[配置好 setting.json 文件之后，Claude任然要求登录？怎么办？](https://github.com/farion1231/cc-switch/issues/404)
