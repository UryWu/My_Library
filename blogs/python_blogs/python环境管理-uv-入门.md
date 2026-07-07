### 最简uv教程

结论：**先 `uv init`，再 `uv venv`（通常甚至不用手动 `uv venv`）。**

#### 1️⃣ 推荐流程（最标准）

```bash
uv init
uv venv
uv add requests
```

步骤解释：

1. **`uv init`**

   - 初始化项目
   - 创建：
     - `pyproject.toml`
     - `.python-version`
     - `.gitignore`
     - 项目结构
   - 相当于 Python 项目的 **package.json 初始化**

2. **`uv venv`**

   - 创建虚拟环境 `.venv`
   - 类似：

   ```bash
   python -m venv .venv
   ```

3. **`uv add`**

   - 安装依赖
   - 自动更新：
     - `pyproject.toml`
     - `uv.lock`

------

#### 2️⃣ 更常见的实际用法（很多人甚至不手动 `uv venv`）

`uv`会**自动创建虚拟环境**。

```bash
uv init
uv add requests
```

执行 `uv add` 时：

```
uv 自动创建 .venv
uv 安装依赖
uv 生成 uv.lock
```

所以很多人流程是：

```bash
uv init
uv add flask
```

就结束了。

------

#### 3️⃣ 对比 npm / yarn（非常像）

| uv        | npm/yarn      |
| --------- | ------------- |
| `uv init` | `npm init`    |
| `uv add`  | `npm install` |
| `uv.lock` | `yarn.lock`   |
| `.venv`   | node_modules  |

------

#### 4️⃣ 官方推荐项目流程

```bash
uv init my_project
cd my_project

uv add fastapi
uv add uvicorn

uv run main.py
```

------

💡 **一个很多人不知道的 uv 设计**

`uv` 是 **项目驱动，而不是环境驱动**：

传统 Python：

```
先 venv
再 pip install
```

uv：

```
先项目(pyproject.toml)
再环境
```

这也是为什么 **先 `uv init` 是更合理的顺序**。

------

如果你愿意，我可以再给你一份 **“uv 完整使用心智模型（比 pip + venv + poetry 简单 10 倍）”**，很多人第一次用 uv 都会误解它的设计。



### [为什么我现在做Python项目都用UV？你看完就懂了](https://juejin.cn/post/7514531004099756032)



#### 第一步：安装 UV

Mac和Linux直接执行以下命令：

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh

# 装完你就多了个 uv 命令
```



windows系统执行以下命令：

```bash
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

注意：windows下要在powershell下执行上面的命令，可恶的是杀毒软件会报病毒，直接点允许即可

安装完毕以后在终端执行

```bash
vu -V
```



#### 第二步：创建并管理虚拟环境

有些人问：“uv 会不会跟 venv 冲突？”

不会。它自己带虚拟环境功能，还能自动识别 .venv 文件夹。也就是说：

```bash
uv venv
```

一行就能给你在当前目录创建 .venv/ 虚拟环境。

然后呢，不用你去 activate 环境，它直接会识别 .venv 来执行命令。也就是说你用：

```bash
uv run python script.py
```

就能运行脚本，等效于 source activate + python，省事很多。



#### 第三步：项目初始化（就是初始化 pyproject.toml）

你如果准备新开一个项目，建议先初始化：

```bash
uv init
```



它会帮你自动生成 pyproject.toml，内容非常干净清爽，而且官方推荐格式，未来兼容性很好。

生成后pyproject.toml结构大概是这样：

```bash
[project]
name = "uv-test"
version = "0.1.0"
description = "Add your description here"
readme = "README.md"
requires-python = ">=3.13"
dependencies = []
```



然后就可以愉快地添加依赖了，比如安装tushare库：

```bash
uv add tushare
```

它会自动修改 pyproject.toml 并生成 uv.lock 锁文件。锁文件这个功能真的很赞，不同操作系统装出来的依赖版本也能保持一致，很适合多人协作。

#### 第四步：同步依赖（尤其适合团队协作）

比如你从 Git 拉了个项目，有现成的 pyproject.toml 和 uv.lock，你就可以用：

```bash
uv sync
```

一键同步所有依赖，不需要管版本，自动创建虚拟环境、自动装依赖，一把梭。

这跟以前你要手动 pip install，指定版本、创建 venv 完全不是一个体验。



#### 第五步：运行脚本（甚至支持脚本内写依赖）

这个功能我一开始真觉得有点离谱，后来用了觉得香。

你写一个脚本文件，在头部加注释：

```bash
# uv: requests rich

import requests
import rich
print("hello world")
```

然后你在命令行运行它：

```bash
uv run myscript.py
```

UV 会自动识别注释里的依赖，如果没装就自动帮你建虚拟环境、装依赖，然后运行脚本。

说真的，这功能对于写临时脚本、测试、共享代码，简直就是神仙操作

#### 第六步：管理 Python 版本

你不需要再装 pyenv，UV 内置了 Python 版本管理：

```bash
uv python install 3.12
uv python pin 3.12
```

pin 是啥意思？就是这个项目默认用 3.12，不用每次切环境再指定版本了，每个项目可以绑定自己的 Python 版本，干净、稳定。

#### 第七步：替代 pipx 安装 CLI 工具

比如你想用 ruff 或 httpie 这些命令行工具：

```bash
uv tool install ruff
ruff myfile.py
```

它会用专属环境装好，完全不污染你的主 Python 环境，和 pipx 一个理念，但是用起来更舒服。还支持更新、卸载、列出等常见操作。

#### 最后：UV 值不值得学？

我觉得，如果你已经厌倦了这些场景👇：

pip install 等半天
venv 激活又忘了
pipx 和 pyenv 安装麻烦
poetry 版本冲突看不懂
requirements.txt 改起来头疼

那 UV 会让你眼前一亮，它简化了整个生态，又兼容旧习惯，真的是能用起来的实用工具。

#### 彩蛋：一键执行所有操作示例

给你看一眼我从零到能跑起来的完整流程：

```bash
# 安装 uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# 新建项目
mkdir demo && cd demo

# 初始化项目
uv init

# 创建虚拟环境
uv venv

# 添加依赖
uv add requests pandas

# 运行脚本
uv run myscript.py
```

更多内容可以参考[UV官方网站](https://docs.astral.sh/uv/)

