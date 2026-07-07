# 1 C/C++ 

## 1.1 c/c++环境配置

运行代码前一定要按Ctrl + S保存，再右键选择Run Code或者用快捷键Ctrl + Alt + N执行代码。
快捷键那里我已经设置了Alt+M保存并运行代码了。

1.[入坑VSCode -- 详细配置：运行C++/C代码 在终端运行 文件读入 配置刷题模板](https://blog.csdn.net/vaeloverforever/article/details/90695408)

这一篇设置了终端中运行与代码运行前保存。

或者看这篇：

2.[VSCode配置C/C++环境](https://zhuanlan.zhihu.com/p/87864677)

注意：完全卸载vscode方法

Bug1:TypeError: Cannot read property 'includes' of undefined at

**solution:**

看到上面那个网址的最下面部分，有关task.json的内容，就是直接手动创建这个json然后把博主的task.json粘贴进去，

之后新建一个工程就直接把本次设置好的.vscode\*.json全部复制过去就不用再配置了。

Bug2:VSCode在windows下不能打开标准头文件的问题，cannot open source file "xxx.h"，提示更新路径

[VSCode在windows下不能打开标准头文件的问题，cannot open source file "xxx.h"，提示更新路径_进击的火腿肠-CSDN博客](https://blog.csdn.net/qq_33202928/article/details/85099892)

在我本机的C语言常用的头文件在这个目录：

E:\Dev-Cpp\MinGW64\x86_64-w64-mingw32\include

Bug3:解决VSCode终端中文乱码问题

[解决VSCode终端中文乱码问题_xjk2017的博客-CSDN博客_解决vscode中文乱码的代码](https://blog.csdn.net/xjk2017/article/details/81388493)

![img](https://img-blog.csdnimg.cn/20191001002403326.png)

936表示GBK2312编码

![img](https://img-blog.csdnimg.cn/20191001001811453.png)

在我的VScode下我是这样设置终端输出为utf-8编码的，65001表示utf-8编码。

Bug4:

[VS Code 中的快捷键Ctrl+Space 与微软拼音冲突无法正确触发补全, 使用AutoHotkey 解决](https://www.bilibili.com/read/cv5012438/)



Bug5:vscode编辑器中文乱码问题

[vscode编辑器中文乱码问题 - 桥南小院 - 博客园](https://www.cnblogs.com/wheatCatcher/p/11533955.html)

我是这样设置的：

![img](https://img-blog.csdnimg.cn/20191001001938830.png)

![img](https://img-blog.csdnimg.cn/20191001002025243.png)

![img](https://img-blog.csdnimg.cn/20191001002119215.png)

Bug6:Termial的powershell运行多个命令的连接符

如图cmd可以用&&连接多个命令：

![img](https://img-blog.csdnimg.cn/20210804055853649.png)

 但是powershell不可以：![img](https://img-blog.csdnimg.cn/20210804055929634.png)

 powershell用分号;连接多个命令：

![img](https://img-blog.csdnimg.cn/20210804060101643.png)

[参考：PowerShell一次执行多条命令](https://blog.csdn.net/u011215669/article/details/81086097)

## [1.2 C++调试配置](https://zhuanlan.zhihu.com/p/85273055)

**Bug1：**This command is not available for single-file mode.

**solution：**不要单独打开代码文件，打开代码所在的文件夹才能调试。如果程序需要输入数据，不要傻等着debug调试卡着，输入数据后才能调试。

**Bug2：**在跟着上面调试C++的链接生成tasks.json和launch.json文件后，按F5开始调试报错g++.exe: error: gcc x64: NO such file or directory

**solution：**打开tasks.json文件，把最后的这个gcc x64删掉或注释掉。

![img](https://img-blog.csdnimg.cn/0b13d546ec3f43fbbfcfdc0aee1dc4a6.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAVXJ5V3U=,size_20,color_FFFFFF,t_70,g_se,x_16)

## 1.3 VS Code头文件

[VS Code添加头文件 全局 include path 和 工作区 include path](https://www.cnblogs.com/unrulife/p/14319466.html)

[vscode检测到#include错误，请更新includePath。解决方法](https://blog.csdn.net/weixin_44718794/article/details/106751513)

## [1.4 VS Code自定义用户代码片段（C++）](https://blog.csdn.net/Peerless__/article/details/110386388)

非常值得学习，本地的代码片段在：C:\Users\UryWu\AppData\Roaming\Code\User\snippets

创建代码片段点击File->preferences->User Snippets

参考：

[VScode修改默认快捷键](https://blog.csdn.net/w1019945543/article/details/69257604)

[VsCode自定义快捷键，一次运行两个或多个Command命令](https://www.cnblogs.com/Jun10ng/p/12853975.html)

bug1：[vscode-tab按键失效变为切换控件解决](https://blog.csdn.net/mrbone11/article/details/100037354)

一种情况是按到了vscode的ctrl+M命令，变为vscode的切换设置焦点模式。

# 2 Python

## 2.1 Anaconda+VSCode的python环境配置

参考：[Anaconda+VSCode搭建python环境](https://www.jianshu.com/p/f10fb1a4cc87)

如果你不使用anaconda的默认base环境，想要激活anaconda里的其它环境可以不照这个参考链接里那样去配置"python.pythonPath"键，因为照他那样会报错：

```bash
CommandNotFoundError: Your shell has not been properly configured to use 'conda activate'. 
```

我是按照自己的测试结果来的只配置"code-runner.executorMap"下的"python"键，你首先要先把anaconda环境配好，然后如下。



思想：通过修改settings.json文件的"code-runner.executorMap"->"python"键来使用powershell，然后启动cmd来使用不同的python环境来运行代码。

打开C:\Users\UryWu\AppData\Roaming\Code\User\settings.json

UryWu改为你的计算机账户名。

在"code-runner.executorMap"下的"python"的键值改为如下，注意anaconda的python.exe路径要更改为你自己的，也不要全选复制粘贴，修改"python"键就行：

```json
{
    "php.validate.executablePath": "",
    // "python.pythonPath" :"E:\\Anaconda3-2019.10-Windows-x86_64\\envs\\tensorflow-gpu\\python.exe", 
    /*使用上面这一行会报错：
    CommandNotFoundError: Your shell has not been properly configured to use 'conda activate'. 
    If using 'conda activate' from a batch script, change your invocation to 'CALL conda.bat activate'.
    1."python.pythonPath"行配置的作用是在终端运行python代码时进入你配置的anaconda环境；
    2.因为我默认使用的是powershell终端，所以无法activate <CONDA_ENV>激活anaconda环境，需要更改默认终端为cmd
    才能activate <CONDA_ENV>。我怕因python而把VScode默认终端修改为cmd后，而影响运行其它代码，所以还是不修改默认终端。
    所以只能在下面的"python"键下功夫了。
    */
        "code-runner.executorMap":{//这里是运行不同代码时，终端的执行语句。当你修改默认终端（powershell或cmd）时，这些命令可能因报错而需要修改。
        "javascript": "node",
        "java": "cd $dir && javac $fileName && java $fileNameWithoutExt",
        "c": "cd $dir && gcc $fileName -o $fileNameWithoutExt && $dir$fileNameWithoutExt",
        "cpp": "cd $dir && g++ $fileName -o $fileNameWithoutExt && $dir$fileNameWithoutExt",
        "objective-c": "cd $dir && gcc -framework Cocoa $fileName -o $fileNameWithoutExt && $dir$fileNameWithoutExt",
        "php": "php",//直接写语言名称就是没有设置此类语言的编译运行配置。
        "python": "cmd /k E:\\Anaconda3-2019.10-Windows-x86_64\\envs\\tensorflow-gpu\\python.exe $file",
        /*解释上面的配置：'cmd /k'表示以cmd运行某个命令，然后是你欲使用的conda环境里面的python.exe，$file是代码文件的绝对路径。
        archive:
            "python": "cmd /k activate tensorflow-gpu '&' cd $dir '&' python $fileName",
        解释上面的配置：
        'cmd /k'表示以cmd运行某个命令，'activate tensorflow-gpu'就是进入这个环境，&是cmd的多命令分隔符。
        这里的'&'之后是在cmd里运行的第二个命令：使用python运行代码$fileName，'&'改为&会导致powershell语法报错，
        保留&的单引号才能用在符合powershell语法检查的情况下在进入cmd后执行多个cmd命令。你可用pwd命令做测试，只能powershell执行而cmd不能。
        '&' cd $dir 是用cmd进入代码所在目录，代码不在C盘时会报错No such file or directory，因为cmd还需要
        打一个盘符来从默认的C盘转到其它盘，而powershell可以直接cd跳转。所以此配置失败了。
        如果可以获得VScode里盘符的${}变量则可使用此配置。
        python $fileName是使用python执行代码，$fileName是代码文件名。
        
            "python": "cd $dir && E:\\Anaconda3-2019.10-Windows-x86_64\\envs\\tensorflow-gpu\\python.exe $fileName",
        解释上面的python运行环境配置：'cd $dir'是进入代码所在目录，'&&'或者';'是powershell的多命令分隔符，可能新版不可用&&。
        虽然此配置可以运行代码，但是VScode终端总是自动去activate <CONDA_ENV>激活anaconda环境，而我的默认终端保持powershell，
        所以会报错：CommandNotFoundError: Your shell has not been properly configured to use 'conda activate'. 
        If using 'conda activate' from a batch script, change your invocation to 'CALL conda.bat activate'.
        */
        "perl": "perl",
}
```

**Bug1:** 关于VS code中 import后却显示no module的问题解决（明明安装了却无法导入，终端可以运行，输出端不行）

**sulotion:**

[关于VS code中 import后却显示no module的问题解决（明明安装了却无法导入，终端可以运行，输出端不行） - it610.com](https://www.it610.com/article/1281185847399432192.htm)

**Bug2:** Linter pylint is not installed.

**sulotion:**

[vscode 一直提示 Linter pylint is not installed，Python没有波浪线提示解决办法](https://blog.csdn.net/xhbphp/article/details/102753159)

**Bug3:**[windows] CommandNotFoundError: Your shell has not been properly configured to use ‘conda activate‘

[**sulotion:**](https://blog.csdn.net/zqwwwm/article/details/121694158)

在vscode中输入conda activate xx时，仍然遇到这个问题，抓狂。在网上搜了用power shell 去conda init均不行，后来发现vscode的terminal的后端就是powershell,将他改成cmd 后，一切都好了。。

参考：[vscode切换默认终端为cmd](https://blog.csdn.net/qq_37279880/article/details/106110555)



## 2.2 [python代码自动补全利器Kite](https://www.52pojie.cn/thread-1303409-1-3.html)

## 2.3 [在 VSCode 中設定 Python 解析器](https://ithelp.ithome.com.tw/articles/10369740)

### 运行代码

1 按下 Ctrl + Shift + P 開啟命令面板，選擇 Python: Select Interpreter。
2 选择Enter Interpreter Path

3 Find...，然后输入虚拟环境的python.exe的路径，我的：C:\Users\计算机用户名\AppData\Local\pypoetry\Cache\virtualenvs\01-langchain--rYtsePH-py3.11\Scripts\python.exe

对于我：执行代码的时候，不要按快捷键右alt+m或者右alt+v，这个快捷键宏已经定义为使用tensorflow-gpu的python环境，用快捷键ctrl+F5就可以了，或Run->Run  without Debugging

### debug

按F5，Run->Start Debugging



# 3 快捷键修改

## 3.1 快捷键修改及本地保存地址

慢速点击alt+f+p后点击Keyboard shotcuts可以修改快捷键，或者先点ctrl+m，ctrl+k，ctrl+s

键位修改后，修改的设置保存在这个文件里面：

C:\Users\UryWu\AppData\Roaming\Code\User\keybindings.json

此文件：C:\Users\UryWu\AppData\Roaming\Code\User\keybindings.json

## 3.2 macros多个命令执行快捷键

下面是我自定义的一个保存文件并运行代码后跳到终端命令行的快捷键：alt+m ，需要下载插件macros。

```cpp
// Place your key bindings in this file to override the defaultsauto[]
[
    {
        "key": "alt+m",
        "command": "macros.save_and_run" 
        /*直接系统可以设置运行代码前保存，但之前不知道，用了macros的组合命令。用这个macros也有好处，
        我又增加了跳转到终端窗口和终端窗口滚动到底部的指令,另外系统的运行代码不能使用alt+n或alt+b快捷键。
        */
    },
    {
        "key": "ctrl+alt+n",
        "command": "-code-runner.run" //code-runner.run前面加个减号代表禁用此快捷键，此快捷键是vscode内置的。
    },
    {
        "key": "alt+v",
        "command": "code-runner.run"  //直接运行代码，我已经在系统里设置自动保存代码了。不用macros也可。
    }

]
```

然后C:\Users\UryWu\AppData\Roaming\Code\User\settings.json里面是我自定义的save_and_run的组合命令，保存后运行。

```bash
"macros": {
    	// 自定义指令名称
        "save_and_run": [
            //第一个指令，保存。
            "workbench.action.files.save",
            //第二个指令，在终端运行代码。
            "code-runner.run",
            //第三个指令，跳转终端窗口。
            "workbench.action.terminal.toggleTerminal",
            //第四个指令，终端窗口滚动到底部。
            "workbench.action.terminal.scrollToBottom"
        ]
    },
```

## 3.3 软件中不同面板的切换

**按 `Ctrl+~` 打开集成终端（其实是"`"，打"~"是方便大家找到），输入**

![img](https://img-blog.csdnimg.cn/img_convert/b85153e0791a5269426b273af6e1fc2e.png)

**按 `Ctrl+1进入编辑器空间`**

**按 `Ctrl+Shift+U进入output空间，（鼠标长时停留于菜单栏有提示）`**

![img](https://img-blog.csdnimg.cn/20210730002205130.png)



### [Win10使用快捷键新建文件夹和.txt文本文档，提升工作效率，让你成为最靓的仔](https://blog.csdn.net/weixin_43330884/article/details/103734985)





## everything

修改过滤筛选是所有、文件夹、视频还是音频。

菜单栏->搜索(S)->管理筛选器(O)

