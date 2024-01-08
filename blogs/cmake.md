---
number headings: auto, first-level 3, max 6, contents ^toc, start-at 1, 1.1
---
## 夏曹俊
### 1 部分大纲
![](cmake.assets/image-20230921102814045.png)
![](cmake.assets/image-20230921103927210.png)

cmake链接静态库
![](cmake.assets/image-20230921103819466.png)

### 2 [cmake构建c++项目快速入门2-1](https://www.bilibili.com/video/BV1mP411V7mu/)
2.4万 2022-09-01 19:36:17
跨平台编译工具。

cmake的官方手册的镜像站：[cmake.org.cn](http://cmake.org.cn/)
#### 2.1 [P1 cmake章节介绍](https://www.bilibili.com/video/BV1mP411V7mu?p=1)
[视频时间戳：](https://www.bilibili.com/video/BV1mP411V7mu?t=1.5)
第一章CMake快速入门-执行程序和动态库的构建
1.1 cmake基本概念
	1.1.1 是什么
	1.1.2 为什么选用cmake
	1.1.3 cmake工作原理
1.2 cmake安装
	1.2.1 Linux安装CMake(ubuntu)
	1.2.2 MacOS安装
	1.2.3 Windows安装
1.3 cmake第一个示例cmakelists
	前置准备
	动态库和静态库概念(xlog)
	cmake编译静态库
	cmake链接静态库
	cmake动态库 编译链接
1.4 cmake构建静态库与动态库

#### 2.2 [P2 1cmake是什么为什么要好的构建工具](https://www.bilibili.com/video/BV1mP411V7mu?p=2)
你想避免硬偏码路径
您需要在多台计算机上构建一个包
你想使用CI（持续集成）
你需要支持不同的操作系统（交叉编译window开发，arm、安卓运行）
你想支持多个编译器（MSVC编译的工程在安卓上用Clang编译运行）
您想使用IDE，但不是所有情况（VS2022、QtCreator可以直接打开cmake工程）
你想描述你的程序的逻辑结构，而不是标志和命令
你想使用库
您想使用其他工具来帮助您编写代码moc ProtoBuf（和QT结合生成界面，和git结合下载代码）
你想使用单元测试

#### 2.3 [P3 2持续集成](https://www.bilibili.com/video/BV1mP411V7mu?p=3)
每次集成都通过自动化的制造（包括提交、发布、自动化测试）来验证，准确地发现集成错误。
快速错误，每完成一点更新，就集成到主干，可以快速发现错误，定位错误也比较容易。
各种不同的更新主干，如果不经常集成，会导致集成的成本变大。
让产品可以快速地通过，同时保持关键测试合格。
自动化测试，只要有一个测试用例不通过就不能集成。cmake、google test自动化测试。
集成并不能删除发现的错误，而是让它们很容易和改正。

#### 2.4 [P4 3为什么用cmake及它的特性](https://www.bilibili.com/video/BV1mP411V7mu?p=4)

自动搜索可能需要的程序、库和头文件的能力。
独立的构建目录，可以安全清理。vs编译链接生成很多的.obj .so文件，所有输出的文件都在一个目录下，方便清理。
创建复杂的自定义命令，路径、参数转递，项目前面生成的东西，后面要用。
配置时选择可选组件的能力，opencv组件引入。做通用库的时候方便。
从简单的文本文件(CMakeLists.txt)自动生成工作区和项目的能力，非常简单，没有过多目录要求。
在静态和共享构建之间轻松切换的能力，静态库和动态库，添加不同平台的宏，不需要与具体的编译器去耦合。
在大多数平台上自动生成文件依赖项并支持并行构建

#### 2.5 [P5 4cmake工作原理图解分析](https://www.bilibili.com/video/BV1mP411V7mu?p=5)
![](cmake.assets/image-20230919170117549.png)
vs2022直接打开CMakeLists.txt文件构建项目。

cmake（执行程序）读取CMakeLists.txt生成Makefile，make（执行程序）读取Makefile生成执行程序。
#### 2.6 [P6 5cmake源码linux_ubuntu_编译安装](https://www.bilibili.com/video/BV1mP411V7mu?p=6)
1.2.1 Linux安装CMake (ubuntu 20.04 LT)

一 前置要求
	安装好ubuntu20.04版本64位系统
	配置好系统网络
	准备好cmake源码 cmake-3.23.1.tar.gz
二 直接安装 
	apt install cmake（版本不一定最新）
	二进制安装 （不一定要用，用自己编译好的，最好自己编译cmake）
三 源码编译安装 （）
	1 安装编译工具和依赖库
		sudo apt install g++ （因为要编译C++代码）
		sudo apt install make （没有cmake的时候要用make来编译）
		sudo apt install ninja-build （与make同等级，体验更换编译场景）
		apt install unzip （不用这个用tar解压也可）
		sudo apt install libssl-dev （注意ubuntu linux版本，用于编译cmake源码，加密传输用，以后的工程项目有可能用到）
	2 下载解压cmake源码并编译
		wget https://github.com/Kitware/CMake/releases/download/v3.23.1/cmake-3.23.1.tar.gz  
		tar -xvf cmake-3.23.1.tar.gz
		cd cmake-3.23.1
		./configure （生成CMakeLists.txt文件）
		make -j32 （编译生成可执行文件）
	3 安装编译好的cmake [视频时间戳：](https://www.bilibili.com/video/BV1mP411V7mu?t=589.3&p=6)
		sudo make install	安装路径在/usr/local/share/cmake-3.23
	4 设置cmake的运行路径 （为了在任意位置使用cmake命令，不加好像也可以）
		vi ~/.bash_profile
		文件中添加
		export PATH=/usr/local/share/cmake-3.22:$PATH
	5 运行cmake查看版本
		cmake--version  
		output:
			cmake version 3.23.1
			CMake suite maintained and supported Kitware (kitware.com/cmake).

#### 2.7 [P7 6cmake windows安装二进制版本](https://www.bilibili.com/video/BV1mP411V7mu/?p=7)
一 前置要求
	安装好vs开发工具2017、2019、2022都可以
	准备好cmake的源码和二进制发行包
		源码同上linux
		cmake3.23.1二进制发行包
二 发布文件安装
	1 windows系统属性-》高级-》环境变量=》设置
三 源码编译安装（选学）用cmake构建cmake
	解压源码后控制台进入cmake源码目录
	生成项目文件cmake-S -B b
	编译cmake --build b --config Release
	安装cmake --install b C:/Program Files (x86)/CMake/

#### 2.8 [P8 7windows下使用cmake编译cmake源码](https://www.bilibili.com/video/BV1mP411V7mu?p=8 "7windows下使用cmake编译cmake源码并安装")

[视频时间戳：](https://www.bilibili.com/video/BV1mP411V7mu?t=150.0&p=8)
cmake后面的点表示在当前目录下搜索CMakeLists.txt文件来构建项目。
```shell
cmake .
```

但是生成的makefile文件和源码同目录，会很杂乱，所以：
```shell
md build
cd build
cmake ..
```
创建一个build文件夹来放置构建生成的makefile文件，然后使用父目录..下的CMakeLists.txt。
缩写到一行：
`md build && cd build && cmake ..`

##### 2.8.1 <font color="#ff0000">构建</font>
[视频时间戳：](https://www.bilibili.com/video/BV1mP411V7mu?t=167.9&p=8)
```shell
cmake -S <CMakeLists.txt源目录> -B <构建目录build位置>
示例：构建当前目录，在build1文件夹里构建。
cmake -S . -B build1
```

构建完成以后，build1里有：.sln解决方案文件、.vcxproj项目文件、Test用例、CMakeFiles缓存文件。
如果构建过程有误，可以直接删除build1。
##### 2.8.2 <font color="#ff0000">编译</font>
###### 2.8.2.1 debug模式编译
[视频时间戳：](https://www.bilibili.com/video/BV1mP411V7mu?t=253.9&p=8)
你可以直接打开项目来构建，但是以后我们都是自动化编译、打包、上传。
就不能打开项目，要通过命令行的方式。
自动化构建还要考虑不同平台的情况，如果在不同的平台一个一个地打开项目就太麻烦了。

```shell
编译build1目录里的项目：
cmake --build build1
使用32线程编译则：
cmake --build build1 -j32
```

或者使用make这样编译：
```shell
cd build1
make
使用32线程编译则：
make -j32
```

编译链接的结果在build1/bin/debug目录里，都是一些.exe .pdb文件，
就可以安装了。默认编译的方式是debug方式，生成的.exe .pdb文件相对release方式会大很多，因为debug模式的exe里增加了很多调试的代码，而release方式做了优化。

[视频时间戳：](https://www.bilibili.com/video/BV1mP411V7mu?t=365.6&p=8)
将项目生成的库文件、头文件、可执行文件或相关文件等安装到指定位置（系统目录，或发行包目录）。在cmake中，这主要是通过install方法在CMakeLists.txt中配置，make install命令安装相关文件来实现的。
支持第三方模块的CMakeLists.txt的安装。
```shell
cmake --install build1
```

不设置的话，系统默认安装在`C:\Program Files (x86)\`
比如这次我构建、编译的cmake安装路径就是：
`C:\Program Files (x86)\CMake\`
CMake目录只有doc，doc只有cmake-3.27。
cmake-3.27是我这次演示用的项目。里面有很多文件夹，文件夹里面都是一些LICENSE、COPYING、NOTICE文件，都是版权、声明什么的。
[【CMake】cmake的install指令\_cmake --install\_Yngz\_Miao的博客-CSDN博客](https://blog.csdn.net/qq_38410730/article/details/102837401)
###### 2.8.2.2 release模式编译：

```shell
cmake --build build1 --config Release
```
编译的结果在build1/bin/Release目录里。

安装：
```shell
cmake --install build1
```
非常意思，release模式的install不像debug只安装doc版权声明文件，他会安装bin、share文件，doc版权声明文件也安装。
安装过程的输出见：[cmake_install_log.txt](file:///G:/Projects/projects_cpp/cmake-3.27.5/cmake_install_log.txt)

现在这个`C:\Program Files (x86)\CMake\`就可以打包成压缩文件，作为软件的官方发行版发布了，里面有声明什么的，而`G:\Projects\projects_cpp\cmake-3.27.5\build1\bin\Release`编译目录下，只有exe文件，可以执行，但是不能作为官方的、详细的、有帮助文件的、有版权信息的发行版。


#### 2.9 [P10 9fist_cmake第一个CMakeLists.txt示例](https://www.bilibili.com/video/BV1mP411V7mu/?p=10)

一 前置准备
	准备测试的c++程序文件first_cmake.cpp
	在源码的同目录下编写第一个CMakeLists.txt

[视频时间戳：](https://www.bilibili.com/video/BV1mP411V7mu?t=252.2&p=10)
项目代码文件原则是全小写，windows中大小写无关，你写cmakelists.txt也行，他应该做了处理，先找最符合条件的CMakeLists.txt然后再找cmakelists.txt，而linux大小写敏感。
建议还是按照CMakeLists.txt来写，博主不敢保证其他平台大小写无关。

[视频时间戳：](https://www.bilibili.com/video/BV1mP411V7mu?t=375.8&p=10)
```cmake
#指定cmake最低版本
cmake_minimum_required(VERSION 3.20)

#构建项目的名称 没有加双引号表示字符串 cmake字符串不用加引号
project(first_cmake)

#构建执行程序
add_executable(first_cmake 101first_cmake.cpp)

```

鸿蒙项目要求101first_cmake.cpp这个程序文件的名字全都手打进入，是为了更好控制，因为可能存在乱码问题，而且有的乱码字符是无法通过肉眼发现的。但是我们就把它存到一个变量里去了。

101first_cmake.cpp
```cpp
#include <iostream>
using namespace std;
int main(int argc, char *argv[])
{
    cout<<"first CMake TEST"<<endl;

    return 0;
}
```


二 Windows平台编译
三 Linux(Ubuntu)平台编译
四 MacOS平台编译


### 3 [cmake构建c++项目快速入门2-2](https://www.bilibili.com/video/BV1TU4y1z7UH/)

#### 3.1 [P1 11windwos下用cmake生成nmake的项目并编译](https://www.bilibili.com/video/BV1TU4y1z7UH/)
Visual Studio 2022支持直接打开CMakeLists.txt

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=141.1)
除了用Visual Studio 2022来编译CMakeLists.txt，还可以用nmake。在某些场景只能用nmake编译。

[三种编译CMake项目的方法](https://www.bilibili.com/video/BV1TU4y1z7UH?t=356.6)
##### 3.1.1 cmake 
```cmake
cmake --build build1
```
build1为`cmake -S . -B build1`，构建后的目录。

##### 3.1.2 Visual Studio 2022
直接用Visual Studio 2022打开CMakeLists.txt文件，然后点击
![](cmake.assets/image-20230920190332624.png)

在项目首次打开以后，删除掉out还是build之后，都不能使项目正常运行。
![](cmake.assets/image-20230920191759220.png)
修改了源代码，直接运行就行，cmake会自动检测你更新的地方，然后自动编译。


##### 3.1.3 nmake
在对某些包进行编译时，只能用nmake。
###### 3.1.3.1 进入nmake命令行
点击windows按钮，点击首字母V，找到Visual Studio 2022，点击x64 Native Tools Command Prompt
x64 Native是64位平台编译，x64_x86是64位平台编译32位程序，x86_x64是32位平台编译64位程序。
![|238](cmake.assets/image-20230920190908981.png)
进入后：
![](cmake.assets/image-20230920191130142.png)
进入项目目录：
```shell
cd /d G:\Projects\projects_cpp\101first_cmake
```
/d是跨磁盘跳转路径。

###### 3.1.3.2 构建makefile：
```cmake
cmake -S . -B build1 -G "NMake Makefiles"
```
-G表示用其他的编译器，不加的话，cmake默认用的就是Visual Studio 2022的编译器。`NMake Makefiles`必须区分大小写。
构建makefile输出：
```shell
-- Build files have been written to: G:/Projects/projects_cpp/101first_cmake/build1
```
所有准备给nmake用于编译的文件都在build1里。

想用其他的编译器可以打一个错的，写`cmake -S . -B build1 -G "NMake"`，在提示里面选择其他的编译器。
选择其他的编译器输出：
```shell
Generators
* Visual Studio 17 2022        = Generates Visual Studio 2022 project files.
                                 Use -A option to specify architecture.
  Visual Studio 16 2019        = Generates Visual Studio 2019 project files.
                                 Use -A option to specify architecture.
  Visual Studio 15 2017 [arch] = Generates Visual Studio 2017 project files.
                                 Optional [arch] can be "Win64" or "ARM".
Borland Makefiles            = Generates Borland makefiles.
NMake Makefiles              = Generates NMake makefiles.
CodeBlocks - MinGW Makefiles = Generates CodeBlocks project files
                                 (deprecated).
CodeBlocks - NMake Makefiles = Generates CodeBlocks project files
                                 (deprecated).
```

###### 3.1.3.3 编译
进入上面生成的build1目录：
```shell
cd build1
```

![](cmake.assets/image-20230920193234170.png)

使用nmake编译：
```shell
nmake
```
#### 3.2 [P2 12linux和macos下编译第一个cmake c++项目](https://www.bilibili.com/video/BV1TU4y1z7UH/?p=2)
前置准备
	安装好gcc编译工具
		`sudo apt install g++`
	`sudo apt install make`
	如果需要用到Ninja
		`sudo apt install ninja-build`

生成项目文件
	生成makefile  ` sudo cmake -S . -B build1`
	生成Ninja项目   `sudo cmake -S . -B build1 -G "Ninja"`
	编译可以先进入`cd build1`目录，然后输入命令`make`，或者用命令`cmake --build build1`，多线程编译则增加-j32

指定项目工具
	在linux主要有两种，一种是生成make的makefile一种是生成Ninja的build.ninja
	生成makefile见上面示例生成Ninja
	`cmake .. -G "Ninja"`

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=224.0&p=2)
跳过MacOS平台开发。

#### 3.3 [P3 13编译cmake库的前置准备和静态库的实战原理分析](https://www.bilibili.com/video/BV1TU4y1z7UH?t=1.7&p=3)

![](cmake.assets/image-20230921103307142.png)
##### 3.3.1 静态库
比如静态库xlog
###### 3.3.1.1 文件名
[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=38.3&p=3)
在windows下，静态库文件名叫：`xlog.lib`
静态库的本质是二进制源码编译进去的库，  debug版本编译进去的是字符源码，因为这样能够通过代码跟进的方式来调试 。
在linux中没有区分debug版和release版，window则debug版静态库叫`xlog_d.lib`加一个_d，release版本叫`xlog.lib`。

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=163.0&p=3)
在linux下，静态库文件名叫：`libxlog.a`，前面加一个lib，后缀为a。

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=230.2&p=3)
在MacOS下，静态库文件名也叫：`libxlog.a`，但是动态库不一样。

###### 3.3.1.2 本质
[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=239.5&p=3)
基本可以理解为编译后的二进制代码，类似.o

代码执行前，先编译源代码成.o文件，然后再链接.o文件成.exe可执行文件。
在windows下，编译是把源代码.cpp文件编译成.obj文件。

##### 3.3.2 使用静态库文件和动态库文件区别：
**版权问题**
.lib静态库文件可以理解为多个.o文件合并到一起。它就是把你的源代码编译到.lib或.exe里面去，别人是看不到里面的内容的，不知道代码是用了什么第三方库来写。 
你使用的第三方开源库的协议一般只允许使用它的动态开源库，想使用它的静态库一般要对方授权的，否则就是侵权的。

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=350.1&p=3)
**依赖库问题**
同时引入一个模块的静态库和动态库的冲突

.lib静态库文件相当于.o文件
如果你的静态库文件用到了第三方库，你也需要把第三方库引入。
你的一个静态库文件用到了多线程的静态库文件，而另外一个程序调用你的这个静态库，但是他调用的是多线程的动态库文件，这样编译就会报错，显示两个库不一致。因为相当于一个库引用了两次，他们的名字是不同的，分静态、动态，会产生冲突。

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=434.5&p=3)
拿到授权之后，引入静态开源库时，你的项目的配置是不能改的。改了又会涉及别人对你的调用。那你只能改开源库，重新编译，编译成你能加载的。如果你只拿到开源库的二进制发行包，那么就编译也编译不了了。

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=460.4&p=3)
动态库没有这种问题，你用的多线程是静态库，我用的多线程是动态库，不产生冲突。 因为动态库是分开的，我只调用你的接口，之后的动作dll内部去实现。 静态库引入是把静态库里面的代码都放到我的代码里，相当于两份代码合并。而动态库只是把函数的地址编译进我的代码， 只是动态调用你，没有冲突。

**动态库文件编译时间短**
[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=495.7&p=3)
调用静态库时，链接的时间比较长，因为是把静态库里所有的代码，函数都放进来。而动态库链接比较短，因为只调用了一个地址。
[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=524.3&p=3)
链接时间长的多长呢？之前的一个项目用到了大量静态库，项目还不算大，但是编译、链接时间有10分钟，而换作动态库只用了1分钟。

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=553.1&p=3)
动态库这么多优点，缺点在哪？动态库在运行时，不需要加载。在windows下程序调用动态库需要放在与程序相同的目录下，在linux下调用动态库，需要在系统环境变量里指定，或是把路径写在程序里。

运行时，动态库麻烦。编译时，静态库麻烦。

#### 3.4 [P4 14动态库原理和头文件作用](https://www.bilibili.com/video/BV1TU4y1z7UH/?p=4)
![](cmake.assets/image-20230921103333485.png)
##### 3.4.1 动态库
⠀⠀⠀在windows下，以xlog.dll为例，调用.dll文件时，会生成两个文件，一个是xlog.lib，另一个是xlog.dll。这里的xlog.lib非常小，它有时候会加一个后缀，用于与普通的，存放代码的.lib静态库文件区分开。
⠀⠀⠀这里的xlog.lib里面存放的东西是函数地址索引， 这些索引指向xlog.dll里的函数二进制代码。
⠀⠀⠀xlog.lib用于在编译程序时，当你需要用到某个库的函数的时候，直接去这个.lib找函数的地址就行了，不需要去.dll里找。在运行时，再去.dll里找函数。
⠀⠀⠀当然还要区分debug版和release版。windows下还要在xlog.lib、xlog.dll的名字后再加一个_d。或者分不同的debug、release目录。

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=131.1&p=4)
在linux下，动态库叫：libxlog.so，前缀lib，后缀.so。
我们在链接动态库的时候，无法区分是静态库还是动态库。 全都加进来，只能通过地址区分。

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=182.1&p=4)
在macOS下，动态库叫：libxlog.dylib，前缀lib，后缀.dylib。

在windows中加载动态库只加载一次，有优化。

##### 3.4.2 头文件作用
![](cmake.assets/image-20230921103421967.png)
[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=260.4&p=4)
动态库，函数存在.dll，函数地址索引存在.lib。
windows的静态库.lib放的是所有的函数，所有的代码都是函数，变量也是特殊的函数。类本身不会被存储，它是内存结构而已。

为什么其他语言可以调用cpp的库，你只要定义好函数出栈、入栈的顺序，地址访问的类型就好了。

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=348.0&p=4)
头文件的作用：
函数名称和参数类型（用于索引查找函数地址）

给编译器链接的时候用的，通过函数的名字在所有的.o、.dll里查找函数。
c++支持重载，查找的时候还要把形式参数也编译进去，成为另一个字符串来查找。

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=413.9&p=4)
不引用，可以自己直接声明函数。
知道名字可以调用系统api查找函数。

#### 3.5 [P5 15cmake静态库xlog跨平台编译windows、linux、macos](https://www.bilibili.com/video/BV1TU4y1z7UH/?p=5)

##### 3.5.1 linux平台下编译静态库
```cpp
//xlog.h
#ifndef XLOG_H
#define XLOG_H
class XLog
{
public:
	XLog();
};
#endif
```

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=233.2&p=5)
`#ifndef XLOG_H`如果已经引入了xlog.h就不再引入了，当然不是说这个xlog.h只能访问一次，而是单个的c/cpp只能访问一次。 

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=254.4&p=5)
```cpp
//xlog.cpp
#include "xlog.h"
#include <iostream>
using namespace std;
XLog::XLog()
{
	cout<<"Create XLog"<<endl;
}
```

###### 3.5.1.1 <font color="#ff0000">add_library</font>

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=298.0&p=5)
```cmake
#CMakeLists.txt
cmake_minimum_required(VERSION 3.20)
project(xlog)
add_library(xlog STATIC xlog.cpp xlog.h)
```
`cmake_minimum_required()`，要求的cmake的最低版本。
`project()`项目的名称。
`add_library(库的名字 静态/动态 什么文件来编译生成这个库)`。
库的名字不需要增加前缀的lib或者后面的后缀，还有版本号，各个编译器会去补足。
可以不写头文件xlog.h，把xlog.h放进来的目的是，如果头文件改变了，也需要重新编译。后面我们对头文件和cpp文件是要分开处理的。

```shell
cmake -S . -B build1
cmake --build build1
```

编译结果就是这个libxlog.a静态库：
![](cmake.assets/image-20230921004116512.png)

##### 3.5.2 windows平台下编译静态库
[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=503.6&p=5)
代码、命令同上。
编译后生成：
xlog.pdb
xlog.lib
##### 3.5.3 macOS平台下编译静态库
[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=612.7&p=5)
代码、命令同上。
编译后生成：
libxlog.a
与linux的静态库完全一样。

#### 3.6 [P6 16cmake 链接静态库](https://www.bilibili.com/video/BV1TU4y1z7UH/?p=6)

```cpp
//test_xlog.cpp
#include <iostream>
#include "xlog.h"
using namespace std;
int main()
{
	XLog log;
	cout<<"test xlog"<<endl;
	return 0;
}
```

##### 3.6.1 linux下链接静态库
###### 3.6.1.1 <font color="#ff0000">include_directories</font>

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=252.4&p=6)
```cmake
#CMakeLists.txt test_xlog 102
cmake_minimum_required(VERSION 3.20)
project(test_xlog)
include_directories("../xlog")
add_executable(test_xlog test_xlog.cpp)
```

`add_executable(test_xlog test_xlog.cpp)`，test_xlog是输出的可执行文件的名字，test_xlog.cpp是源代码。

[视频时间戳：没有引入头文件时编译报错](https://www.bilibili.com/video/BV1TU4y1z7UH?t=520.1&p=6)
![](cmake.assets/image-20230921020606940.png)
[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=570.1&p=6)
`include_directories("../xlog")`，设定头文件查找的路径，可以设置多个。这里`../xlog`路径下的头文件只有一个，是xlog.h。注意xlog是目录不是头文件的名字。相对路径就是相对CMakeLists.txt文件的位置，此时它的路径102cmake_lib/test_xlog/CMakeLists.txt。
![](cmake.assets/image-20230921124321333.png)

[视频时间戳：没有引入头文件的实现cpp文件](https://www.bilibili.com/video/BV1TU4y1z7UH?t=660.7&p=6)
![](cmake.assets/image-20230921020849616.png)
如果把库放在系统的/usr/lib/目录下，那么cmake不需要另外去查找，cmake会优先查找系统的/usr/lib/目录下的库。如果库不在系统目录下，则需要指定库查找路径。

###### 3.6.1.2 <font color="#ff000 0">link_directories</font>

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=719.7&p=6)
指定头文件、库文件查找路径以及具体的库，可能一个库文件里有多个类，即多个库。

```cmake
#CMakeLists.txt test_xlog 102
cmake_minimum_required(VERSION 3.20)
project(test_xlog)
#指定头文件查找路径，头文件叫xlog.h
include_directories("../xlog")

#指定库查找路径 test_xlog可执行文件要用的库叫libxlog.a，在以下路径
link_directories("../xlog/build1")

#编译链接成的可执行文件：test_xlog 源代码：test_xlog.cpp
add_executable(test_xlog test_xlog.cpp)

#指定加载的库 要放在添加执行程序之后，要给test_xlog可执行文件加属性，属性的依赖在静态库libxlog.a、xlog.lib里，这里只写xlog。还可以加public、private参数。
target_link_libraries(test_xlog xlog)
```

[视频时间戳：要加载的libxlog.a库在这里](https://www.bilibili.com/video/BV1TU4y1z7UH?t=936.1&p=6)
![](cmake.assets/image-20230921034809839.png)

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=960.9&p=6)
```cmake
sudo rm -rf build1
sudo cmake -S . -B build1
sudo cmake --build build1
```

```shell
test_xlog
```
运行结果：
![](cmake.assets/image-20230921081251539.png)

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=1006.2&p=6)
![](cmake.assets/image-20230921081717670.png)
库路径xlog/libxlog.a

##### 3.6.2 [windows下链接静态库](https://www.bilibili.com/video/BV1TU4y1z7UH?t=1044.4&p=6)

注意windows下xlog.lib在build1/debug路径下：
![](cmake.assets/image-20230921082426411.png)

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=1120.7&p=6)
```cmake
cmake -S . -B build1
cmake --build build1
```

```shell
cd build1\Debug
test_xlog
```
输出：
```shell
Create XLog
test xlog
```
成功！说明不需要给静态库xlog.lib指定位置`../build1/Debug`路径，只需要指定到`../build1`，windows会自动根据你的cmake编译命令在build1路径下查找Debug版还是Release版。

Debug编译：
`cmake --build build1`
Release编译：
`cmake --build build1 --config Release`

#### 3.7 [P7 17cmake 动态库编译和链接linux](https://www.bilibili.com/video/BV1TU4y1z7UH/?p=7)
与静态库的编译、链接几乎一样。
add_library(xlog STATIC xlog.cpp)里的STATIC改成SHARED就可以了。
有时候不加STATIC默认链接的就是动态库，不过这个得看你的默认配置。

本集如果只变动这一个参数就太简单了，所以增加内容：库和测试项目在一个CMakeLists.txt中配置。

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=73.8&p=7)
⠀⠀⠀常写linux程序的朋友都知道，静态库只有编译期间才需要找到这个库，动态库在运行时也需要被找到。
⠀⠀⠀为了能使程序在运行的时候能找到动态库，我们把动态库写到环境变量中，通过环境变量来查找动态库。或者把动态库的绝对路径写到代码中，程序运行时可以找到动态库，但是如果源码被删了，而且动态库变动了，程序就不知道动态库的地址了。

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=149.9&p=7)
从这个视频时间戳往后的内容的不要看，这里报错了，而且讲得乱七八糟的。
`add_executable(test_xlog test_xlog/test_xlog.cpp xlog)`，最后的xlog库不能添加进来，这是错误的写法。
知道为什么要重录吗？因为 add_executable 根本不能加库，只能加源文件，免费的课就是水

从重录的这里开始看；
[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=420.5&p=7)
```cmake
#CMakeLists.txt test_xlog xlog 102
cmake_minimum_required(VERSION 3.20)
project(xlog)
#指定动态库xlog，此动态库由xlog/xlog.cpp编译链接生成。
add_library(xlog SHARED xlog/xlog.cpp)
#在xlog路径下找头文件
include_directories("xlog")

#指定库查找路径 test_xlog可执行文件要用的库叫libxlog.a，在以下路径
link_directories("../xlog/build1")
#生成可执行文件test_xlog，使用test_xlog/test_xlog.cpp来编译链接生成，
add_executable(test_xlog test_xlog/test_xlog.cpp)
#test_xlog是一个可执行程序对象，给它链接一个xlog属性，这个属性就是动态库xlog.so
target_link_libraries(test_xlog xlog)
```

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=718.1&p=7)
`target_link_libraries(test_xlog xlog)`，test_xlog是一个可执行程序对象，给它链接一个xlog属性，这个属性就是动态库xlog.so，windows下叫xlog.dll。

构建编译：
```shell
sudo cmake -S . -B build1
sudo cmake --build build1
```
输出：
![](cmake.assets/image-20230921100507957.png)
生成的动态库libxlog.so和执行文件test_xlog都在build1目录下。

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=759.8&p=7)
查看test_xlog的依赖库：
`ldd test_xlog`
输出：
![](cmake.assets/image-20230921100827055.png)
可以看到它依赖的libxlog.so的绝对路径。
/usr/src/102cmake_lib/build1/libxlog.so

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=805.3&p=7)
这个路径前缀/usr/src/102cmake_lib/build1/是cmake默认给你加的，如果是用gcc来编译是不会给你增加路径的。
用gcc编译器时，自己添加库路径则用代码：
`-Wl, -rpath,/opt/mker/poco/lib`
-Wl这里的l是lmn的l，不是大写的i。
用clang也是一样的写法，因为clang与gcc比较相近。

#### 3.8 [P8 18cmake动态库windows和mac测试](https://www.bilibili.com/video/BV1TU4y1z7UH?p=8)
![](cmake.assets/image-20230921103819466.png)

##### 3.8.1 window下无法编译 没有xlog.lib

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=58.2&p=8)
构建编译：
```shell
cmake -S . -B build1
cmake --build build1
```
编译报错：
```shell
LINK : fatal error LNK1104: 无法打开文件“Debug\xlog.lib” [G:\Projects\projects_cpp\10
2cmake_lib\build1\test_xlog.vcxproj]
```
去往此路径，发现已经生成xlog.dll，但是没有xlog.lib文件：
![](cmake.assets/image-20230921102421930.png)

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=101.2&p=8)
在windows下，我们的test_xlog要引入xlog的库，需要在调用外部库的函数或者类前面加import，而库本身要加export，它的作用就是生成.lib文件。

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=145.1&p=8)
先把头文件作为库导出：
```cpp
//xlog.h
#ifndef XLOG_H
#define XLOG_H
//新增的declspec(dllexport)是导出XLog类的函数到lib文件中
class __declspec(dllexport) XLog
{
	public:
		XLog();
};
#endif
```
需要将xlog.h重新保存为utf-8 with BOM，这样它就不会在编译的时候报错。 utf-8 with BOM就是给文件头加一个标志与utf-8编码不一样，无论什么平台的操作系统加载文件，都以utf-8编码加载。

`cmake --build build1`
果然创建了xlog.lib库与对象：
![](cmake.assets/image-20230921112146572.png)
但是test_xlog.lib也被创建了：
![](cmake.assets/image-20230921110638050.png)

去运行test_xlog，执行成功：
```shell
G:\Projects\projects_cpp\102cmake_lib>cd G:\Projects\projects_cpp\102cmake_lib\build1\Debug

G:\Projects\projects_cpp\102cmake_lib\build1\Debug>test_xlog.exe
Create XLog
test xlog
```

##### 3.8.2 多创建了test_xlog.lib
[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=358.2&p=8)
test_xlog.lib也被创建了，但是它不需要被导出，所以创建test_xlog.lib是多余的操作。test_xlog只需要的是导入xlog.lib库。

为了去区分谁调用，谁导出，可以在头文件的类前面增加`__dllexport`、`__dllimport`
```cpp
//xlog.h
//xlog库文件调用__dllexport
//test_xlog调用__dllimport
#ifndef XLOG_H
#define XLOG_H
class __declspec(__dllexport) XLog
{
    public:
        XLog();
};
#endif
```

或者更周全的方法增加一个宏，即预处理变量。xlog有，而test_xlog没有。
有则用__dllexport，没有则用__dllimport。
cmake有这样的机制来进行这样的操作。

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=482.1&p=8)
通过在CMakeLists.txt中添加预处理变量xlog_EXPORTS来判断头文件是否是库。官方文档中没有给出xlog_EXPORTS这个变量的使用范例 ，但是它是能用的。
```cmake
#CMakeLists.txt test_xlog xlog 102
cmake_minimum_required(VERSION 3.20)
project(xlog)
#指定动态库xlog，此动态库由xlog/xlog.cpp编译链接生成。
add_library(xlog SHARED xlog/xlog.cpp)
#在xlog路径下找头文件
include_directories("xlog")

#添加xlog库编译项目自带预处理变量xlog_EXPORTS

#指定静态库查找路径 test_xlog可执行文件要用的库叫libxlog.a，在以下路径，windows不需要这一行也能成功编译运行项目
# link_directories("../xlog/build1")

#生成可执行文件test_xlog，使用test_xlog/test_xlog.cpp来编译链接生成，
add_executable(test_xlog test_xlog/test_xlog.cpp)
#test_xlog是一个可执行程序对象，给它链接一个xlog属性，这个属性就是动态库xlog.so
target_link_libraries(test_xlog xlog)
```

给xlog.h增加一个宏定义，通过cmake里的xlog_EXPORTS参数判断当前头文件是否是库项目：
```cpp
//xlog.h
#ifndef XLOG_H
#define XLOG_H
//新增的__declspec(dllexport)是导出XLog类的函数到lib文件中
//xlog库文件调用dllexport
//test_xlog调用dllimport
#ifdef xlog_EXPORTS
    #define XCPP_API __declspec(dllexport)//库项目调用
#else
    #define XCPP_API __declspec(dllimport)//调用库项目调用
#endif
class XCPP_API XLog
{
    public:
        XLog();
};
#endif
```

编译：
```shell
cmake -S . -B build1 && cmake --build build1
```
test_xlog成功执行，并且`build1\Debug`目录下没有生成test_xlog.lib，只生成了xlog.lib。
##### 3.8.3 linux当中使用宏定义XCPP_API报错
[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=688.1&p=8)
在linux当中试试cmake对windows设置的xlog_EXPORTS宏定义能不能用？
![](cmake.assets/image-20230921120953434.png)
不能，因为linux、macOS不认识这个语法。需要对操作系统进行区分。

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=761.6&p=8)
xlog.h头文件中增加宏定义来判断系统：`#ifndef _WIN32`
64位还是32位windows操作系统都用`_WIN32`。
非windows的情况下，将`XCPP_API`置为空，这样代码在什么系统下都能运行。
头文件改为：
```cpp
//xlog.h
#ifndef XLOG_H
#define XLOG_H
//新增的__declspec(dllexport)是导出XLog类的函数到lib文件中
//xlog库文件调用dllexport
//test_xlog调用dllimport
#ifndef _WIN32
    #define XCPP_API
#else
    #ifdef xlog_EXPORTS
        #define XCPP_API __declspec(dllexport)//库项目调用
    #else
        #define XCPP_API __declspec(dllimport)//调用库项目调用
    #endif
#endif
class XCPP_API XLog
{
    public:
        XLog();
};
#endif
```

```shell
sudo cmake -S . -B build1 && sudo cmake --build build1
```
成功。

[视频时间戳：](https://www.bilibili.com/video/BV1TU4y1z7UH?t=834.0&p=8)
macOS中测试。


## [CMake菜谱（CMake Cookbook中文版）](https://www.bookstack.cn/read/CMake-Cookbook/content-chapter1-1.1-chinese.md)

[第1章 从可执行文件到库 - 1.3 构建和链接静态库和动态库 - 《CMake菜谱（CMake Cookbook中文版）》 - 书栈网 · BookStack](https://www.bookstack.cn/read/CMake-Cookbook/content-chapter1-1.3-chinese.md)

## 一些博客
### 1 [使用cmake时 什么时候删掉整个build，什么时候只需要make clean](https://blog.csdn.net/qq_44886213/article/details/121771200)

#### 1.1 一、删掉整个build
所以结论就是，**当我们更改了CMakeList.txt后再编译，就需要删掉整个build文件夹**，然后重新编译。走下面的流程

```shell
rm -rf build
mkdir build
cd build
cmake ..
make
```

#### 1.2 二、只需要make clean
先说结论，当源文件发生改变时，只需要make clean重新编译就行了。比如在源文件中，添加了一行
`cout<<"hello!"<<endl;`

然后我们再去编译的时候只需要在build目录下，输入
`make clean`
因为，如果makefile的内容不会改变时，就不需要经过cmake..这一步重新生成makefile文件了。显然加入一行输出语句对于makefile的内容不会有任何影响。

**ps: 记录一下make clean的功能**
make命令可以让新生成的去覆盖旧的，但是有一些上次生成了这次不需要生成他的文件，就没法删除了。

（比如上次使用make生成了文件a，文件b，文件c，这次使用make命令只需要生成文件a和文件b，并且文件a有所变化。那么这次生成的文件a会覆盖上次的文件a；上次生成的文件b保持不动，这次不需要再费劲生成一遍了；而上次生成的文件c也保持不动，尽管这次不需要文件c）

所以才需要make clean一下，删除所有被make创建的文件。

**ps:什么是build**
Buildl可以认为是软件开发中不同时期编译出来的版本，其实就是开发人员把源程序打包出来的一个安装文件，很可能每天都会有新的版本出现。
生成build就是指将源代码进行打包，做成一个安装文件的形式。
测试build中的bug就是指在特定的版本下测试软件的bug。有可能在之前的build出现了问题，程序员改了下代码，让测试人员看看有没有把bug修复；或者是程序员增加了个新的功能，让测试人员看看这个build有没有bug。

### 2 [CMakeLists常用指令](https://blog.csdn.net/weixin_40620310/article/details/119971000)

```cmake
# 以下为必须指令
cmake_minimum_required(VERSION 2.8)		# 最小cmake版本
project(demo)						  # 项目名称
set(CMAKE_CXX_STANDARD 11)				# C++的版本
add_executable(demo main.cpp util.cpp)	# 生成可执行文件
include_directories(					# 包含头文件的地址
	${CMAKE_CURRENT_SOURCE_DIR}/include
)
link_directories(						# 链接库的搜索路径
	${CMAKE_CURRENT_SOURCE_DIR}/lib64
)
target_link_libraries(demo student)		# 链接库（so文件）

# 以下为可选指令
add_library(test STATIC test.cpp)		# 生成静态库
add_library(test SHARED test.cpp)		# 生成动态库
add_subdirectory(tools)					# 编译子文件夹
message(WARNING "this is warning message")	# 打印信息
add_definitions("DEBUG_XX")				# 设置宏定义
set(SRC_LIST main.cpp test.cpp)			# 设置变量

```
## 其他视频教程资料
### 1 [小刘老赖 cmake合集](https://space.bilibili.com/509929183/channel/collectiondetail?sid=1062278)
HaoweiHsu
這邊推薦想學 CMake 的夥伴們，可以去觀看 B 站一位叫【@小刘老赖 】的 UP 主製作的 CMake 視頻。每一期的 CMake 視頻都挺短的，但都會給本次介紹的語法一個又一個的小範例。我覺得這正是官方 CMake Documentation 最欠缺的部份。畢竟這位 UP 主製作的 CMake 視頻播放量目前挺慘淡的，如果能增加觀看人數的話，對他來說會比較有動力繼續更新下去。
2023-01-03 20:27👍2

### 2 [只喝白开水 从零开始学cmake](https://space.bilibili.com/2411870/channel/collectiondetail?sid=843628)
