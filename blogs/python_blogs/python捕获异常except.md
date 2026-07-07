---
number headings: auto, first-level 2, max 6, contents ^toc, start-at 1, 1.1
---


## 1 捕获异常

### 1.1 [python中的try-catch-finally-else简介](https://blog.csdn.net/lwgkzl/article/details/81059433)

```python
try：
	code  # 需要判断是否会抛出异常的代码，如果没有异常处理，python会直接停止执行程序
except:  # 这里会捕捉到上面代码中的异常，并根据异常抛出异常处理信息
#except ExceptionName as e：    # 同时也可以接受异常名称和参数，针对不同形式的异常做处理
	code  # 这里执行异常处理的相关代码，打印输出等
else：  # 如果没有异常则执行else
	code  # try部分被正常执行后执行的代码
finally：
	code  # 退出try语句块总会执行的程序
```

所以，正常的流程是：try没有发生错误->else内的代码->finally中的代码。
发生异常的流程是：try中发生异常->被except捕获并执行except片段中的代码->执行finally中的代码。

### 1.2 [彻底搞懂Python异常处理：try-except-else-finally](https://zhuanlan.zhihu.com/p/360807803)
- **try**：正常情况下，程序计划执行的语句。
- **except**：程序异常是执行的语句。
- **else**：程序无异常即try段代码正常执行后会执行该语句。
- **finally**：不管有没有异常，都会执行的语句。

#### 1.2.1 除数为0.0

##### 1.2.1.1 **try-->except-->finally**

```text
def test():
    try :
        a = 5.0 / 0.0
        print('输出：我是try')
        return 0
    except :
        print('输出：我是except')
        return 1
    else :
        print('输出：我是else')
        return 2
    finally :
        print('输出：finally')
        return 3
print('test: ',test())
# 输出：我是except
# 输出：finally
# test: 3
```

程序在except内部虽然已经return了，但是finally依然会被执行，此时finally亦有return，则输出为finally代码段的返回值。

##### 1.2.1.2 **try-->except-->finally**，返回except代码段返回值

```text
def test():
    try :
        a = 5.0 / 0.0
        print('输出：我是try')
        return 0
    except :
        print('输出：我是except')
        return 1
    else :
        print('输出：我是else')
        return 2
    finally :
        print('输出：finally')
print('test: ',test())
# 输出：我是except
# 输出：finally
# test: 1
```

程序在except内部虽然已经return了，但是finally依然会被执行，此时finally内部没有return，则最终输出except代码段的返回值。

#### 1.2.2 除数为1.0

##### 1.2.2.1 **try-->else-->finally**

```text
def test():
    try :
        a = 5.0 / 1.0
        print('输出：我是try')
        return 0
    except :
        print('输出：我是except')
        return 1
    else :
        print('输出：我是else')
        return 2
    finally :
        print('输出：finally')
        return 3
print('test: ',test())
# 输出：我是try
# 输出：finally
# test: 3
```

程序在try内部虽然已经return了，但是else和finally依然会被执行，此时finally有return，则输出为finally代码段的返回值。
##### 1.2.2.2 **try-->finally**，返回try代码段返回值

```text
def test():
    try :
        a = 5.0 / 1.0
        print('输出：我是try')
        return 0
    except :
        print('输出：我是except')
        return 1
    else :
        print('输出：我是else')
        return 2
    finally :
        print('输出：finally')
        # return 3
print('test: ',test())
# 输出：我是try
# 输出：finally
# test: 0
```

程序在try内部已经return了，else不会被执行，finally会被执行，此时finally没有return，则输出为try代码段的返回值。

##### 1.2.2.3 **try-->else-->finally**，返回else代码段返回值

```text
def test():
    try :
        a = 5.0 / 1.0
        print('输出：我是try')
        # return 0
    except :
        print('输出：我是except')
        return 1
    else :
        print('输出：我是else')
        return 2
    finally :
        print('输出：finally')
        # return 3
print('test: ',test())
# 输出：我是try
# 输出：我是else
# 输出：finally
# test: 2
```

程序在try内部无return，else将会被执行，finally也会被执行，此时finally没有return，则输出为else代码段的返回值。
#### 1.2.3 总结：

- 无论有无异常，finally代码段一定会被执行
- 若有异常，则执行except代码段
- 若无异常且无return，则执行else代码段
- 若无异常且有return， try代码段中有return 语句， 则else代码段不会被执行
- 若无异常且有return， try代码段没有return语句，则else代码段会执行
### 1.3 [Python捕获多个异常](https://blog.csdn.net/cunchi4221/article/details/107475802)

在不同的区块中捕获`ValueError`和`TypeError`

```python
try:
	y = square(input('Please enter a number\n'))
	print(y)
except ValueError as ve:
	print(type(ve), '::', ve)
except TypeError as te:
	print(type(te), '::', te)
```

在单个except块中捕获多个异常 (Catch Multiple Exceptions in a single except block)

```python
try:
    y = square(input('Please enter a number\n'))
    print(y)
except (ValueError, TypeError) as e:
    print(type(e), '::', e)
```



### 1.4 [Python中错误（Error）分类处理](https://blog.csdn.net/LJH111101/article/details/93767753)

错误类型	错误解释
AssertionError	断言语句（assert）失败
AttributeError	尝试访问未知的对象属性
EOFError	用户输入文件末尾标志EOF（Ctrl+d）
FloatingPointError	浮点计算错误
GeneratorExit	generator.close()方法被调用的时候
ImportError	导入模块失败的时候
IndexError	索引超出序列的范围
KeyError	字典中查找一个不存在的关键字
KeyboardInterrupt	用户输入中断键（Ctrl+c）
MemoryError	内存溢出（可通过删除对象释放内存）
NameError	尝试访问一个不存在的变量
NotImplementedError	尚未实现的方法
OSError	操作系统产生的异常（例如打开一个不存在的文件）
OverflowError	数值运算超出最大限制
ReferenceError	弱引用（weak reference）试图访问一个已经被垃圾回收机制回收了的对象
RuntimeError	一般的运行时错误
StopIteration	迭代器没有更多的值
SyntaxError	Python的语法错误
IndentationError	缩进错误
TabError	Tab和空格混合使用
SystemError	Python编译器系统错误
SystemExit	Python编译器进程被关闭
TypeError	不同类型间的无效操作
UnboundLocalError	访问一个未初始化的本地变量（NameError的子类）
UnicodeError	Unicode相关的错误（ValueError的子类）
UnicodeEncodeError	Unicode编码时的错误（UnicodeError的子类）
UnicodeDecodeError	Unicode解码时的错误（UnicodeError的子类）
UnicodeTranslateError	Unicode转换时的错误（UnicodeError的子类）
ValueError	传入无效的参数
ZeroDivisionError	除数为零

以下是 Python 内置异常类的层次结构：
BaseException
+-- SystemExit
+-- KeyboardInterrupt
+-- GeneratorExit
+-- Exception
      +-- StopIteration
      +-- ArithmeticError
      |    +-- FloatingPointError
      |    +-- OverflowError
      |    +-- ZeroDivisionError
      +-- AssertionError
      +-- AttributeError
      +-- BufferError
      +-- EOFError
      +-- ImportError
      +-- LookupError
      |    +-- IndexError
      |    +-- KeyError
      +-- MemoryError
      +-- NameError
      |    +-- UnboundLocalError
      +-- OSError
      |    +-- BlockingIOError
      |    +-- ChildProcessError
      |    +-- ConnectionError
      |    |    +-- BrokenPipeError
      |    |    +-- ConnectionAbortedError
      |    |    +-- ConnectionRefusedError
      |    |    +-- ConnectionResetError
      |    +-- FileExistsError
      |    +-- FileNotFoundError
      |    +-- InterruptedError
      |    +-- IsADirectoryError
      |    +-- NotADirectoryError
      |    +-- PermissionError
      |    +-- ProcessLookupError
      |    +-- TimeoutError
      +-- ReferenceError
      +-- RuntimeError
      |    +-- NotImplementedError
      +-- SyntaxError
      |    +-- IndentationError
      |         +-- TabError
      +-- SystemError
      +-- TypeError
      +-- ValueError
      |    +-- UnicodeError
      |         +-- UnicodeDecodeError
      |         +-- UnicodeEncodeError
      |         +-- UnicodeTranslateError
      +-- Warning
           +-- DeprecationWarning
           +-- PendingDeprecationWarning
           +-- RuntimeWarning
           +-- SyntaxWarning
           +-- UserWarning
           +-- FutureWarning
           +-- ImportWarning
           +-- UnicodeWarning
           +-- BytesWarning
           +-- ResourceWarning