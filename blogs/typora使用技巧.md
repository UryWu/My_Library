## [1. typora字体设置颜色的解决方案](https://blog.csdn.net/superit401/article/details/106344453)

### 方案一：autohotkey

```shell
; Typora
; 快捷增加字体颜色
; SendInput {Text} 解决中文输入法问题
 
#IfWinActive ahk_exe Typora.exe
{
    ; Ctrl+Alt+O 橙色
    ^!o::addFontColor("orange")
 
    ; Ctrl+Alt+R 红色
    ^!r::addFontColor("red")
 
    ; Ctrl+Alt+B 浅蓝色
    ^!b::addFontColor("cornflowerblue")
}
 
; 快捷增加字体颜色
addFontColor(color){
    clipboard := "" ; 清空剪切板
    Send {ctrl down}c{ctrl up} ; 复制
    SendInput {TEXT}<font color='%color%'>
    SendInput {ctrl down}v{ctrl up} ; 粘贴
    If(clipboard = ""){
        SendInput {TEXT}</font> ; Typora 在这不会自动补充
    }else{
        SendInput {TEXT}</ ; Typora中自动补全标签
    }
}
```

（3）将文件保存为ahk后缀的文件，如TyporaHotKey.ahk

(4)双击运行

（5）在Typora软件里就可以使用快捷键：

如按Ctrl+Alt+O添加橙色，Ctrl+Alt+R 红色，按Ctrl+\取消样式！

 

也可以右键 MyHotkeyScript.ahk 脚本文件，点击Compile Script编译脚本成exe程序，就可以不用下载Autohotkey在其他电脑上运行了。

### 方案二：改html代码（懂前端技术超简单）

视图——开发者工具（Shift+F12），打开html代码调试模式

 按快捷键Shift+F12（可能还需要同时按住Fn）

```html
<span style="color:文字颜色;background:背景颜色;font-size:文字大小;font-family:字体;">你要改色的文字</span>
```

按照这个模板，改字体的style属性即可。

示例：

style="color:red"

style="color:maroon"

style="color:fuchsia"

style="color:brown"

style="color:blue"

style="color:aqua"

style="color:green"

style="color:orange"

style="color:purple"

style="color:white;background:black;"

style="background:yellow"

style="background:red"

style="background:orange"

style="color:white;background:green"

style="color:white;background:blue"

![img](.\typora使用技巧.assets\20200525225939274.png)

## [2. Typora 软件使用 MarkDown 编写文章的一些常用的快捷键总结](https://www.52pojie.cn/thread-1278320-1-35.html)



## [3.使用Typora添加数学公式](https://blog.csdn.net/mingzhuo_126/article/details/82722455)