# 更换venv用的python

打开`<项目根目录>.venv\pyvenv.cfg`

```
home = G:\softwares\Python312
implementation = CPython
uv = 0.10.8
version_info = 3.12.10
include-system-site-packages = false
prompt = claude_code_go_game
```

改为其他python：

```
home = G:\softwares\Python\cpython-3.12-windows-x86_64-none
implementation = CPython
uv = 0.10.8
version_info = 3.12.13
include-system-site-packages = false
prompt = claude_code_go_game
```



# 克隆venv

在 **uv** 里，一般**不建议“克隆 venv”**。
uv 的设计理念是：**环境是可重建的，而不是复制的**。

所以正确做法是：

```
uv.lock  →  重建 venv
```

而不是：

```
复制 .venv
```

------

## ⭐ 标准做法（推荐）

如果你已经有：

```
pyproject.toml
uv.lock
```

在新机器或新目录只需要：

```bash
uv sync
```

uv 会：

1. 自动创建 `.venv`
2. 根据 `uv.lock` 精确安装依赖
3. 环境 **100%复现**

速度通常 **几秒钟** 🚀

------

## ⭐ 如果想“复制环境”

### 方法1：复制项目（推荐）

```
projectA/
 ├ pyproject.toml
 ├ uv.lock
 └ .venv
```

复制：

```
projectA → projectB
```

然后执行：

```bash
uv sync
```

uv 会检查 `.venv` 是否一致。

------

### 方法2：用 requirements 导出

```bash
uv pip freeze > requirements.txt
```

然后：

```bash
uv pip install -r requirements.txt
```

但这种方式 **不如 uv.lock 精确**。

------

## ⭐ 如果你真的想复制 `.venv`

可以直接：

```
cp -r .venv new_project/.venv
```

但有风险：

- Python路径绑定
- 不同机器路径失效
- Windows / Linux 不兼容

所以 **uv 官方不推荐**。

------

## ⭐ uv 的真正“克隆环境”方法

实际上是：

```
git clone project
cd project
uv sync
```

因为：

```
uv.lock = 环境快照
```

类似：

| 生态   | 环境锁            |
| ------ | ----------------- |
| npm    | package-lock.json |
| yarn   | yarn.lock         |
| poetry | poetry.lock       |
| uv     | uv.lock           |

------

## ⭐ 一个很多人不知道的 uv 技巧

你可以在 **多个项目共享缓存**：

uv 会使用全局缓存：

```
~/.cache/uv
```

所以第二个项目执行：

```
uv sync
```

**几乎是瞬间完成** ⚡

------

如果你愿意，我可以再告诉你一个 **uv 非常高级但很少人知道的玩法**：

```
uv venv --seed
```

可以 **1 秒创建一个带常用包的 Python 环境**，很多 AI / 数据科学团队在用。