@[TOC](目录)

### 一、搭建环境： 

#### [PyQT5速成教程系列1-3](https://blog.csdn.net/sqy941013/article/details/80548593)

这个教程的第二章配置QtDesigner那里讲得不清楚，可以看这个[网址](https://blog.csdn.net/qq_42823043/article/details/88817034)：

[PyQT5速成教程-2 Qt Designer介绍与入门-CSDN博客](https://blog.csdn.net/sqy941013/article/details/80572606)

#### Bug1（未解决）：
```bash
spyder 3.3.4 requires pyqtwebengine<5.13, which is not installed.
```


### 二、系统的教程

[PythonBasics中文系列教程](https://www.kancloud.cn/apachecn/pythonbasics-zh/1946542)

### 三、零散的教程

#### [0.python写一个时尚的音乐播放器界面](https://zmister.com/archives/477.html)

#### [1.Python GUI教程（八）：在主窗口中调用对话框](https://zmister.com/archives/165.html)

#### [2.PyQt5 技巧篇-按钮隐藏并保留位置，设置按钮的可见度，设置按钮透明度](https://blog.csdn.net/qq_38161040/article/details/86605798)

#### [3.PyQt5图形和特效之设置窗口背景（六）](https://blog.csdn.net/jia666666/article/details/81874045)

#### [4.如何使窗口始终显示在最前面](https://blog.csdn.net/qq_38161040/article/details/87365818)

**代码：**

```python
Dialog.setWindowFlags(QtCore.Qt.WindowStaysOnTopHint)
```

#### [5.PyQt5 QLabel改变字体和设置背景图片](https://blog.csdn.net/brook_/article/details/80141808)

#### [6.pyqt5 给按钮设置css样式和界面背景设置](https://blog.csdn.net/pursuit_zhangyu/article/details/82917276)

#### [7.pyqt5 给按钮设置界面背景](https://blog.csdn.net/Szh19960807/article/details/80149248)

**代码：**
```python
self.pushButton.setStyleSheet('QPushButton{background-image:url(22.png)}')
```

#### [8.PyQT5-QPushButton切换按钮，按下与未按下两种状态切换](https://www.cnblogs.com/demo-deng/p/9990090.html)

#### 9.PYQT5当鼠标放在按钮上时变换颜色：

```
self.left_mini.setStyleSheet("QPushButton{background:#6DDF6D;border-radius:5px;}QPushButton:hover{background:green;}")
```

 在这里，按钮默认为淡绿色，鼠标悬浮时为深绿色，hover就是悬浮的情况。

#### 10.PYQT5当设置按钮背景透明：

self.pushButton.setStyleSheet("QPushButton{background:transparent;}")

#### [11.PyQt5 设置状态栏图标和动态显示gif图](https://blog.csdn.net/Yuyh131/article/details/85164461)

#### [12.PYQT5设置字体居中（直接博客中搜索居中）](https://blog.csdn.net/jiuzuidongpo/article/details/45485127)

设置labe的字体居中：

```python
self.label.setAlignment(Qt.AlignCenter)
```

此居中为上下左右居中

#### [13.pyqt5设置按钮，移上去变为手型](https://blog.csdn.net/pursuit_zhangyu/article/details/83211436)

一行代码：self.button.setCursor(QCursor(Qt.PointingHandCursor))

#### 14.主界面中打开Dialog参考程序：

```python
class MainWindow(QMainWindow, Ui_MainWindow):
    def __init__(self):
        super(MainWindow, self).__init__()
        self.setupUi(self)
        # 上面这两行代码就是调用Ui_MainWindow()类的界面，好好看着

        self.pushButton1.clicked.connect(self.pressed_pushButton1)

    def pressed_pushButton1(self):
        # app = QtWidgets.QApplication(sys.argv)
        Dialog = QtWidgets.QDialog()
        ui = Ui2()  # 这个Ui2是我另外的一个子窗口py文件中的类
        ui.setupUi(Dialog)
        Dialog.show()
        Dialog.exec_()
        # sys.exit(app.exec_())
```

####  15.使一个名为Ui2的QDialog类被另一个类来继承来实现窗口：

```python
class Ui2_window(QtWidgets.QDialog, Ui2):
    def __init__(self):
        super(Ui2_window, self).__init__()  # 此处参考：https://blog.csdn.net/EXECUTER_/article/details/78877159
        self.setupUi(self)


if __name__ == '__main__':
    app = QtWidgets.QApplication(sys.argv)
    # Dialog = QtWidgets.QDialog()
    Dialog = Ui2_window()
    # Dialog.setupUi(Dialog)
    Dialog.show()
    sys.exit(app.exec_())
```

#### 16.QDialog设置最大小化及关闭按钮

Dialog.setWindowFlags(Qt.WindowCloseButtonHint | Qt.WindowMinMaxButtonsHint) # 设置最大小化及关闭按钮

#### 17.多幅图片网格显示：

[PyQt5-高级控件使用（QTableView）](https://www.cnblogs.com/ygzhaof/p/10076308.html)

[[Pyqt5.5 for Python3.4.3 学习笔记]-->QTableView表格视图控件的使用方法](https://www.zhaokeli.com/article/7986.html)

QTableView如何设置单元格大小同图片大小改变

#### [18.窗口之间传值，就是给类的构造器添加一个输入的参数，然后self.para = 这个参数](https://bbs.csdn.net/topics/391821557)

#### [19.【PyQt5-Qt Designer】浅谈关闭窗口](https://www.cnblogs.com/XJT2018/p/10175881.html)

1、关闭全部窗口（主窗口+所有的子窗口）

在逻辑界面中写入

```html
sys.exit(0)
```

2、关闭子窗口（其他窗口不关闭）

```html
self.close()
```

#### [20.PyQt5基本控件详解之QLabel（三）](https://blog.csdn.net/jia666666/article/details/81504595)

[pyqt5中Label文字可复制](https://blog.csdn.net/whuzhang16/article/details/109125971)

```python
from PyQt5.QtCore import Qt
 
self.label.setTextInteractionFlags(Qt.TextSelectableByMouse)
```

#### 21.[Python3使用PyQt5制作简单的画板/手写板](https://www.cnblogs.com/PyLearn/p/7689170.html)

讲解清晰明白、通俗易懂

##### drawUI5.0画图时保存到本地

```python
'''
    简单的画板4.0
    功能：
        将按住鼠标后移动的轨迹保留在窗体上
        并解决二次作画时与上次痕迹连续的问题
    作者：PyLearn
    博客: http://www.cnblogs.com/PyLearn/
    最后修改日期: 2017/10/18
'''
import sys
from try_model_1pic import load_model_labels, load_image, show_results
import pylab
from PyQt5.QtWidgets import (QApplication, QWidget)
from PyQt5.QtGui import (QPainter, QPen, QPixmap)
from PyQt5.QtCore import Qt

WINDOWS_WIDTH = 400
WINDOWS_HEIGHT = 300

class Example(QWidget):

    def __init__(self):
        super(Example, self).__init__()

        #resize设置宽高，move设置位置
        self.resize(WINDOWS_WIDTH, WINDOWS_HEIGHT)
        self.move(100, 100)
        self.setWindowTitle("简单的画板4.0")

        # 创建一个QPixmap来保存画的图片
        self.map = QPixmap(WINDOWS_WIDTH, WINDOWS_HEIGHT)
        self.map.fill(Qt.white)  # 设置背景为白色

        #setMouseTracking设置为False，否则不按下鼠标时也会跟踪鼠标事件
        self.setMouseTracking(False)

        '''
            要想将按住鼠标后移动的轨迹保留在窗体上
            需要一个列表来保存所有移动过的点
        '''
        self.pos_xy = []

    def paintEvent(self, event):
        painter = QPainter()
        painter2 = QPainter()

        painter.begin(self)  # painter用来画画时在屏幕展出
        painter2.begin(self.map)  # painter2用来保存画图结果到本地

        pen = QPen(Qt.black, 2, Qt.SolidLine)
        painter.setPen(pen)
        painter2.setPen(pen)


        '''
            首先判断pos_xy列表中是不是至少有两个点了
            然后将pos_xy中第一个点赋值给point_start
            利用中间变量pos_tmp遍历整个pos_xy列表
                point_end = pos_tmp

                判断point_end是否是断点，如果是
                    point_start赋值为断点
                    continue
                判断point_start是否是断点，如果是
                    point_start赋值为point_end
                    continue

                画point_start到point_end之间的线
                point_start = point_end
            这样，不断地将相邻两个点之间画线，就能留下鼠标移动轨迹了
        '''
        if len(self.pos_xy) > 1:
            point_start = self.pos_xy[0]
            for pos_tmp in self.pos_xy:
                point_end = pos_tmp

                if point_end == (-1, -1):
                    point_start = (-1, -1)
                    continue
                if point_start == (-1, -1):
                    point_start = point_end
                    continue

                painter.drawLine(point_start[0], point_start[1], point_end[0], point_end[1])
                painter2.drawLine(point_start[0], point_start[1], point_end[0], point_end[1])

                point_start = point_end

        painter.end()
        painter2.end()


    def mouseMoveEvent(self, event):
        '''
            按住鼠标移动事件：将当前点添加到pos_xy列表中
            调用update()函数在这里相当于调用paintEvent()函数
            每次update()时，之前调用的paintEvent()留下的痕迹都会清空
        '''
        #中间变量pos_tmp提取当前点
        pos_tmp = (event.pos().x(), event.pos().y())
        #pos_tmp添加到self.pos_xy中
        self.pos_xy.append(pos_tmp)

        self.update()

    def mouseReleaseEvent(self, event):
        '''
            重写鼠标按住后松开的事件
            在每次松开后向pos_xy列表中添加一个断点(-1, -1)
            然后在绘画时判断一下是不是断点就行了
            是断点的话就跳过去，不与之前的连续
        '''
        pos_test = (-1, -1)
        self.pos_xy.append(pos_test)

        self.update()
        self.map.save("./temp.png", "PNG")


if __name__ == "__main__":
    app = QApplication(sys.argv)
    pyqt_learn = Example()
    pyqt_learn.show()
    app.exec_()

```

##### drawUI6.0使用深度学习模型

我想要加载一个深度学习模型来分类我上面保存的图片，就直接在def mouseReleaseEvent(self, event)函数最后面加上预处理图片与模型预测：

```python
    def mouseReleaseEvent(self, event):
        '''
            重写鼠标按住后松开的事件
            在每次松开后向pos_xy列表中添加一个断点(-1, -1)
            然后在绘画时判断一下是不是断点就行了
            是断点的话就跳过去，不与之前的连续
        '''
        pos_test = (-1, -1)
        self.pos_xy.append(pos_test)

        self.update()
        self.map.save("./temp.png", "PNG")

        image = load_image("./temp.png")
        # print("image:", image)  # 画画时可以加载生成的图片

        results = self.model.predict(image)
        # print("results:", results)
        properbilities, types = show_results(self.labels, results)
```

加载模型我在初始化函数里完成了def __init__(self):

```python
# 加载模型，类别字典
self.model, self.labels = load_model_labels()
```

##### [drawUI7.0增加一个按钮](https://blog.csdn.net/yanzi1225627/article/details/72594310)

在初始化函数def __init__(self):加上：

```python
pushButton1 = QPushButton('清除', self)
pushButton1.setToolTip('清楚你的画的垃圾')
pushButton1.resize(pushButton1.sizeHint())
pushButton1.move(30, 20)
pushButton1.clicked.connect(pressed_pushButton1)
```

并在你的窗口类中加上它的触发函数pressed_pushButton1：

```python
def pressed_pushButton1(self):
    print("fsdfsfjioj")
```

##### drawUI8.0清除图画

完善触发函数pressed_pushButton1：

```python
    def pressed_pushButton1(self):
        # 清楚保存的点集合
        self.pos_xy = []

        # 清除画板QWigets，通过：painter.begin(self)。
        painter = QPainter()
        painter.begin(self)  # painter用来画画时在屏幕展出
        painter.end()

        # 通过重新构造来清除保存临时笔画的pixmap
        self.map = QPixmap(WINDOWS_WIDTH, WINDOWS_HEIGHT)
        self.map.fill(Qt.white)  # 设置画板背景为白色
        self.map.save(saved_temp_image, "PNG")
        # 非常重要，更新
        self.update()

        print("清除图片")
```

##### drawUI9.0添加显示topN的控件

在初始化函数def __init__(self)加上三个label用于放置概率与类别：

```python
self.label_1 = QLabel(self)
        self.label_1.move(WINDOWS_WIDTH*0.15, WINDOWS_HEIGHT*0.85)
        self.label_1.setStyleSheet("QLabel{color:rgb(0,0,0,255);font-size:20px;border:2px solid black;"
                                 "font-weight:bold;font-family:Arial;border-radius:50px}"
                                 "QLabel:hover{color:rgb(255,0,0,255)}")
        self.label_1.setAlignment(Qt.AlignTop)  # 水平方向靠左对齐
        self.label_1.setText("aaaaaa\nbbbb")
        self.label_1.adjustSize()  # 自动根据文字内容多少调节窗口大小
		self.label_1.setVisible(False) # 最开始不要出现

        self.label_2 = QLabel(self)
        self.label_2.move(WINDOWS_WIDTH * 0.45, WINDOWS_HEIGHT * 0.85)
        self.label_2.setStyleSheet("QLabel{color:rgb(0,0,0,255);font-size:20px;border:2px solid black;"
                                   "font-weight:bold;font-family:Arial;border-radius:50px}"
                                   "QLabel:hover{color:rgb(255,0,0,255)}")
        self.label_2.setAlignment(Qt.AlignTop)  # 水平方向靠左对齐
        self.label_2.setText("aaaaaa\nbbbb")
        self.label_2.adjustSize()  # 自动根据文字内容多少调节窗口大小
		self.label_2.setVisible(False) # 最开始不要出现

        self.label_3 = QLabel(self)
        self.label_3.move(WINDOWS_WIDTH * 0.75, WINDOWS_HEIGHT * 0.85)
        self.label_3.setStyleSheet("QLabel{color:rgb(0,0,0,255);font-size:20px;border:2px solid black;"
                                   "font-weight:bold;font-family:Arial;border-radius:50px}"
                                   "QLabel:hover{color:rgb(255,0,0,255)}")
        self.label_3.setAlignment(Qt.AlignTop)  # 水平方向靠左对齐
        self.label_3.setText("aaaaaa\nbbbb")
        self.label_3.adjustSize()  # 自动根据文字内容多少调节窗口大小
        self.label_3.setVisible(False) # 最开始不要出现
```

在def mouseReleaseEvent(self, event)函数加载预测结果并放入labels

```python
properbilities, types = show_results(self.labels, results)
self.label_1.setVisible(True) # 预测完后显示控件
self.label_2.setVisible(True)
self.label_3.setVisible(True)
self.label_1.setText("{0:.1f}%\n{1}".format(properbilities[0], types[0]))
self.label_2.setText("{0:.1f}%\n{1}".format(properbilities[1], types[1]))
self.label_3.setText("{0:.1f}%\n{1}".format(properbilities[2], types[2]))
self.label_1.adjustSize()
self.label_2.adjustSize()
self.label_3.adjustSize()
```

此时，清除按钮的触发函数改为：

```python
    def pressed_pushButton1(self):
        # 清楚保存的点集合
        self.pos_xy = []

        # 清除画板QWigets，通过：painter.begin(self)。
        painter = QPainter()
        painter.begin(self)  # painter用来画画时在屏幕展出
        painter.end()

        # 通过重新构造来清除保存临时笔画的pixmap
        self.map = QPixmap(WINDOWS_WIDTH, WINDOWS_HEIGHT)
        self.map.fill(Qt.white)  # 设置画板背景为白色
        self.map.save(saved_temp_image, "PNG")

        # 点击清楚图片时使显示预测结果的控件消失
        self.label_1.setVisible(False)
        self.label_2.setVisible(False)
        self.label_3.setVisible(False)
        # 非常重要，更新
        self.update()

        print("清除图片")
```

#### [22.Qt菜单栏多状态选择---标题前打对钩](https://blog.csdn.net/qq_35451572/article/details/79443078)

#### [**23.PyQt5 笔记5 -- 消息框（QMessageBox）**](https://blog.csdn.net/Wang_Jiankun/article/details/83269859)

简单快速地使用QmessageBox

#### [**24.GUI学习之二十八—QMessageBox**](https://www.cnblogs.com/yinsedeyinse/p/11412016.html)

讲解得非常好，详细。

### 四、Bug

#### Bug1:

在用pyUIC转化QTdesigner生成的ui文件为python代码时，遇到错误:

```
D:\Pro2\Anaconda3\envs\tensorflow\python.exe -m PyQt5.uic.pyuic mainUI.ui -o mainUI.py
Error: No such file or directory: "mainUI.ui"
```
转换下环境就可以了，可能你安装的pyuic不在当前环境下。

#### Bug2：

NameError: name 'QIcon' is not defined

只要 from PyQt5.QtGui import QIcon 就可以了

#### Bug3：

Python&PyQt5报错：AttributeError: module 'PyQt5.QtGui' has no attribute 'QMainWindow'

[**solution:**](https://blog.csdn.net/weixin_42137589/article/details/81489363)

在import中将QtGui改成QtWidgets即可

#### Bug4：

第一个pycharm+pyqt5程序 （解决.ui文件生成的.py文件运行不出现界面问题）

[**solution**](https://blog.csdn.net/yogima/article/details/80589255)

```python
import sys
from first import Ui_MainWindow  # 这里的first是.ui文件生成的.py文件名
from PyQt5 import QtWidgets

# 这个类继承界面UI类
class mywindow(QtWidgets.QWidget, Ui_MainWindow):
    def __init__(self):
        super(mywindow, self).__init__()
        self.setupUi(self)

#调用show
if __name__=="__main__":
    app=QtWidgets.QApplication(sys.argv)
    myshow=mywindow()
    myshow.show()
    sys.exit(app.exec_())
```

#### Bug5：

```python
self.pushButton1.clicked.connect(self.pressed_pushButton1())
TypeError: argument 1 has unexpected type 'NoneType' 
```

把pushButton1后面的括号去掉就可以了

#### Bug6:

!!!当你不知道你的控件需要import什么库时，ctrl+鼠标点击该控件，查看库文件，从文件开头的module就可知该控件所需import的库，如果没有module字样，就直接import 你的这个控件。

#### Bug7:非main函数里里不能用QApplication、sys.exit(app1.exec_())

我在我的一个线程类里使用到了QApplication()类：

```python
class ScreenCatch(threading.Thread):
    def __init__(self, thread_name):
        threading.Thread.__init__(self, name=thread_name)

    def run(self):
        app1 = QApplication(sys.argv)
        # 这个app1不能乱用，你用sys.exit或者app.closxx退出它关闭主界面的时候主界面就会卡死，不退出它就无法释放内存也会卡死。
        ...
        # sys.exit(app1.exec_())  # 这里不能用这个，一个软件程序只能有一个地方来运行此语句，就是在__main__里面。
```

结果当我退出这个类时，主窗口跟着关闭，用上sys.exit(app1.exec_())后，主界面窗口不关闭但是会内存溢出而程序崩溃。

所以当你要使用其它的窗口不要用QApplication(sys.argv)，而是用：

```python
Dialog = Ui2_window(2)  # Ui2_window是另一个子窗口，是QtWidgets.QDialog而不是QtWidgets.QApplication
Dialog.show()
Dialog.exec_()  # 这样退出这个子窗口
```

你可以去看看三大节的第19点

#### bug8:PyQt5连接MYSQL时显示Driver not loaded
**description:**
总结：垃圾QtSql，直接用pysql
When execute code:

Exception output:
```
# PyQt5连接MYSQL时显示Driver not loaded
```

**solution1 failed:**
[PyQt5连接MYSQL时显示Driver not loaded解决方案\_qt isdriveravailable显示可用,但是 driver not loaded-CSDN博客](https://blog.csdn.net/wuhs/article/details/94601527)
```
(venv) F:\Projects\projects_python\temperature_calculator>python
Python 3.6.7 (default, Jul  2 2019, 02:21:41) [MSC v.1900 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license" for more information.
>>> from PyQt5 import QtCore, QtGui, QtWidgets, QtSql
>>> print(QtSql.QSqlDatabase.drivers())
['QSQLITE', 'QODBC', 'QODBC3', 'QPSQL', 'QPSQL7']
>>>
```
原来这里没有mysql驱动。

按照上面的教程安装`pyqt5==5.12.0`
```
pip uninstall pyqt5
pip install pyqt5==5.12.0
```

查看驱动：
```
(venv) F:\Projects\projects_python\temperature_calculator>python
Python 3.6.7 (default, Jul  2 2019, 02:21:41) [MSC v.1900 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license" for more information.
>>> from PyQt5 import QtCore, QtGui, QtWidgets, QtSql
>>> print(QtSql.QSqlDatabase.drivers())
['QSQLITE', 'QMYSQL', 'QMYSQL3', 'QODBC', 'QODBC3', 'QPSQL', 'QPSQL7']
>>>
```
成功！

但是去打开数据库，照样报错：
```
(venv) F:\Projects\projects_python\temperature_calculator>python mainwindow.py
QSqlDatabase: QMYSQL driver not loaded
QSqlDatabase: available drivers: QSQLITE QMYSQL QMYSQL3 QODBC QODBC3 QPSQL QPSQL7
QSqlQuery::exec: database not open
Driver not loaded Driver not loaded
```

命令行测试：
```
from PyQt5 import QtCore, QtGui, QtWidgets, QtSql
db = QtSql.QSqlDatabase.addDatabase('QMYSQL')

from PyQt5.QtSql import QSqlDatabase
```

把`C:\Program Files\MySQL\MySQL Server 8.0\lib\libmysql.dll`
放到目录`F:\Projects\projects_python\temperature_calculator\venv\Lib\site-packages\PyQt5\Qt\plugins\sqldrivers`
也没用。

我之前解决qtc++的数据库驱动问题是忘记移动这个libmysql.dll，当然还要重新编译qsqlmysql.dll库。参考：
[Cannot load the driver from PyQt5 · Issue #9 · thecodemonkey86/qt\_mysql\_driver · GitHub](https://github.com/thecodemonkey86/qt_mysql_driver/issues/9)
页面搜索：qsqlmysql.dll

**solution2**
使用python 3.10.6创建新环境

```
(py310) F:\Projects\projects_python\temperature_calculator>python -m venv .\venv
```


因为python 3.10.6是用MSC v.1929 即14.29 1929 (Visual Studio 2019 Version 16.10+ 16.11)编译的，[见](https://zhuanlan.zhihu.com/p/206743112)
```
(venv) (py310) F:\Projects\projects_python\temperature_calculator>python
Python 3.10.6 | packaged by conda-forge | (main, Aug 22 2022, 20:29:51) [MSC v.1929 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license" for more information.
```

算了，直接不用qt内置的Qtsql，直接用pysql。
```
pip install pysql
```

测试代码：
```python 
import pymysql  
  
# 【读取内容】按钮功能  
def pushB_read_Clicked():  
    conn = pymysql.connect(host='localhost', port=3306, user='root', password="1234", db="temperature_calculator")  
    cur = conn.cursor()  
    # 执行sql语句和实现事件、、、  
    cur.close()  
    conn.close()  
  
pushB_read_Clicked()
```
成功。


#### Bugs search：

这部分用来增加搜索的关键词。

[一些常见的错误参考网址：](https://blog.csdn.net/rosefun96/article/details/79440064)

1.NameError: name 'QApplication' is not defined

from PyQt5.QtWidgets import QApplication

2.NameError: name 'QLabel' is not defined

from PyQt5.QtWidgets import *


3.NameError: name 'QDialog' is not defined

from PyQt5.QtWidgets import QInputDialog, QLineEdit, QDialog


4.AttributeError: 'Form' object has no attribute 'connect'

In PyQt5 you need to use the connect() and emit() methods of the bound signal directly, e.g. instead of:

self.emit(pyqtSignal('add_post(QString)'), top_post)
self.connect(self.get_thread, pyqtSignal("add_post(QString)"), self.add_post)
self.connect(self.get_thread, pyqtSignal("finished()"), self.done)

use:

self.add_post.emit(top_post)
self.get_thread.add_post.connect(self.add_post)
self.get_thread.finished.connect(self.done)
https://stackoverflow.com/questions/41848769/pyqt5-object-has-no-attribute-connect

5.NameError: name 'unicode' is not defined

Python 3 renamed the unicode type to str, the old str type has been replaced by bytes.

