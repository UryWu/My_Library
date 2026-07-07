# [一篇文章讲清python中的线程的概念以及基本的使用方法](https://juejin.cn/post/7449557640822718464)



## 首先介绍一下线程

### 概念

- 线程是进程内部的执行单元，是程序执行流的最小单元。一个进程可以包含多个线程，这些线程共享进程的资源，如内存空间、代码段、数据段等。可以把线程想象成工厂里的工人，他们在同一个工厂（进程）的空间内工作，共享工厂里的设备和原料（进程资源）。
- 比如，在一个文本编辑器进程中，可能有一个线程负责接收用户的输入，另一个线程负责在后台自动保存文件。它们都在同一个文本编辑器进程的内存空间等资源下工作。

### 调度方式

- 线程的调度也是由操作系统来完成的。不过，由于线程共享进程的资源，线程之间的切换相对进程切换要轻量级一些。但是同样需要操作系统保存和恢复线程的上下文，如程序计数器、寄存器值等。
- 比如，在一个多线程的网络服务器进程中，当一个线程处理完一个客户端请求后，操作系统调度器可能会暂停这个线程，切换到另一个等待处理请求的线程。

### 资源占用和开销

- 线程占用的资源相对较少，因为它们共享进程的大部分资源。但是，创建和销毁线程仍然有一定的开销，并且多个线程之间共享资源可能会导致资源竞争等问题，需要使用同步机制来解决，这也会带来一定的开销。
- 例如，线程之间共享变量时，如果没有正确的同步措施，可能会出现数据不一致的情况。解决这个问题可能需要使用锁等同步机制，而使用锁会导致线程的等待，增加开销。

### 适用场景

- 适用于在同一个进程内需要同时执行多个任务，并且这些任务之间需要共享数据的情况。比如，在一个图形用户界面（GUI）应用中，一个线程可以用于更新界面，另一个线程可以用于处理用户的输入事件，它们共享界面相关的数据。
- 例如，在一个简单的文件下载工具中，一个线程可以用于接收用户的下载请求，另一个线程可以用于实际的文件下载和保存，这样可以提高程序的响应速度和效率。

## 在程序中如何使用线程

### 简单实现

#### 随便创建一个方法

```python
python 体验AI代码助手 代码解读复制代码#方法
def task():
    print("hello python")
    print("hello world")
```

#### main函数

```python
python 体验AI代码助手 代码解读复制代码#假设要创建五个线程
for i in range(5):
    # 通过主线程来调度子线程,创建了一个子线程对象。子线程去分配任务
    # target：指定执行哪一个函数，函数名
    t = threading.Thread(target=task)
    # 开启线程
    t.start()
```

#### 运行结果

hello python
hello world
hello python
hello world
hello python
hello world
hello python
hello world
hello python
hello world

### 守护线程

#### 概念

- 在 Python 中，守护线程（Daemon Thread）是一种特殊类型的线程。它是为其他非守护线程（也称为用户线程）提供服务的线程。守护线程的主要特点是当程序中所有的非守护线程都结束时，守护线程会自动终止，即使守护线程中的任务还没有完成。
- 可以把守护线程想象成一个后台服务进程。例如，在一个音乐播放软件中，主线程负责播放音乐文件，而守护线程可能负责定期检查软件更新。当用户关闭音乐播放（主线程结束）时，软件更新检查这个守护线程就没有必要继续运行了，它会自动退出，不会阻止程序的结束。

#### 定义一个方法为守护线程方法（这边定义一个死循环，方便观察程序执行）

```python
python 体验AI代码助手 代码解读复制代码def task():
    while True:
        print("hello python")
        time.sleep(1)
        print("hello world")
```

#### 定义主线程

```python
python 体验AI代码助手 代码解读复制代码def task1():
    time.sleep(1)
    print("hello")
```

#### 主函数

```python
python 体验AI代码助手 代码解读复制代码if __name__ == '__main__':
    # 通过主线程来调度子线程,创建了一个子线程对象。子线程去分配任务
    # target：指定执行哪一个函数，函数名
    t = threading.Thread(target=task)
    t1 = threading.Thread(target=task1)
    # 当程序当中仅剩下守护线程时，主线程结束，python程序能够正常退出，不必关心这一类线程是否执行完毕
    t.setDaemon(True)
    # 开启线程
    t.start()
    t1.start()
    # 默认情况执行，主线程结束，子线程会跟着结束吗
```

#### 运行结果

hello python
hello world
hello python

hello



运行结果不一，你可能会看到先打印出 `"hello"`（来自 `t1` 线程），然后可能会看到几次 `"hello python"` 和 `"hello world"`（来自 `t` 线程），之后程序就结束了，不会无休止地打印下去，因为守护线程在其他非守护线程结束后就跟着结束了，进而导致整个程序退出

### 控制线程执行顺序

#### 定义一个方法 模拟下载数据

```python
python 体验AI代码助手 代码解读复制代码def download_data():
    print('开始下载数据....')
    time.sleep(1)  # 模拟数据下载时，所耗时1秒
    print('数据下载完成')
```

#### 主函数

```python
python 体验AI代码助手 代码解读复制代码if __name__ == '__main__':
    # 定义一个列表，用于存放创建的子线程对象
    lst = []
    # 通过循环创建5个子线程，每个子线程都将执行download_data函数所代表的任务
    for i in range(5):
        # 创建子线程对象，指定该子线程要执行的任务是download_data函数
        t = threading.Thread(target=download_data)
        # 开启线程，此时子线程开始独立运行，去执行download_data函数里的任务了
        t.start()
        # 将创建好并已启动的子线程对象添加到列表lst中，方便后续统一管理和等待它们结束
        lst.append(t)

    # 通过循环遍历存放子线程对象的列表lst
    for j in lst:
        # 调用子线程对象的join方法，这会使主线程阻塞在这里，等待对应的子线程执行完毕
        # 也就是说，主线程会暂停往下执行代码，直到当前这个子线程完成了它的任务（比如数据下载完成）才继续往后走
        j.join()

    # 以下是主线程后续要执行的代码，上面通过join方法确保了所有子线程（也就是数据下载任务）都已经结束了
    # 如果没有使用join方法，有可能出现数据还没下载完成，主线程就执行到这里开始处理数据的情况，这显然不符合要求
    # 只有等所有数据都下载好了（所有子线程都结束了），才能进行数据处理相关的操作
    print('开始处理数据.....')
    print('数据处理完成')
```

#### 运行结果

开始下载数据.....
开始下载数据.....
开始下载数据.....
开始下载数据.....
开始下载数据.....
数据下载完成数据下载完成
数据下载完成数据下载完成数据下载完成
开始处理数据.....
数据处理完成



可以发现，当五个子线程都运行完毕，五个数据下载完成才会开始数据，这里可以思考一下，为什么“数据下载完成”会并排打印

### 面向对象多线程

#### 定义两个类，继承线程类

```python
python 体验AI代码助手 代码解读复制代码class MyThread1(threading.Thread):
    def run(self):
        for i in range(5):
            print(f'task1.........{i}')
            time.sleep(0.5)


class MyThread2(threading.Thread):
    def run(self):
        for i in range(5):
            print(f'task2.........{i}')
            time.sleep(0.5)
```

#### 主函数

```python
python 体验AI代码助手 代码解读复制代码if __name__ == '__main__':
    # 根据类创建了对象
    mt1 = MyThread1()
    mt2 = MyThread2()
    # 开启子线程一定是通过start开启的
    mt1.start()
    mt2.start()
```

#### 运行结果

task1.........0
task2.........0
task2.........1
task1.........1
task1.........2
task2.........2
task2.........3

task1.........3
task1.........4
task2.........4

### 线程之间的资源竞争

#### 什么时候会出现资源竞争

假设定义了一个全局变量 `num`，在多线程环境下，多个线程都可能对这个变量进行读写操作。当多个线程同时执行修改操作时，就会出现资源竞争问题，导致最终 `num` 的结果不符合预期，可能出现数据错误或不一致的情况。例如，一个线程读取 `num` 的值准备进行加 1 操作时，另一个线程也同时读取了这个值进行同样操作，这样就会丢失一次累加，最终结果就会小于预期值

#### 出现严重资源竞争的代码

```python
python 体验AI代码助手 代码解读复制代码import threading
num = 0
def task1(data):
    global num
    for i in range(data):
        num = num + 1
    print(f'task1---num={num}')


def task2(data):
    global num
    for i in range(data):
        num = num + 1
    print(f'task2---num={num}')


if __name__ == '__main__':
    # 传参的数据类型必须是元组
    t1 = threading.Thread(target=task1, args=(10000000,))
    t2 = threading.Thread(target=task2, args=(10000000,))
    t1.start()
    t2.start()
```

#### 运行结果

理论上两个都输出的是20000000

实际上 

task1---num=11133163
task2---num=12169027

#### 如何避免--上锁

##### 锁的概念：

在多线程编程中，锁（Lock）是一种同步机制，用于控制多个线程对共享资源的访问。共享资源可以是一个变量、一个数据结构或者一段代码等。当一个线程获取了锁，就相当于它获得了对共享资源的独占访问权，其他线程在该锁被释放之前无法访问这个共享资源。

#### 上了锁的改进代码

```python
python 体验AI代码助手 代码解读复制代码import threading
def task1(data):
    global num
    for i in range(data):
        # 上锁
        mutex.acquire()
        num = num + 1
        # 解锁
        mutex.release()
    print(f'task1---num={num}')


def task2(data):
    global num
    for i in range(data): 
        # 上锁
        mutex.acquire()
        num = num + 1
        # 解锁
        mutex.release()
    print(f'task2---num={num}')


if __name__ == '__main__':
    # 创建一把锁,创建了锁对象
    # mutex = threading.Lock()  # 只能创建一把锁，上了一把锁，必须先解开
    mutex = threading.RLock()  # 可重入锁，可以创建多把锁。创建了多少把锁，对应的解多少把。上锁和解锁是不对应，就会造成死锁
    # 传参的数据类型必须是元组
    t1 = threading.Thread(target=task1, args=(10000000,))
    t2 = threading.Thread(target=task2, args=(10000000,))
    t1.start()
    t2.start()
```

#### 运行结果

task1---num=19525387
task2---num=20000000



可以发现都无限接近20000000 避免了大部分资源竞争

### 队列与线程

#### 队列（Queue）的概念

遵循先进先出（FIFO）原则。就像排队买东西，先排队的人先得到服务并离开队伍。在队列中，元素的插入（入队）操作在一端进行，通常称为队尾（rear）；元素的删除（出队）操作在另一端进行，称为队头（front）。

#### 队列结合多线程

```python
python 体验AI代码助手 代码解读复制代码from queue import Queue
import threading
import time

# 定义函数set_value，该函数用于向队列中放入数据
# 参数q是一个Queue类型的队列对象，通过这个队列来传递数据
def set_value(q):
    num = 0
    # 进入无限循环，意味着这个函数会持续不断地执行下面的操作，直到程序被强制终止
    while True:
        # 将当前的num值放入队列q中，这样其他线程就可以从这个队列中获取到这个值
        q.put(num)
        # num的值自增1，以便下次放入队列的是一个新的值
        num += 1
        # 让当前线程暂停0.4秒，模拟数据生成有一定时间间隔的情况，避免过快地向队列中填充数据
        time.sleep(0.4)

# 定义函数get_value，该函数用于从队列中取出数据并打印出来
def get_value(q):
    while True:
        # 从队列q中取出一个值，这里如果队列中暂时没有值，该线程会阻塞在这里等待，直到队列中有值可供取出
        print(q.get())

if __name__ == '__main__':
    # 1. 需要有队列的容器
    # 创建一个Queue对象q，设置其最大容量为4，即队列中最多可以同时存放4个元素
    q = Queue(4)
    # 创建两个子线程，一个子线程是存值，一个子线程的取值
    # 创建第一个子线程t1，指定其执行的任务为set_value函数，并将队列q作为参数传递给set_value函数
    t1 = threading.Thread(target=set_value, args=(q,))
    # 创建第二个子线程t2，指定其执行的任务为get_value函数，并将队列q作为参数传递给get_value函数
    t2 = threading.Thread(target=get_value, args=(q,))
    # 启动子线程t1，启动后该线程就会开始独立执行set_value函数里的任务，不断向队列中放入数据
    t1.start()
    # 启动子线程t2，启动后该线程就会开始独立执行get_value函数里的任务，不断从队列中取出数据并打印
    t2.start()
```

#### 运行结果

105
106
107
108
109
110
111
112
113
114
115
116
117
118

会一直循环运行下去

完结 本人大一，只学了些皮毛，若有不足之处，请多指教（抱拳）

