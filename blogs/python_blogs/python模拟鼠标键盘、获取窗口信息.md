## [python截屏窗口](https://blog.csdn.net/Kwoky/article/details/113617571)

```python
import win32gui
from PyQt5.QtWidgets import QApplication
import sys
import numpy as np
from PIL import Image
import matplotlib.pyplot as plt
import cv2
import time
# reference: https://blog.csdn.net/Kwoky/article/details/113617571
hwnd_title = dict()


def get_all_hwnd(hwnd, mouse):
    if win32gui.IsWindow(hwnd) and win32gui.IsWindowEnabled(hwnd) and win32gui.IsWindowVisible(hwnd):
        hwnd_title.update({hwnd: win32gui.GetWindowText(hwnd)})


def ScreenCatch():
    for h, t in hwnd_title.items():
        if t is not "":
            print(h, t)

    win32gui.EnumWindows(get_all_hwnd, 0)
    hwnd = win32gui.FindWindow(None, 'S-EYE')  # 窗口的名字放这里
    # hwnd = win32gui.FindWindow(None, 'ACG 播放器')
    print("窗口句柄hwnd，十进制:{0} 十六进制:{1}".format(hwnd, hex(hwnd)))
    app = QApplication(sys.argv)
    screen = QApplication.primaryScreen()
    for i in range(1, 3, 1):
        start_time = time.time()
        image = screen.grabWindow(hwnd).toImage()
        size = image.size()
        s = image.bits().asstring(size.width() * size.height() * image.depth() // 8)  # format 0xffRRGGBB
        image_array = np.fromstring(s, dtype=np.uint8).reshape((size.height(), size.width(), image.depth() // 8))

        # image_array = image_array[91:691, 0:800, :3]  # 用mspaint观察后，截取S-EYE软件的图像部分，一共四个通道，保留前三个通道rbg

        cv2.imwrite("test_output/%d.jpg" % i, image_array)
        exec_time = 1000*(time.time()-start_time)
        print("capture time:{0:.1f}ms {1:.1f}fps".format(exec_time, 1000/exec_time))

        # print(image_array.shape)  # (600, 800, 4)
        # image = cv2.cvtColor(image_array, cv2.COLOR_BGR2RGB)  # 注意这行。QImage居然是BGR格式，plt是RGB格式。
        # plt.imshow(image)
        # plt.show()
    cv2.moveWindow("test", 0, 0)

    cv2.imshow("test", image_array)
    # cv2.resizeWindow("test", 600, 800)
    cv2.waitKey(1000)
    cv2.destroyWindow("test")


ScreenCatch()

"""
screen.grabWindow(hwnd).toImage()
保存图片情况下的速度：
capture time:17.0ms 59.0fps
capture time:16.9ms 59.1fps
capture time:19.0ms 52.7fps

不保存图片情况下的速度：
capture time:6.0ms 166.7fps
capture time:8.0ms 125.3fps
capture time:7.1ms 141.2fps
capture time:39.89ms
capture time:31.45ms
capture time:33.20ms
"""
```



## [python模拟鼠标键盘、获取窗口](https://www.cnblogs.com/liming19680104/p/11988565.html)



## [如何通过python窗口句柄、后台鼠标点击制作你自己的外挂](https://zhuanlan.zhihu.com/p/309664632)

```python
# 关闭窗口
win32gui.PostMessage(win32gui.findWindow(classname, titlename), win32con.WM_CLOSE, 0, 0)
# win32gui.findWindow(classname, titlename)  # 这行是在找窗口句柄
```

## 通过post message关闭窗口

```python

def post_message_close_window():
    import win32gui
    import win32con
    import time
    hwnd = win32gui.FindWindow(None, 'S-EYE')  # 窗口的名字放这里
    print("hwnd:", hwnd)
    win32gui.PostMessage(hwnd, win32con.WM_CLOSE, 0, 0)
    time.sleep(1)
    sub_hwnd = win32gui.FindWindow("UIMessageDialog", None)  # 窗口的名字放这里
    print("sub_hwnd:", sub_hwnd)
    win32gui.PostMessage(sub_hwnd, win32con.WM_CLOSE, 0, 0)

```

## [本地win32的chm文档](E:\Anaconda3-2019.10-Windows-x86_64\envs\tensorflow-gpu\Lib\site-packages\PyWin32.chm)



## [PostMessage(异步)和SendMessage(同步)的区别](https://blog.csdn.net/qq_26399665/article/details/54235835)

PostMessage只把消息放入队列，不管其他程序是否处理都返回，然后继续执行，这是个异步消息投放函数。而SendMessage必须等待其他程序处理消息完了之后才返回，继续执行，这是个同步消息投放函数。而且，PostMessage的返回值表示PostMessage函数执行是否正确；而SendMessage的返回值表示其他程序处理消息后的返回值。这点大家应该都明白。

SendMessage 函数功能 ：该函数将指定的消息发送到一个或多个窗口。此函数为指定的窗口调用窗口程序，直到窗口程序处理完消息再返回，是同步消息投放函数。而函数PostMessage不同，将一个消息寄送到一个线程的消息队列后立即返回，是异步消息投放函数。



## [Python自动操作GUI神器PyAutoGUI](https://zhuanlan.zhihu.com/p/302592540)

使用win32太麻烦，直接用这个算了。最简单还是要靠按键精灵。

和pywinauto比怎么样？pywinauto就是pywin32再包一层，接口复杂，参数都不知道该咋传。

## [主题:对spy++找不到的控件句柄，怎么从外部控制？](https://m.newsmth.net/article/VisualC/270425)

2014-08-31 19:58:15|[只看此ID](https://m.newsmth.net/article/VisualC/270425?au=hollywood)

在dialog下面圈地，
围出一块，
自绘控件，
特殊处理dialog的事件。
这样就没有单独的控件了，
spy++拿到的也就是dialog的句柄

## 置顶窗口失败

```python

def activate_recognition():
    import win32gui
    import win32con
    hwnd = win32gui.FindWindow(None, "Recognition")
    # win32gui.ShowWindow(win32gui.FindWindow(None, "Recognition"), win32con.SW_SHOWNA)  # 不能聚焦此窗口
    win32gui.SendMessage(hwnd, win32con.WM_WINDOWPOSCHANGING, 0x0, 0x704C3EBCF0)
    win32gui.SendMessage(hwnd, win32con.WM_WINDOWPOSCHANGED, 0x0, 0x704C3EBCF0)
    win32gui.PostMessage(hwnd, win32con.WM_ACTIVATEAPP, 0x1, 0x0)
    win32gui.PostMessage(hwnd, win32con.WM_NCACTIVATE, 0x1, 0x0)
    win32gui.PostMessage(hwnd, win32con.WM_ACTIVATE, 0x2, 0x0)
    win32gui.SendMessage(hwnd, win32con.WM_IME_SETCONTEXT, 0x1, 0xF)
    win32gui.SendMessage(hwnd, win32con.WM_IME_NOTIFY, 0x2, 0x0)
    win32gui.SendMessage(hwnd, win32con.WM_SETFOCUS, 0x0, 0x0)

    # win32gui.PostMessage(win32gui.FindWindow(None, "Recognition"), win32con.WM_ACTIVATEAPP, 0x1, 0)  # 不能聚焦此窗口
    # 我用spyxx监视鼠标从外面点击进recognition然后又点出去，然后把点进去时监听到的S类，也就是发送出去的消息重新用上面的代码走一遍还是不能达到激活窗口的效果。
activate_recognition()
```

