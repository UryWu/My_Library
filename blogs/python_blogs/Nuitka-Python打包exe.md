### [pyinstaller,nuitka,嵌入式打包性能比较](https://zhuanlan.zhihu.com/p/691575264)

编辑于 2024-04-09 21:22・江西

以其输出的machine benchmarks作为性能衡量标准。**该值越大，说明性能越好。**



将第一组测试结果绘图如下：

![img](./Nuitka-Python%E6%89%93%E5%8C%85exe.assets/v2-484dd9769c79a2e194f3e7a5d010664f_1440w.jpg)

nuitka+standalone性能最好，嵌入式+py次之。



将第二组测试结果绘图如下：

![img](./Nuitka-Python%E6%89%93%E5%8C%85exe.assets/v2-b52f6e8cd43c0430af02eae9832af53f_1440w.jpg)

嵌入式+pyd_max性能最好，其他方法性能相似。



#### 结论

可以直观的看出：

1，将py文件转为pyd文件可以显著提升性能。

2，py文件不单独转为pyd的话，使用nuitka打包程序，性能提升明显。

3，将py文件转为pyd之后，使用嵌入式+pyd的打包模式，性能遥遥领先于其他的打包办法。

### [Python打包exe(32/64位)-Nuitka再下一城](https://zhuanlan.zhihu.com/p/141810934)

编辑于 2022-06-13 09:18

有幸你看过前面两篇文章，这篇文章相当于是精简版，小巧快速。放上地址温故知新也好



如果这篇文章你熟练了，基本95%的打包状况你就能解决了,打包单个exe文件也解决了。



### [python嵌入式打包，打包新姿势，打包速度比pyinstaller还快哦](https://zhuanlan.zhihu.com/p/691339803)

发布于 2024-04-08 20:04・四川

要是说细一点，pyinstaller跟nuitka都是适合那些第三方依赖不复杂的项目，搞起来快，自动打包也简单；而依赖复杂的项目嵌入式打包就是大杀器了，不管你多复杂，我直接copy环境。

![img](./Nuitka-Python%E6%89%93%E5%8C%85exe.assets/v2-24cf1a936f6c11007bdb163e210c3ddc_1440w.jpg)

#### 本打包方式，对于依赖极少的项目对比pyinstaller或者nuitka没有优势

快给大忙人让泳道 作者
本打包方式，对于依赖极少的项目对比pyinstaller或者nuitka没有优势。对于依赖复杂，或者依赖多，或者第三方库需要命令行启动比如streamlit，mitmproxy这些要求命令行，要求py文件的，打包起来非常简单且快

2024-08-22 · 四川

#### python本身不适合打包

test9
python本身不适合打包，因为但凡好用的第三方包都是50m起步，多几个就爆炸了，纯python + pyqt也没什么用就是了。
2024-10-21 · 广东



快给大忙人让泳道 作者
这是个悖论，好用的前提就是人家帮你实现，但是人家哪儿知道你是啥需求，于是就会写一大堆功能，你却只用一两个，然后把这堆功能都打包了。所以体积臃肿。不过无所谓，现在硬盘过于便宜，连微信qq王者荣耀这种移动端应用都可以干到几十个g，python这点体积能算个啥呢。能解决需求的工具就是好工具。

2024-10-21 · 四川

#### 最新版torch库，它把二进制依赖dll文件扔到sitepackage外面无法打包

知乎用户S7rUl3
（这步操作一般没啥问题，但是有些第三方库不讲武德，比如最新版torch库，它把二进制依赖dll文件扔到sitepackage外面，只复制sitepackage里面的内容，会报错dll load failed，这种时候有其他的处理办法）什么解决办法……

2024-09-27 · 甘肃





### [Nuitka之乾坤大挪移-让天下的Python都可以打包](https://zhuanlan.zhihu.com/p/137785388)



#### 显示调试窗口

**不包含--windows-disable-console，就可以在CMD窗口显示错误，方便调试缺少的模块**)：



#### 不要编译pip包

**Numpy等类似c程式和pyd的调用还是忽略编译好**，不要一咕噜全梭哈啦，编译后反而更慢。重点事项是要小本本记上，别说本豪猪没有提醒呀。

别跑了，进入正题了，以下是一份常见PyQT5的import和文件夹内容,常规下都会打包到文件夹中去，绿色部分比如PyQT5，numpy，PIL，cv2，Tensorflow,Sklearn这些要是转换成C/C++意义不大，并且打包时间会延长到几个小时，风扇狂响，笔记本小概率上会撑不到新exe的到来(So we have to change)

```text
--nofollow-imports  # 所有的import不编译，交给python3x.dll执行，这个是系统import的类似numpy、pyqt、Tensorflow等模块
--follow-import-to=need  # need为你需要编译成C/C++的py文件夹命名，这个是你自己写的代码。
```



#### 编译命令

编译tensorflow-yolov3的泥块目标检测项目

```shell
nuitka --mingw64 --standalone --show-progress --show-memory --plugin-enable=qt-plugins --include-qt-plugins=sensible,styles --windows-disable-console --nofollow-imports --follow-import-to=core --windows-icon-from-ico=./icons/mine.ico --output-dir=nuitka_out Main_Window.py
```

bug:这样打包的结果就是虽然生成了exe文件，但是无法运行。我只看到一个pyqt的文件夹+很多的dll文件，什么numpy、tensorflow都没看到。

### pyinstall的编译命令

矿石泥团CPU版，无调试窗口-w

```shell
pyinstaller --hidden-import=pkg_resources -w -i icons\mine.ico Main_Window.py --noconfirm
```



矿石泥团GPU版，留一个控制台窗口好debug

```shell
pyinstaller --hidden-import=pkg_resources -i icons\mine.ico Main_Window.py --noconfirm
```



```shell
pyinstaller -F app.py

# 这个打包总是无法把图标打包进去
pyinstaller -F -i ./temperature_calculator.ico --noconsole mainwindow.py

# 这个打包可以打包图标
pyinstaller --hidden-import=pkg_resources -w -i temperature_calculator.ico mainwindow.py
```

