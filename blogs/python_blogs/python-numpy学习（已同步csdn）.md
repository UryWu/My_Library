@[TOC](目录)
## 学习numpy库

### 1. 交换数组的维度shape

从（图片高度, 图片宽度, 3）重塑为（3, 图片高度, 图片宽度）

```python
img = np.swapaxes(img, 0, 2) # 交换第一维和第三维度
img = np.swapaxes(img, 1, 2) # 交换第二维和第三维度
```

[参考](https://blog.csdn.net/lengxiaohe/article/details/81329152)

[numpy中transpose和swapaxes函数讲解：](https://blog.csdn.net/qq1483661204/article/details/70543952)

### 2. 添加ndarray维度

#### 2.1 numpy.expand_dims()

作用：添加ndarray的维度

示例：

```python
data = [[1, 2, 3], [4, 5, 6]]
data = np.expand_dims(data, axis=-1)
print(data)
```

输出：

```bash
[[[1], [2], [3]], [[4], [5], [6]]]
```

解析：

axis=-1表示最里面的维度，比如`[[1, 2, 3], [4, 5, 6]]`，他的shape为（2, 3），是一个二维数组。axis为-1表示(3,)这个维度，就是到达最里面的数据1,这个深度。



如果axis为0
```python
data = [[1, 2, 3], [4, 5, 6]]
data = np.expand_dims(data, axis=0)
print(data)
```

输出：
```bash
[[[1, 2, 3], [4, 5, 6]]]
```

0维代表自己，最外面的维度。

要想达到`[[[1], [2], [3]], [[4], [5], [6]]]`这个效果这里也可以写：

```python
data = np.expand_dims(data, axis=2)
```

#### 2.2 numpy.newaxis()

img = img[np.newaxis, :]

### 3. reshape(1,-1)什么意思？
`data.reshape(行, 列)`

```python
def numpy_reshape():
    data = np.array([[1,2,3], [4,5,6], [7,8,9]])
    # data = np.random
    print("一行：")
    print(data.reshape(1, -1))  # -1就是不指定列数，这里将数据做成一行
    print("一列：")
    print(data.reshape(-1, 1))  # -1就是不指定行数，这里将数据做成一列

numpy_reshape()
```
[参考](https://zhuanlan.zhihu.com/p/32078089)

## 其它学习链接

#### [numpy.log(math.log)](https://blog.csdn.net/mr_cat123/article/details/78806827)

#### [利用Numpy对特征中的异常值进行替换及条件替换](https://blog.csdn.net/weixin_41713230/article/details/81283813)

#### [python︱numpy、array——高级matrix（替换、重复、格式转换、切片、合并）](https://blog.csdn.net/sinat_26917383/article/details/52290505)

内容多而全。

#### [numpy中的mean()函数](https://blog.csdn.net/lilong117194/article/details/78397329)

#### [numpy.split()函数](https://blog.csdn.net/mingyuli/article/details/81227629)

#### [numpy.stack最通俗的理解](https://blog.csdn.net/qq_17550379/article/details/78934529)

#### [numpy-argsort函数（详细、通俗易懂）](https://www.jianshu.com/p/64c607d49528)

非常清晰，升序排列数组中数字的大小，以索引为键。三维数据的讲解也很简明。

#### [Python的numpy库中rand(),randn(),randint(),random_integers()的使用](https://www.cnblogs.com/mlan/p/8179028.html)



## Bugs:

### Bug1:ValueError: setting an array element with a sequence.

**solution1:**
在创建NDarray时候没有让所有的元素放在一个中括号里
错误示例：

```python
a1 = nd.array([[1,1,2],[2,3,3]],[[4,3,3],[5,4,4]])
```

正确示例：

```python
a1 = nd.array([[[1,1,2],[2,3,3]],[[4,3,3],[5,4,4]]])
```

**solution2:**

```python
a1 = nd.array([[[1,1,2],[2,3,3]],[[4,3,3],[5,4,4]]])
b1 = np.array([[[8,8,8],[8,8,8]],[[9,9,9],[9,9,9]]], dtype=np.uint8) # 这里很重要，没有规定为uint8就无法以图片输出

# b1[:][:][0]等同于b1[:, :, 0]
a1[:][:][0] = b1[:][:][1] # 这样赋值可以，mxnet.ndarray比较强大
b1[:][:][0] = a1[:][:][1] # 不能给numpy这样赋mxnet.ndarray的值，会报上面的那个错误，mxnet.ndarry的值无法直接赋给numpy.ndarray
```

### Bug2:TypeError: Expected cv::UMat for argument 'mat'

**solution:**
说明此格式不适合cv2来以图片输出，cv2支持numpy.array格式的数据

### Bug3:ValueError: The truth value of an array with more than one element is ambiguous

**scene：**
当比较numpy数组时

```python
images[1][i][j][:] == np.array([0,0,0])
```

**exception：**

```bash
ValueError: The truth value of an array with more than one element is ambiguous
```

**solution：**

加all()或any()：

```python
all(images[1][i][j][:] == np.array([0,0,0])) 
```

[参考](https://blog.csdn.net/sinat_33563325/article/details/79868109)