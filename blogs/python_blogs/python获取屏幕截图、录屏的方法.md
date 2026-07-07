## [Python获取屏幕截图的方法](https://blog.csdn.net/Kwoky/article/details/113617571)

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


for h, t in hwnd_title.items():
    if t is not "":
        print(h, t)

win32gui.EnumWindows(get_all_hwnd, 0)
hwnd = win32gui.FindWindow(None, 'S-EYE')  # 窗口的名字放这里
app = QApplication(sys.argv)
screen = QApplication.primaryScreen()
for i in range(3):
    start_time = time.time()
    image = screen.grabWindow(hwnd).toImage()
    size = image.size()
    s = image.bits().asstring(size.width() * size.height() * image.depth() // 8)  # format 0xffRRGGBB

    image_array = np.fromstring(s, dtype=np.uint8).reshape((size.height(), size.width(), image.depth() // 8))

    image_array = image_array[91:691, 0:800, :3]  # 用mspaint观察后，截取S-EYE软件的图像部分，一共四个通道，保留前三个通道rbg
    # cv2.imwrite("test_output/%d.jpg" % (i), image_array)

    print("capture time:{:.2f}ms".format(1000*(time.time()-start_time)))
    # print(image_array.shape)  # (600, 800, 4)

    # image = cv2.cvtColor(image_array, cv2.COLOR_BGR2RGB)  # 注意这行。QImage居然是BGR格式，plt是RGB格式。
    # plt.imshow(image)
    # plt.show()

"""
保存图片情况下的速度：
capture time:44.91ms
capture time:47.49ms
capture time:47.29ms

不保存图片情况下的速度：
capture time:39.89ms
capture time:31.45ms
capture time:33.20ms
"""
```

## [python 通过标题获取窗口大小](https://blog.csdn.net/weixin_33595571/article/details/92751255)

极简代码

```python
# -*- coding: utf-8 -*-
"""
Created on Mon Jun 17 22:55:33 2019
QQ群：476842922(欢迎加群讨论学习)
@author: Administrator
"""

import win32gui
import win32api
classname = "MozillaWindowClass"
titlename = "aaaaa.txt - 记事本"
#获取句柄
hwnd = win32gui.FindWindow(0, titlename)
#获取窗口左上角和右下角坐标
left, top, right, bottom = win32gui.GetWindowRect(hwnd)
print(left)

```



## [调用Windows API截图要50ms一张图，那么那些录屏软件是如何做到60FPS的速度的呢？](https://www.zhihu.com/question/267207676/answer/455119511)

```python
import mss
import time

with mss.mss() as sct:
    monitor = {'top': 0, 'left': 0, 'width': 2560, 'height': 1440}
    last_time = time.time()
    n = 400
    for i in range(n):
        sct.grab(monitor)

    print(n / (time.time() - last_time))
```

如果只是1440 * 900的话,那就是稳稳的60帧了

1000/60≈16.7ms

是在内存了，但不存下来在内存有什么意义呢？此方法保存在运行内存里。

## [如何用Python做一个免费的录屏软件？](https://zhuanlan.zhihu.com/p/77595912)

使用win32gui获取鼠标位置

```python
import  win32gui


flags, hcursor, (x,y) = win32gui.GetCursorInfo()
print("x:",x," y:",y)
```



## [用python实现录屏，亲测好用！！！](https://blog.csdn.net/linnahan/article/details/104567183/?utm_medium=distribute.pc_relevant.none-task-blog-baidujs_baidulandingword-0&spm=1001.2101.3001.4242)

调节帧率获取较小的视频文件

## [将QImage转换为numpy array](https://blog.csdn.net/yx1302317313/article/details/104527401)

