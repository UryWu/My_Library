### [python包管理之uv](https://www.zhihu.com/question/666301305/answer/1904230326525485562)

对于Python环境管理，我之前用的比较多的是virtualenv，但现在尝试用uv，听说非常受欢迎。uv是一个拥有环境管理、依赖管理、Python版本管理、运行脚本、打包发布等多种功能的Python一体化工具链，可以说集齐了venv、virtualenv、pip、poetry能力于一身，据说对于包的解析安装速度比pip快数十倍，配置虚拟环境的速度也比virtualenv快数十倍。

uv官方非常自信，喊话pip、virtualenv，你有的我都有，而是更好，你没有的我也有。总之是uv在手，功能全有。<img src="https://pica.zhimg.com/50/v2-c6934bfea20597ad1d7987125577b5f8_720w.jpg?source=1def8aca" data-caption="" data-size="normal" data-rawwidth="1053" data-rawheight="727" data-original-token="v2-4dfb3ae3aee063a249dc254385eeb996" data-default-watermark-src="https://picx.zhimg.com/50/v2-2d443dd8d927d32b2355fa137c494e7a_720w.jpg?source=1def8aca" class="origin_image zh-lightbox-thumb" width="1053" data-original="https://picx.zhimg.com/v2-c6934bfea20597ad1d7987125577b5f8_r.jpg?source=1def8aca"/>

#### 1、安装uv

```text
pip install uv
```



可以通过uv init来创建Python项目

#### 2、配置虚拟环境

然后在Python项目中添加依赖，使用uv add实现，比如uv add pandas



uv在运行代码时能自动激活虚拟环境执行，不需要像virtualenv那样手工去激活。其他主要的虚拟环境管理方法有：

uv remove: 移除依赖

uv sync: 同步依赖到虚拟环境中

uv lock: 生成锁文件

uv run: 在虚拟环境中运行脚本

uv tree: 查看依赖列表

uv build: 生成发布包

uv publish: 发布到PyPI

#### 3、包管理

uv可以实现pip的所有功能，语法一直，而且比pip安装包的速度更快。

比如说安装第三方库，使用uv pip install实现

uv pip是移植了pip的接口，但对速度和功能做了优化，比pip体验会更好。

uv其他主要的包管理方法有：

- `uv pip show`: 显示已安装包的细节
- `uv pip freeze`: 显示已安装包列表及其版本号
- `uv pip check`: 检查当前环境是否有兼容的软件包
- `uv pip uninstall`: 卸载包
- `uv pip tree`: 查看环境依赖

#### 4、管理Python版本

uv可以安装Python，以及对其版本进行管理。

比如安装不同版本Python：

```text
uv python install 3.10 3.11 3.12
```

其他主要方法有：

- `uv python list`: 查看安装的Python版本
- `uv python pin`: 将当前项目固定为使用特定 Python 版本
- `uv python uninstall`: 卸载某版本Python

#### 5、执行Python脚本

uv能直接执行Python脚本，这个功能很方便。

执行脚本，使用uv run

```text
uv run example.py
```



### [见 Pip 和 Conda！Poetry 才是 Python 依赖管理的最好选择！ - Python与数据挖掘的文章 - 知乎](https://zhuanlan.zhihu.com/p/679243801)

发布于 2024-01-22 22:03

poetry与pip、conda的简单比较，poetry优。

#### poetry add 

#### poetry remove



### [Python 新规范 pyproject.toml 完全解析-腾讯云开发者社区-腾讯云](https://cloud.tencent.com/developer/article/2219745)

发布于 2023-02-20 10:51:48

poetry比pip的优势比较。

### [Python 虚拟环境 virtualenv看这一篇就够了-阿里云开发者社区](https://developer.aliyun.com/article/867819)

#### 总结

这篇讲得最详细，最好。

1. virtualenv:
2. venv:
3. pipenv:
三者对比，以及windows/linux下virtualenv和venv的详细使用。

venv不推荐使用。
键盘即钢琴 2022.03.11
pyenv自从3.6版本开始，就已经不被推荐使用了。根据Venv的页面介绍，根据Venv的页面介绍，Deprecated since version 3.6: pyvenv was the recommended tool for creating virtual environments for Python 3.3 and 3.4, and is deprecated in Python 3.6.

#### 步骤

##### 创建

python -m venv myvenv

可以在当前目录创建一个名为 myvenv 的虚拟环境



##### 激活

$ source myvenv/bin/activate

##### 安装依赖

开发完成后，使用 `pip freeze > requirements.txt` 命令将项目的库依赖导出，作为代码的一部分

将代码上传到服务器

在服务器上创建一个虚拟环境

激活虚拟环境，执行 `pip install -r requirements.txt`，安装项目依赖



### [Python创建虚拟环境的三种方式](https://blog.csdn.net/ARPOSPF/article/details/113616988)

简明教程。

1. Virtualenv
2. Pipenv
3. Conda
三者之间的对比，linux下Virtualenv和Pipenv的使用。


### [【python】为工程项目创建独立虚拟环境并关联](https://blog.csdn.net/gsgs1234/article/details/119968413)
总结：这篇是在PyCharm下来使用虚拟环境。
Virtualenv和anconda对比
Virtualenv就是项目本地的环境。



### [【Python】 探索Python的site-packages目录：初学者指南](https://blog.csdn.net/baidu_22713341/article/details/139083851)



示例1：使用site模块
Python的标准库中有一个site模块，它可以帮助你找到site-packages目录的位置。

import site
print(site.getsitepackages())

示例3：通过命令行
如果你更喜欢使用命令行而不是编写代码，你可以使用以下命令来找到site-packages目录：

python -m site



我的ChatGLM-6B里面的venv打这个python -m site得出这样的路径：

```bash
(venv) G:\Projects\projects_ai\ChatGLM-6B>python -m site
sys.path = [
    'G:\\Projects\\projects_ai\\ChatGLM-6B',
    'E:\\Anaconda3-2019.10-Windows-x86_64\\envs\\langchain\\python311.zip',
    'E:\\Anaconda3-2019.10-Windows-x86_64\\envs\\langchain\\DLLs',
    'E:\\Anaconda3-2019.10-Windows-x86_64\\envs\\langchain\\Lib',
    'E:\\Anaconda3-2019.10-Windows-x86_64\\envs\\langchain',
    'G:\\Projects\\projects_ai\\Langchain-Chatchat\\venv',
    'G:\\Projects\\projects_ai\\Langchain-Chatchat\\venv\\Lib\\site-packages',
]
USER_BASE: 'C:\\Users\\UryWu\\AppData\\Roaming\\Python' (exists)
USER_SITE: 'C:\\Users\\UryWu\\AppData\\Roaming\\Python\\Python311\\site-packages' (doesn't exist)
ENABLE_USER_SITE: False
```

因为这个venv虚拟环境是握从Langchain-Chatchat拷贝过来的，所以它用的是Langchain-Chatchat的第三方库site-packages，我pip uninstall pillow，结果只删掉Langchain-Chatchat下面的pillow库，而chatGLM-6B下面的库没动静。



最初在Langchain-Chatchat里创建venv的时候，用的anaconda的envs\\langchain，所以sys.path的前面四行是跟它相关的。

从这个文件里面也可以看出最初拷贝的是anaconda的langchain：

G:\Projects\projects_ai\ChatGLM-6B\venv\pyvenv.cfg

这个原始anaconda路径应该不用过多关注。

#### 问题

现在我想把第三方库的路径从`G:\\Projects\\projects_ai\\Langchain-Chatchat\\venv\\Lib\\site-packages`改为：`G:\Projects\projects_ai\ChatGLM-6B\venv\Lib\site-packages`

#### 方法

改不了路径，我只能把chatGLM-6B\venv删除了，然后重建python -m venv myvenv一个myvenv环境。然后重新装库pip install -r requirements.txt。

当然，torch-gpu可以从stable-diffusion-webui\VENV_DIR\Lib\site-packages直接拷贝过来，在chatGLM-6B运行pip list 可以看到torch。



#### 启示

果然还是不能从其他工程直接拷贝venv过来，要参考下面的[python依赖包整体迁移方法](https://www.jianshu.com/p/ac687886dbb0)

### [python依赖包整体迁移方法](https://www.jianshu.com/p/ac687886dbb0)



