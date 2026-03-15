### uv管理python

参考：https://blog.csdn.net/zheliku/article/details/152630684

#### 1. 安装 uv

在 Windows 下，通过以下命令安装 uv：

```powershell
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```


这会下载 3 个 exe 文件到路径 `C:\Users\Administrator\.local\bin` 下

uv.exe
uvx.exe
uvw.exe

可以将这 3 个 exe 放到别的路径下，并设置环境变量，以全局使用 uv。

#### 2. 管理 python

##### 2.1 指定位置

在 powershell 配置文件中修改 python 安装位置：

`C:\Users\<用户名>\Documents\WindowsPowerShell\profile.ps1`

添加以下命令指定安装和缓存位置：

```powershell
$env:UV_PYTHON_INSTALL_DIR = "G:\softwares\Python"
$env:UV_CACHE_DIR = "G:\softwares\Python\UV_CACHE_DIR"
```

将上述路径添加到系统 Path 后，可输入以下命令查看安装路径：

```powershell
uv python dir
```

如果这里用cmd来uv python dir，则无法输出G:\softwares\Python，它会输出不是你指定的G:\softwares\Python位置，而是uv默认在C盘的安装位置：`C:\Users\<用户名>\AppData\Roaming\uv\python`

所以在下一步用uv安装python的时候，用powershell执行安装命令。

##### 2.2 安装 python

使用以下命令查看 python 可/已安装的列表：

```shell
uv python list
```

output:

```shell
cpython-3.15.0a6-windows-x86_64-none                 <download available>
cpython-3.15.0a6+freethreaded-windows-x86_64-none    <download available>
cpython-3.14.3-windows-x86_64-none                   C:\users\urywu\.local\bin\python3.14.exe
cpython-3.14.3-windows-x86_64-none                   <download available>
cpython-3.14.3+freethreaded-windows-x86_64-none      <download available>
cpython-3.13.12-windows-x86_64-none                  <download available>
cpython-3.13.12+freethreaded-windows-x86_64-none     <download available>
cpython-3.12.13-windows-x86_64-none                  G:\softwares\Python\cpython-3.12.13-windows-x86_64-none\python.exe
cpython-3.12.13-windows-x86_64-none                  C:\users\urywu\.local\bin\python3.12.exe
cpython-3.12.13-windows-x86_64-none                  C:\users\urywu\.local\bin\python.exe -> python3.12.exe
cpython-3.12.13-windows-x86_64-none                  <download available>
```



输入以下命令安装指定版本的 python：

```shell
uv python install 3.12
```

此时python安装到了目录：G:\softwares\Python ，此目录下安装了文件如：

```
cpython-3.14-windows-x86_64-none
cpython-3.12.13-windows-x86_64-none
cpython-3.12-windows-x86_64-none
cpython-3.14.3-windows-x86_64-none
```



卸载同理：

```shell
uv python uninstall 3.12
```



##### 3.3 指定 python 版本

输入以下命令切换 python 版本：

```shell
# 绑定版本为 3.13.7
uv python pin 3.12.13  # 这会生成 .python-version 文件

# 同步更新
uv sync
```



### 设置cmd可直接用uv安装的python

#### 设置控制台直接用的python

C:\Users\UryWu\.local\bin

上面的目录中有

python3.12.exe
python3.14.exe

uv.exe

poetry.exe

等其它exe，这些exe在cmd中可以直接执行，如：

```shell
python3.12 main.py
```

```shell
uv run python main.py
uv python list
```

```shell
poetry run python main.py
```

为了使cmd、powershell中能直接使用python main.py命令，给python3.12.exe创建一个Symbolic link，放在同目录，即C:\Users\UryWu\.local\bin下，并把Symbolic link命名为python.exe。



#### 控制台切换python

先：

```shell
uv python pin 3.14
```

此时在cmd控制台的目录下生成了一个名为：.python-version的文件，里面写着当前选定的python版本的数字号，如下：

```
3.14
```



这一步相当于conda中的activate tensorflow-gpu

venv中的.venv\Scripts\activate

测试当前的python，cmd输入：

```shell
uv run python
```

output：

```shell
Python 3.14.3 (main, Mar  3 2026, 15:00:44) [MSC v.1944 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license" for more information.
>>>
```

再运行代码：

```shell
uv run python main.py
```



如果直接输入python则还是上面设置的python3.12.exe指定的环境，cmd输入：

```shell
python
```

output:

```shell
Python 3.12.13 (main, Mar  3 2026, 15:01:35) [MSC v.1944 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license" for more information.
>>>
```

想变更python指定的环境只能通过重新生成python3.14.exe的Symblic link来变更，或者直接python3.14 main.py也行 。
