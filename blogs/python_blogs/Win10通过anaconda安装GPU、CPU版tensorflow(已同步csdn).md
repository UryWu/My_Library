@[TOC](目录)

### 1. 安装anaconda

选择相应的Anaconda进行安装，下载地址点击[这里](https://www.anaconda.com/download/)，下载对应系统版本的Anaconda，官网现在的版本是Anaconda 5.2 for Python3.6，点击下载即可。如果下载python3.7的版本你就不能用低于1.13.1版本的tensorflow。

![image-20201030210930738](.\Win10通过anaconda安装GPU、CPU版tensorflow(已同步csdn).assets\image-20201030210930738.png)

注意选择所有用户，选Just Me你换一个windows账户就不能用anaconda了

<img src=".\Win10通过anaconda安装GPU、CPU版tensorflow(已同步csdn).assets\image-20201030211249587.png" alt="image-20201030211249587" style="zoom: 67%;" />

上面是勾选将python3.6添加进环境变量

<img src=".\Win10通过anaconda安装GPU、CPU版tensorflow(已同步csdn).assets\image-20201030211424113.png" alt="image-20201030211424113" style="zoom:67%;" />

这样Anaconda就安装好了，我们可以通过下面的命令来查看Anaconda已经安装了哪些包。 运行 开始菜单->Anaconda3—>Anaconda Prompt ，在弹出的命令窗口输入：`conda list` 。即可看到已经安装了numpy、sympy等常用的包。

### 2. 安装Tensorflow

TensorFlow目前在Windows下只支持Python 3.5版本。

#### 2.1 打开Anaconda Prompt

<img src=".\Win10通过anaconda安装GPU、CPU版tensorflow(已同步csdn).assets\image-20201030231348335.png" alt="image-20201030231348335" style="zoom:67%;" />

#### 2.2 使用清华镜像源

[输入清华仓库镜像，这样更新会快一些：](https://mirrors.tuna.tsinghua.edu.cn/help/pypi/)

```shell
pip install pip -U
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
```

#### 2.3 用Anaconda创建一个python环境

在Anaconda Prompt中利用Anaconda创建一个python3.6的环境，参数-n后就是环境名称，为tensorflow，输入下面命令：

```shell
conda create -n tensorflow python=3.6
```

查看当前所拥有的环境的conda命令：

```shell
conda env list
```

![image-20201030234330711](.\Win10通过anaconda安装GPU、CPU版tensorflow(已同步csdn).assets\image-20201030234330711.png)

[更多conda命令点我](https://blog.csdn.net/qq_25799253/article/details/88563775)

#### 2.4 在Anaconda Prompt中启动tensorflow环境：

```shell
activate tensorflow //关闭命令为：deactivate
```

#### 2.5.1 安装TensorFlow-cpu版(可选)：

```shell
pip install tensorflow
```

安装指定版本可输入：

```shell
pip install tensorflow==1.12.0
```

测试代码：

```python
import tensorflow as tf
print(tf.__version__)
```

输出`1.12.0`

![image-20201030232620772](.\Win10通过anaconda安装GPU、CPU版tensorflow(已同步csdn).assets\image-20201030232620772.png)

你已经成功安装了cpu版tensorflow。

#### 2.5.2 安装TensorFlow-gpu版(可选)：

```shell
//GPU版本，根据自己需要选择版本号，没有的话会安装最新的版本
pip install tensorflow-gpu==1.12.0
```

安装cuda

```shell
conda install cudatoolkit=10.0.130
```

安装cudnn

```shell
conda install cudnn=7.6.0
```

测试gpu版tensorflow

在Anaconda Prompt中启动tensorflow环境，并进入python环境。

![image-20201030232522685](.\Win10通过anaconda安装GPU、CPU版tensorflow(已同步csdn).assets\image-20201030232522685.png)

测试gpu版tensorflow

运行此tensorflow_self_check.py文件可以测试你的CUDA、Cudnn与tensorflow是否安装成功：

```python
# Copyright 2015 The TensorFlow Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==============================================================================
"""A script for testing that TensorFlow is installed correctly on Windows.
The script will attempt to verify your TensorFlow installation, and print
suggestions for how to fix your installation.
"""
 
import ctypes
import imp
import sys
 
def main():
  try:
    import tensorflow as tf
    print("TensorFlow successfully installed.")
    if tf.test.is_built_with_cuda():
      print("The installed version of TensorFlow includes GPU support.")
    else:
      print("The installed version of TensorFlow does not include GPU support.")
    sys.exit(0)
  except ImportError:
    print("ERROR: Failed to import the TensorFlow module.")
 
  candidate_explanation = False
 
  python_version = sys.version_info.major, sys.version_info.minor
  print("\n- Python version is %d.%d." % python_version)
  if not (python_version == (3, 5) or python_version == (3, 6)):
    candidate_explanation = True
    print("- The official distribution of TensorFlow for Windows requires "
          "Python version 3.5 or 3.6.")
  
  try:
    _, pathname, _ = imp.find_module("tensorflow")
    print("\n- TensorFlow is installed at: %s" % pathname)
  except ImportError:
    candidate_explanation = False
    print("""
- No module named TensorFlow is installed in this Python environment. You may
  install it using the command `pip install tensorflow`.""")
 
  try:
    msvcp140 = ctypes.WinDLL("msvcp140.dll")
  except OSError:
    candidate_explanation = True
    print("""
- Could not load 'msvcp140.dll'. TensorFlow requires that this DLL be
  installed in a directory that is named in your %PATH% environment
  variable. You may install this DLL by downloading Microsoft Visual
  C++ 2015 Redistributable Update 3 from this URL:
  https://www.microsoft.com/en-us/download/details.aspx?id=53587""")
 
  try:
    cudart64_80 = ctypes.WinDLL("cudart64_80.dll")
  except OSError:
    candidate_explanation = True
    print("""
- Could not load 'cudart64_80.dll'. The GPU version of TensorFlow
  requires that this DLL be installed in a directory that is named in
  your %PATH% environment variable. Download and install CUDA 8.0 from
  this URL: https://developer.nvidia.com/cuda-toolkit""")
 
  try:
    nvcuda = ctypes.WinDLL("nvcuda.dll")
  except OSError:
    candidate_explanation = True
    print("""
- Could not load 'nvcuda.dll'. The GPU version of TensorFlow requires that
  this DLL be installed in a directory that is named in your %PATH%
  environment variable. Typically it is installed in 'C:\Windows\System32'.
  If it is not present, ensure that you have a CUDA-capable GPU with the
  correct driver installed.""")
 
  cudnn5_found = False
  try:
    cudnn5 = ctypes.WinDLL("cudnn64_5.dll")
    cudnn5_found = True
  except OSError:
    candidate_explanation = True
    print("""
- Could not load 'cudnn64_5.dll'. The GPU version of TensorFlow
  requires that this DLL be installed in a directory that is named in
  your %PATH% environment variable. Note that installing cuDNN is a
  separate step from installing CUDA, and it is often found in a
  different directory from the CUDA DLLs. You may install the
  necessary DLL by downloading cuDNN 5.1 from this URL:
  https://developer.nvidia.com/cudnn""")
 
  cudnn6_found = False
  try:
    cudnn = ctypes.WinDLL("cudnn64_6.dll")
    cudnn6_found = True
  except OSError:
    candidate_explanation = True
 
  if not cudnn5_found or not cudnn6_found:
    print()
    if not cudnn5_found and not cudnn6_found:
      print("- Could not find cuDNN.")
    elif not cudnn5_found:
      print("- Could not find cuDNN 5.1.")
    else:
      print("- Could not find cuDNN 6.")
      print("""
  The GPU version of TensorFlow requires that the correct cuDNN DLL be installed
  in a directory that is named in your %PATH% environment variable. Note that
  installing cuDNN is a separate step from installing CUDA, and it is often
  found in a different directory from the CUDA DLLs. The correct version of
  cuDNN depends on your version of TensorFlow:
  
  * TensorFlow 1.2.1 or earlier requires cuDNN 5.1. ('cudnn64_5.dll')
  * TensorFlow 1.3 or later requires cuDNN 6. ('cudnn64_6.dll')
    
  You may install the necessary DLL by downloading cuDNN from this URL:
  https://developer.nvidia.com/cudnn""")
    
  if not candidate_explanation:
    print("""
- All required DLLs appear to be present. Please open an issue on the
  TensorFlow GitHub page: https://github.com/tensorflow/tensorflow/issues""")
 
  sys.exit(-1)
 
if __name__ == "__main__":
  main()
```



### 3. 在pycharm中使用tensorflow

pycharm里创建或打开一个工程，File->Settings

<img src=".\Win10通过anaconda安装GPU、CPU版tensorflow(已同步csdn).assets\image-20201030233033315.png" alt="image-20201030233033315" style="zoom: 80%;" />

![image-20201030233226456](.\Win10通过anaconda安装GPU、CPU版tensorflow(已同步csdn).assets\image-20201030233226456.png)

![image-20201030233246530](.\Win10通过anaconda安装GPU、CPU版tensorflow(已同步csdn).assets\image-20201030233246530.png)

![image-20201030233319164](.\Win10通过anaconda安装GPU、CPU版tensorflow(已同步csdn).assets\image-20201030233319164.png)

找到anaconda3的安装位置：

<img src=".\Win10通过anaconda安装GPU、CPU版tensorflow(已同步csdn).assets\image-20201030233412083.png" alt="image-20201030233412083" style="zoom:67%;" />

#### 3.1 选择base环境

直接选择这个Anaconda3-2019.10-Windows-x86_64目录下的python.exe就是选择base环境的python：

<img src=".\Win10通过anaconda安装GPU、CPU版tensorflow(已同步csdn).assets\image-20201030233512139.png" alt="image-20201030233512139" style="zoom: 67%;" />



<img src=".\Win10通过anaconda安装GPU、CPU版tensorflow(已同步csdn).assets\image-20201030234534672.png" alt="image-20201030234534672" style="zoom:67%;" />

#### 3.2 选择其它环境

刚刚创建的环境也在Anaconda安装目录的envs文件夹下，我这里有四个环境：mxnet、NLP、pytorch、tensorflow

<img src=".\Win10通过anaconda安装GPU、CPU版tensorflow(已同步csdn).assets\image-20201030234803355.png" alt="image-20201030234803355" style="zoom:67%;" />

点开你要选择的文件夹，选择里面的python.exe就是为你当前pycharm打开的工程选择python环境了。

<img src=".\Win10通过anaconda安装GPU、CPU版tensorflow(已同步csdn).assets\image-20201030235023361.png" alt="image-20201030235023361" style="zoom:67%;" />

### 4. 参考链接

[Win10下用Anaconda安装TensorFlow（CPU和GPU）](https://blog.csdn.net/Gransand/article/details/80713810?utm_medium=distribute.pc_relevant.none-task-blog-utm_term-11&spm=1001.2101.3001.4242)







### 5. 其它知识



#### [conda可指定cudatoolkit](https://www.bilibili.com/video/BV15Q4y1i7Bp/?p=2&spm_id_from=pageDriver)

刘畚今天抓到了吗

补充一下：conda比virtualenv, venv好的地方就在于可以用cudatoolkit来指定cuda的版本，相当于在虚拟环境中把CUDA也放了进来。
曾经想要在一个环境里装pytorch >=1.5.0, tensorflow == 1.13.xx，然后手动安装CUDA版本各种不兼容，最后用cudatoolkit终于成功了。
另外up主什么时候讲conda，也挺实用的![[doge]](Win10通过anaconda安装GPU、CPU版tensorflow(已同步csdn).assets/3087d273a78ccaff4bb1e9972e2ba2a7583c9f11.png@48w_48h.webp)

2021-12-03 10:44👍11



##### 最简单的方法是用线上jupyter notebook 服务器直接用docker

小CCai

最简单的方法是用线上jupyter notebook，比如Kaggle、Google colab以及和鲸等等，这些平台都支持GPU加速。个人电脑上跑小模型还可以，大模型就要服务器。个人电脑只有英伟达显卡才支持CUDA，用anaconda很容易安装，但是要注意cuda和显卡驱动的对应关系。服务器配置直接用docker，即可快速配置环境![[doge]](Win10通过anaconda安装GPU、CPU版tensorflow(已同步csdn).assets/3087d273a78ccaff4bb1e9972e2ba2a7583c9f11.png@48w_48h-16827909544441.webp)

2021-12-03 23:4841



