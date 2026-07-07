

### 1 jieba分词评论数据

#### 1.1 **数据：**

苹果所有评论.xlsx

![image-20200508234045893](.\python-pandas学习.assets\image-20200508234045893.png)

#### 1.2 需求

用jieba分词正文这里的评论数据，分词结果用\隔开。

#### 1.3 代码：

```python
import pandas as pd

def clean_data():
    df = pd.read_excel(r'.\苹果所有评论.xlsx')
    # df = df.iloc[:5, :]  # 取1到5行，所有列
    df_comments = df[["序号", "正文"]]

    # for i in df_comments["正文"]:
    #     seg_list = jieba.cut(str(i))
    # #     结巴分词必须要用 / ".join()否则返回一大堆内存地址，seg_list里是一堆内存地址
    #     print(" / ".join(seg_list))

    # print(df_comments.iloc[:5, 1].values)
    df_comments["分词结果"] = df_comments["正文"].apply(lambda x: " / ".join(jieba.cut(x)))

    # index=False表示不写入索引
    df_comments.to_excel(r".\分词结果.xlsx", index=False)


clean_data()
```

#### 1.4 知识：

##### 1、apply函数可以遍历pandas的Series里的数据进行处理，[参考](https://www.jianshu.com/p/4fdd6eee1b06)

##### 2、结巴分词必须要用 / ".join(seg_list)否则返回一大堆内存地址，seg_list里是一堆内存地址，[参考](https://www.jianshu.com/p/e8b5d01ca073)



#### 1.5 保存清洗结果：

分词结果.xlsx

![image-20200508234229627](.\python-pandas学习.assets\image-20200508234229627.png)



### 2 以内容查找单元格对应行所有信息

假如我现在有这样一个表：

<img src=".\python-pandas学习.assets\image-20200609122614074.png" alt="image-20200609122614074" style="zoom:80%;" />

我想通过fname这个文件名查找它对应的label

```python
def find_label_fname():
    import pandas as pd
    df = pd.read_csv("./predictions.csv")
    search_end = df[df.fname == "00a7a2f6.wav"].values
    print(search_end)

    
find_label_fname()
```

输出：

```bash
[['00a7a2f6.wav' 'Hi-hat Trumpet Clarinet']]
```





### 3 [DataFrame数据创建\更改\插入列行 loc\iloc\at\iat](https://www.cnblogs.com/wodexk/p/10316793.html)

```python
import pandas as pd
df1 = pd.DataFrame([['Snow','M',22],['Tyrion','M',32],['Sansa','F',18],['Arya','F',14]], columns=['name','gender','age'])

print("--------更换单个值----------")
# loc和iloc 可以更换单行、单列、多行、多列的值
df1.loc[0,'age']=25      # 思路：先用loc找到要更改的值，再用赋值（=）的方法实现更换值
df1.iloc[0,2]=25         # iloc：用索引位置来查找

# at 、iat只能更换单个值
df1.at[0,'age']=25      # iat 用来取某个单值,参数只能用数字索引
df1.iat[0,2]=25         # at 用来取某个单值,参数只能用index和columns索引名称
print(df1)
```

dataFrame不能像ndarray那样直接截段赋值。

多处赋值也只能用判断逻辑赋值：[Pandas中使用loc将列表等集合赋值给行或列的每一个元素](https://blog.csdn.net/wj1066/article/details/81510508)

### [4 pandas的read_excel函数遇到sheet中没有表头的字段标签，全部是数据内容，怎么办？](https://segmentfault.com/q/1010000010922967#)

```python
import pandas as pd

df = pd.read_excel(r'.\1.xlsx', header=None)  # header=None读取的excel文件没有表头
```

### 5 保存时去掉表中第一列的索引

index=False去掉首列索引

```python
df[bool].to_csv('./filter_data_science_class.csv', encoding='gbk', index=False)  # excel默认gbk编码
```

### 6 lambda对某列中的所有数据进行操作

设置某列所有数据保留两位小数

```python
data[u'线损率'] = data[u'线损率'].apply(lambda x: format(x, '.2%'))
```

### [7 解决pandas读excel中长数字变成科学计数法的问题](https://blog.csdn.net/haley_yuen/article/details/107655986)

```python
import pandas as pd
data_path = r"C:\Users\Haley\Desktop\order.xlsx"
'''在读取时加上converter参数，先转成str再读'''
data = pd.read_excel(data_path, converters={'订单编号':str})
data.head()
```

### [8 pandas处理成组日期](https://blog.csdn.net/LY_ysys629/article/details/73822716)

pandas通常用于处理成组日期，不管这些日期是DataFrame的轴索引还是列，to_datetime方法可以解析多种不同的日期表示形式。

```python
import pandas as pd
print(date)  #['2017-6-26', '2017-6-27']
df = pd.to_datetime(date)
print(df)
# DatetimeIndex(['2017-06-26', '2017-06-27'], dtype='datetime64[ns]', freq=None)

```

### [9 读取数据后重新起列名](https://zhuanlan.zhihu.com/p/44503744)

```python
df_example = pd.read_csv('Pandas_example_read.csv', names=['A', 'B','C']) # 重起列名A,B,C
# 或者 
df_example = pd.read_csv('Pandas_example_read.csv', header=0, names=['A', 'B','C'])
```

### [10 pandas筛选的与或非](https://geektutu.com/post/pandas-select-data.html)

翻墙访问

- 单价大于等于200且数量大于1的记录（&表示与，|表示或，~表示非）

```python
df[(df['单价'] >= 200) & (df['数量'] >= 2)]
"""
                       日期   单价  数量
编号                                
T002  2018-03-02 13:04:05  200   3
T004  2018-03-04 20:34:05  400   2
"""
```