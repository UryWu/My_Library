@[TOC](目录)

# 一、pandas

## **1、读取数据**

Tushare中文文档

[http://www.waditu.cn/trading.html](http://www.waditu.cn/trading.html#id8)

Python tushare包使用方法（get_hist_data()的参数、返回值，讲解这个函数的文档）

https://blog.csdn.net/weixin_39215630/article/details/82943924

Pandas数据结构：5种Dataframe创建方式

https://zhuanlan.zhihu.com/p/37856914

pandas 数据索引与选取（非常适合入门，讲了:df[]、df.loc[]、df.iloc[]、df.ix[]、df.at[]、df.iat[]）

https://www.cnblogs.com/hhh5460/p/5595616.html

湖南财务大数据比赛代码2018-12-20（有pd.concat、pd.sort_values、pd.to_csv、画折线图、柱状图操作）

https://blog.csdn.net/weixin_39215630/article/details/85221044

Python pandas DataFrame基础操作，参考价值小

https://www.cnblogs.com/huahuayu/p/8227494.html

pandas读取csv文件的操作

https://blog.csdn.net/bin_1022/article/details/83413470

### bug1:

使用pandas读取csv文件，总是出现这样的问题：

```python
labels = pd.read_csv("SketchRecognition/recognition/models/345/5000/labels.csv")
print(labels)
```

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

![img](.\pandas-财务大数据（已同步csdn）.assets\20200428101956339.png)

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)



第一行数据变成了表头：0和sailboat，而表格原来的数据为：

![img](.\pandas-财务大数据（已同步csdn）.assets\20200428102023572.png)

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

所以需要添加pandas.read_csv的参数header=None

```python
labels = pd.read_csv("SketchRecognition/recognition/models/345/5000/labels.csv", header=None)
print(labels)
```

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

![img](.\pandas-财务大数据（已同步csdn）.assets\2020042810210630.png)

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)



## **2、SQL-pandas**

csv_data = pd.read_csv("./stock_day.csv")

Comparison with SQL 像用SQL一样用pandas

https://pandas.pydata.org/pandas-docs/stable/getting_started/comparison/comparison_with_sql.html

pandas 中dataframe 中的模糊匹配 与pyspark dataframe 中的模糊匹配

https://mp.csdn.net/postedit/102674496

Pandas 过滤dataframe中包含特定字符串的数据

https://blog.csdn.net/yyhhlancelot/article/details/82228803

## **3、取行、列**

[关于python中loc和iloc方法](https://www.cnblogs.com/soloveu/p/10049096.html)

pandas 获取Dataframe元素值的几种方法包括iloc、loc、at、iat

https://blog.csdn.net/sinat_29675423/article/details/87975489

dataframe类似sql的用法：Pandas 中根据列值，选取DataFrame数据，并获取行索引号列表

https://blog.csdn.net/huang_susan/article/details/80626698

## **4、统计**

Pandas---汇总和频数统计：统计个数count、groupby、describe()

https://blog.csdn.net/wendaomudong_l2d4/article/details/83039724

## **5、python-SQL-pandas连接表**

Pandas 合并多个Dataframe(merge,concat)的方法（merge如同sql表的连接，merge一次只连接两个表）

https://www.jb51.net/article/141672.htm

Pandas 表连接（Merge，join，concatenate）

https://blog.csdn.net/claroja/article/details/71023167

## **6、插入**

dataframe插入列

https://blog.csdn.net/ysh55024/article/details/81389410

## **7、赋值**

Pandas新增一列并按条件赋值？但是dataFrame.apply需要的的dataFrame.x1通过列名取列方法用不了

https://www.zhihu.com/question/277824046

## **8、值替换**

pandas小技巧之--值替换

https://blog.csdn.net/weixin_37536446/article/details/81266273

python-用字典值替换Pandas Dataframe中的部分字:

http://www.cocoachina.com/articles/90883

https://jingyan.baidu.com/article/454316ab4d0e64f7a6c03a41.html

```python
df1['末端配送模式'].replace(ways_dict,  inplace=True)  # 用字典替换要用inplace=True
# 这里的ways_dict是我的一个字典
```

## 9、Pandas日期数据处理：如何按日期筛选、显示及统计数据：

来源：https://www.cnblogs.com/lemonbit/p/6896499.html

1.按周、月、年统计求和，页面中搜索：按日期统计后，按年或季度或月份显示：

print(df.resample('M').sum())  # 按日期统计后，按月份显示

2.日期截取（页面中搜索：'2016':'2017'、tuncat）:

print(df['2016':'2017'].head(2)) # 获取2016至2017年的数据

print(df.truncate(after = '2013-11'))



3.过滤出月末数据：

```python
def fliter_end_of_month_fromxls():
    # 对从大数据实训平台上查询到的2014-2018年的月末收盘价数据进行清洗，留下月末收盘价
    df = pd.read_excel("./data/深证综指（399106）201911200124278806.xls")
    # print(df.iloc[0, 0])  # df.iloc[行号，列号] 从零开始

    df.columns = ['date', 'close']  # 更换行号，不然我下面无法写列名来取数据
    df['date'] = pd.to_datetime(df['date'])  # 将数据类型转换成日期类型

    df = df.set_index('date')  # 将日期设为索引
    end_of_month_list = []
    for i in range(2014, 2019):
        for j in range(1, 13):
            end_of_month = str(df['{0}-{1}'.format(i, j)].index.max())[0:10]
            # print(end_of_month)  # 求已有的数据中每月最后一天，不是月末。
            end_of_month_list.append(end_of_month)

    print(end_of_month_list)
    df_sum = df[end_of_month_list[0]]
    for i in end_of_month_list[1:]:
        df_sum = pd.concat([df_sum, df[i]])
    print(df_sum)
    print(df_sum.reindex(index=df_sum.index[::-1]))  # 将数据反转输出
```

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

## **10、pandas.DataFrame反转输出：**

```
data.reindex(index=data.index[::-1])
```

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

或简单：

```
data.iloc[::-1]
```

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

将反转你的数据框架，如果你想有一个for循环从下到上你可以做：

```
for idx in reversed(data.index):
    print(idx, data.loc[idx, 'Even'], data.loc[idx, 'Odd'])
```

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

要么

```
for idx in reversed(data.index):
    print(idx, data.Even[idx], data.Odd[idx])
```

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

# **正则表达式：**

菜鸟教程:

https://www.runoob.com/regexp/regexp-syntax.html

史上最全常用正则表达式大全

https://www.cnblogs.com/fozero/p/7868687.html

- 在使用之前，确保已经打开正则表达式选项（菜单Search → Enable Regex）
- | 竖线表示或。例如：gray|grey 能够匹配 gray或grey（注：在|两侧没有空格）。
- () 小括号用于确定范围。例如：gr(a|e)表示在gr和y之间有一个字母a或e。gr(a|e)y将匹配gray或grey，与gray|grey意义相同。
- ? 问号表示其前一个字符可能出现，也有可能不出现。例如：colou?r将匹配color和colour。
- \* 星号表示其前一个字符可能不出现，也可能出现一次或多次。例如：ab*c将匹配ac、abc、abbc、abbbc等等。
- \+ 加号表示其前一个字符出现一次或多次。例如：ab+c将匹配abc、abbc、abbbc等等，但不能匹配ac。
- . 点号可用匹配任何单个非新行字符。（事实上，把哪个字符称之为新行却是不一定的，可能是编码特别或位置特别，但是可以肯定的是这个行中一定包含其他字符。）在POSIX括号表达式规则中，点号只匹配一个点。例如：a.c可以匹配abc等等字符，但是[a.c]只匹配a、.、或c。
- [ ] 中括号表示能够匹配其括号内出现的一个字符。例如：[abc]能够匹配a、b或c。[a-z]将能够匹配a到z之间的任意一个字符。[abcx-z]能够匹配a、b、c、x、y或z，其也可以表示成[a-cx-z]。
- [^ ] [^ ]表示可以匹配任何一个没有出现在其括号内的字符，与[ ]刚好相反。例如：[^abc]能够匹配任何一个不是a、b、c的字符。[^a-z]能够匹配任何一个非小写字母之外的字符。
- ^ 匹配名称开始的位置。在以行为基础的工具中，匹配任意行的开始位置。
- $ 匹配名称结束的位置，或者匹配字符串结尾新行的结束位置。在以行为基础的工具中，匹配任意行的结束位置。
- {m,n} {m,n}表示其前面的字符至少重复m次，但是重复次数少于n。例如：a{3,5}匹配aaa、aaaa以及aaaaa，但是不能匹配aa或aaaaaa。此表达规则在一些老的版本中不可用。

# 二、代码实例

study_tushre.py:

```python
import tushare as ts
import pandas as pd
# print(ts.__version__)
# ts.sz_margins(start='2015-01-01', end='2015-04-19')
# df = ts.profit_data(top=60)
# df.sort_values('shares',ascending=False)
 
def get_stock_scope():
    #财经数据接口tushure官方网站：http://www.waditu.cn/
    stock1 = ts.get_hist_data('600001', '1995-01-01', '2018-13-31', ktype='M')
    # ktype= [D是日末，W是周末，M是月末，15=15分钟 30=30分钟 60=60分钟，默认为D]
    # 取股票代码为600001从'1995-01-01', '2018-13-31'的股票指数
 
    # print(stock1.sort_values(axis = 0,ascending = True,by=['date'])) #axis=0表示按列排序
    # print(stock1['date'])
    # sh = pd.concat( [stock1['close'] ,stock1['open']],axis=1)  # axis=0为在行上扩展，都放在一行里，axis=1在列上扩展，放为两列
    sh = stock1[['close', 'open']]  # 这里无法获取股票的date，但实际上它有date数据，所以只能先存入.csv然后再读取，sh.columns赋给他date列
 
    sh.to_csv("./data/上证收盘.csv")
    sh = pd.read_csv("./data/上证收盘.csv")
    sh.columns = ['date', 'close', 'open']
 
    # print(str(sh['date']).split("-")[1])
    print(sh[(sh['close'] >= 10) & (sh['open'] >= 9)])
    # print(sh[str(['date']) == '2018-12-31'])
 
def test3():
    # 模糊表达式匹配来源：https://blog.csdn.net/yyhhlancelot/article/details/82228803
 
    stock1 = ts.get_hist_data('399001', '1995-01-01', '2018-13-31', ktype='M')
    sh = stock1[['close']]
    sh.to_csv("./data/深证收盘.csv")
    sh = pd.read_csv("./data/深证收盘.csv")
    sh.columns = ['date', 'close']
    bool = sh['date'].str.contains(r'[0-9]{4,}-12?-[0-9]{2,}')  # 不要忘记正则表达式的写法，'.'在里面要用'\.'表示
    print('bool : \n', bool)
 
    # print(sh[(sh['date'] == '')])
    # print(sh[sh['date'] >= 10])
 
    print(sh[bool])
    sh[bool].to_csv('./data/深证年末_第三题.csv')
 
 
def test4():
    # 模糊表达式匹配来源：https://blog.csdn.net/yyhhlancelot/article/details/82228803
 
    stock2 = ts.get_hist_data('000001', '1995-01-01', '2018-13-31', ktype='M')
    sh2 = stock2[['close']]
    sh2.to_csv("./data/上证收盘.csv")
    sh2 = pd.read_csv("./data/上证收盘.csv")
    sh2.columns = ['date', 'close']
    bool2 = sh2['date'].str.contains(r'[0-9]{4,}-12?-[0-9]{2,}')
    # 不要忘记正则表达式的写法，'.'在里面要用'\.'表示，这里是取所有年份的12月的数据，?匹配一次以上，+匹配0次以上
 
    print('bool2 : \n', bool2)
    # print(sh[(sh['date'] == '')])
    # print(sh[sh['date'] >= 10])
    print(sh2[bool2])
    sh2[bool2].to_csv('./data/上证年末_第三题.csv')
 
 
def test():
    stock1 = ts.get_hist_data('600001', '1995-01-01', '2018-13-31', ktype='M')
    df = stock1[['close', 'open']]
    df.to_csv("./data/test.csv")
    # print(ts.get_realtime_quotes('sh'))
 
 
def fliter_end_of_month():
    # 2019年11月20日第三题取深证综指的2014-2018年的月末收盘价数据，但是数值小数点和大数据实训平台的不一样，错误
    df = ts.get_hist_data('399106', '2013-12-32', '2018-12-31', ktype='M')
    df1 = df[['close']]
    df1.to_csv("./data/深证综指月末收盘价tushare.csv")
    df1 = pd.read_csv("./data/深证综指月末收盘价tushare.csv")
    df1.columns = ['date', 'close']
    print(df1)
    df1.to_csv("./data/深证综指月末收盘价tushare.csv")
 
 
def fliter_end_of_month_fromxls():
    # 对从大数据实训平台上查询到的2014-2018年的月末收盘价数据进行清洗，留下月末收盘价
    df = pd.read_excel("./data/深证综指（399106）201911200124278806.xls")
 
    # print(df.iloc[0, 0])  # df.iloc[行号，列号] 从零开始
 
    df.columns = ['date', 'close']  # 更换行号，不然我下面无法写列名来取数据
    df['date'] = pd.to_datetime(df['date'])  # 将数据类型转换成日期类型
 
    df = df.set_index('date')  # 将日期设为索引
    end_of_month_list = []
    for i in range(2014, 2019):
        for j in range(1, 13):
            end_of_month = str(df['{0}-{1}'.format(i, j)].index.max())[0:10]
            # print(end_of_month)  # 求已有的数据中每月最后一天，不是月末。
            end_of_month_list.append(end_of_month)
 
    print(end_of_month_list)
    df_sum = df[end_of_month_list[0]]
    for i in end_of_month_list[1:]:
        df_sum = pd.concat([df_sum, df[i]])
    print(df_sum)
    print(df_sum.reindex(index=df_sum.index[::-1]))  # 将数据反转输出
 
    # print(df.resample('M').sum())  # 按月度统计求和并显示
    # print(df['2014-12'])  # 显示2014年12月的所有数据
    # python新增一列：https://www.zhihu.com/question/277824046
    # df['day'] = df.apply(lambda x: x.date.split("-")[2])
 
def get_month_close():
    # 华泰证券12题
    xian_tourism = ts.get_k_data(code='002033', ktype='M', start='2015-0-0', end='2017-12-31', autype='hfq')  #hfq后复权
    date_close = xian_tourism[['date', 'close']]
    print(date_close.reindex(index=date_close.index[::-1]))  # 将数据反转输出
 
def get_data_and_reverse():
    # 华泰证券12题
    df = pd.read_excel('C:/Users/Admin/Downloads/上证综指000001201911231952573857.xls')
    df = df.reindex(index=df.index[::-1])  # 将数据反转输出
    df.to_csv('C:/Users/Admin/Downloads/上证综指000001201911231952573858.csv')
 
def shen_yang_close():
    # 沈阳新松机器人自动化股份有限公司,第二题：请运用tushare包收集公司2018年12月28日年末无复权收盘价（接口：get_k_data）。
    # df = ts.get_k_data('300024', ktype='M', start='2018-12-1', end='2019-2-1', autype=None)
    # print(df)
 
    # 沈阳新松机器人自动化股份有限公司,第八题：请运用tushare包收集机器人2013-2018年的年末无复权收盘价（接口：get_k_data）并计算2014-2018年每年的涨跌幅。
    df = ts.get_k_data('300024', ktype='M', start='2013-12-1', end='2018-12-31', autype=None)
    df1 = df[["date", "close"]]
 
    get_end_of_year_close_from_DataFrame(df1)
    # df.to_csv("./data/沈阳新松机器人自动化股份有限公司.csv")
 
 
def get_end_of_year_close_from_DataFrame(df):  # 取DataFrame里的年末数据
    # df.to_csv("./data/沈阳新松机器人自动化股份有限公司.csv")
    # # df = pd.read_csv("./data/沈阳新松机器人自动化股份有限公司.csv")
    df = df[['date', 'close']]
    df.columns = ['date', 'close']  # 更换行号，不然我下面无法写列名来取数据
    df['date'] = pd.to_datetime(df['date'])  # 将数据类型转换成日期类型
 
    df = df.set_index('date')  # 将日期设为索引
 
    end_of_month_list = []
    for i in range(2013, 2019):
        j = 12
        end_of_month = str(df['{0}-{1}'.format(i, j)].index.max())[0:10]
        # print(end_of_month)  # 求已有的数据中每月最后一天，不是月末。
        end_of_month_list.append(end_of_month)
 
    print("end_of_month_list:", end_of_month_list)
 
    # loc()参考来源：https://www.cnblogs.com/hhh5460/p/5595616.html
    print(df.loc[end_of_month_list[0], 'close'])  # 取索引为2013-12-31，列名为close的单元格，它的返回值为series，无法to_csv，
 
    # df_sum = df.loc[end_of_month_list[0]].to_frame()  # 使用to_frame()把series转换成dataframe
 
    data = []
    for i in end_of_month_list:
        data.append(df.loc[i, 'close'])
 
    df_sum = pd.DataFrame({'date':end_of_month_list, 'close':data})
    print(df_sum)
    print(df_sum.reindex(index=df_sum.index[::-1]))  # 将数据反转输出
 
 
def stock_ups_and_downs_percent():
    # 2014涨跌幅：
    a = [1304.44, 1471.76, 2714.05, 1962.06, 1752.65, 1250.53]
    a = [48.7, 39.39, 68.50, 21.38, 18.82, 13.22]
    for i in range(5):
        percent = (a[i+1]-a[i])/a[i]
        print("{:.5}".format(percent))
 
 
# test3()
# get_stock_scope()d
# test4()
# test()
# fliter_end_of_month()
# fliter_end_of_month_fromxls()
# get_month_close()
# get_data_and_reverse()
shen_yang_close()
# stock_ups_and_downs_percent()
 
'''
ERROR1'DataFrame' object has no attribute 'sort'
solution:https://blog.csdn.net/weixin_39777626/article/details/78760076
解决：将“sort”改为“sort_values”
ERROR2:用tushare从网上搞的股票数据小数点会和那个大数据中心的不一样，会出错，所以要先从大数据实训平台搞出数据，
然后再用pandas清洗
'''
```

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

bp1.py

```python
import pandas as pd
import numpy as np
# 数据来源：https://tianchi.aliyun.com/dataset/dataDetail?dataId=46
# behavior_type: Including click, collect,add-to-cart and payment, the corresponding values are 1, 2, 3 and 4,respectively.
 
df = pd.read_csv("./data/tianchi_mobile_recommend_train_user.csv")
df = df[["user_id", "item_id", "behavior_type"]]  # 将需要用的数据提取出来
df_addClick = df[df["behavior_type"] == 1].groupby(by=["user_id", "item_id"], as_index=False).count()
# 如同sql语句: select user_id, item_id, count(*) from data1 where behavior_type == 1
# group参数as_index=False加了就是把原来的'behavior_type'作为统计数据数量的那一列的标签，不然根本无法取统计结果
 
df_addClick.columns = ['user_id', 'item_id', 'count_click']  # 将原来的第三列统计数据的名字改为更准确的count_click
 
df_collect = df[df['behavior_type'] == 2]
df_collect.columns = ['user_id', 'item_id', 'collect']
# print(df_collect)
# input()
df_add_to_cart = df[df['behavior_type'] == 3]
df_add_to_cart = df[df['behavior_type'] == 3]
df_add_to_cart.columns = ['user_id', 'item_id', 'add_to_cart']
 
df_payment = df[df['behavior_type'] == 4]
df_payment.columns = ['user_id', 'item_id', 'payment']
 
df_result = pd.merge(df_addClick, df_collect, how='left', on=['user_id', 'item_id'])
df_result = pd.merge(df_result, df_add_to_cart, how='left', on=['user_id', 'item_id'])
df_result = pd.merge(df_result, df_payment, how='left', on=['user_id', 'item_id'])
 
# 把四个表连接起来
 
# df_addClick['collect'] = np.where((df['user_id'] == df_addClick['user_id'].squeeze()) and (df['item_id'] == df_addClick['item_id'].squeeze()), df['behavior_type'], 0)
 
# df_addClick_Collect = df_addClick
df_result.to_csv("./data/result1.csv")
 
# print(df_addBrowse['count_browse'])
# print(df[df["behavior_type"] == 4])
 
```

![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

# 三、附录：

1.看清题目的需求，注意是要.to_csv还是、to_excel

2.比赛的时候检查场地的电脑有没有这八个包：

1).pandas 2).tushare 3).lxml 4).xlwt 5).requests 6).bs4 7).xlrd 8).openpyxl

3.云实训平台：

http://race.yunsx.com