---
number headings: auto, first-level 2, max 6, contents ^toc, start-at 1, 1.1
---


## 1 DFS

### 1.1 什么是八连块？

输入一个n*n的黑白图像（1表示黑色，0表示白色），任务是统计其中八连块的个数。如果两个黑格子有公共边或者公共顶点，就说它们属于同一个八连块。如图表示3个八连块。

10010

00101

10000

11100

10100

此图中有三个八连块。单个黑块也算一个八连块

 

用递归实现DFS：

https://blog.csdn.net/suifengdream/article/details/8292276

 

### 1.2 数量为20的赃物分给2个海盗，每个赃物拥有权重，要求两个海盗获得的赃物的权重相等。分不均的时候可以不分此货物。

用dfs，一个货物有三种情况，所以所有的的情况就是3^20。

```c++
int dp(int id, int sum1, int sum2){
	if(id > n) break;
	dp(id+1, sum1+a[id], sum2);
	dp(id+1, sum1, sum2+a[id]);
	dp(id+1, sum1, sum2);
    
    return ;
}

int main(){
	int a[20] = {0};
	cin>>a[]>>endl;
	dp()
}
```

 

### 1.3 ccsu第八次排位赛C题标准代码DFS

```c
#include<cstdio>
#include<cstring>
#include<algorithm>
using namespace std;
int vis[100],n,a[20][20],ans;
void dfs(int x,int sum)
{
	if(x==n+1)
	{
		ans=max(ans,sum);
		return; 
	}
	for(int i=1;i<=n;i++)
	{
		if(!vis[i])
		{
			vis[i]=1;
			dfs(x+1,sum+a[x][i]);
			vis[i]=0;
		}
	}
}
int main()
{
	int T,kase=0;
	scanf("%d",&T);
	while(T--)
	{
		scanf("%d",&n);
		for(int i=1;i<=n;i++)
		for(int j=1;j<=n;j++)
		scanf("%d",&a[i][j]);
		ans=0;
		memset(vis,0,sizeof(vis));
		dfs(1,0);
		printf("Case #%d: %d\n",++kase,ans);
	}
}

```



## 2 DP动态规划

### 2.1 [基本思想](https://www.cnblogs.com/steven_oyj/archive/2010/05/22/1741374.html)

把原始问题分解为若干个子问题，然后自底向上，先求解最小的子问题，把结果存在表格中，在求解大的子问题时，直接从表格中查询小的子问题的解，避免重复计算，从而提高算法效率。

**与分治算法的区别：**

动态规划也是一种分治思想（比如其状态转移方程就是一种分治），但与分治算法不同的是，分治算法是把原问题分解为若干个子问题，自顶向下求解子问题，合并子问题的解，从而得到原问题的解。

### 2.2 [适用情况](https://www.cnblogs.com/steven_oyj/archive/2010/05/22/1741374.html)

(1) 最优化原理：如果问题的最优解所包含的子问题的解也是最优的，就称该问题具有最优子结构，即满足最优化原理。

(2) 无后效性：即某阶段状态一旦确定，就不受这个状态以后决策的影响。也就是说，某状态以后的过程不会影响以前的状态，只与当前状态有关。

(3)有重叠子问题：即子问题之间是不独立的，一个子问题在下一阶段决策中可能被多次使用到。（该性质并不是动态规划适用的必要条件，但是如果没有这条性质，动态规划算法同其他算法相比就不具备优势）

### 2.3 P1002 过河卒

#### 2.3.1 暴力搜索

```c++
// https://www.luogu.org/problem/P1002
// 本程序用了搜索的方法从终点开始到达起点，洛谷的题友们建议使用动态规划，因为搜索容易超时，时间复杂度O(2^n) 
#include<bits/stdc++.h>
#include <ctime> 
#define ll long long
using namespace std;
int mx,my;
long long t(int,int);
int main(){
	
    int bx,by;
    cin>>bx>>by>>mx>>my;
    clock_t startTime,endTime;
	startTime = clock();//计时开始
    cout<<t(bx,by);
    endTime = clock();//计时结束
    cout<<"\n"<<(double)(endTime - startTime) / CLOCKS_PER_SEC << "s" << endl;
    return 0;
}
long long t(int x,int y){
    if((x==mx-1&&y==my-2)||(x==mx+1&&y==my-2)||(x==mx-2&&y==my-1)||(x==mx+2&&y==my-1)||(x==mx&&y==my)||(x==mx-2&&y==my+1)||(x==mx+2&&y==my+1)||(x==mx-1&&y==my+2)||(x==mx+1&&y==my+2)){
        return 0;
    }
    else if(x==0&&y==0){
        return 1;//达到一次起点，完成 
    }
    else if(x==0){
        return t(x,y-1);
    }
    else if(y==0){
        return t(x-1,y);
    }
    else{
        ll o;
        o=t(x-1,y)+t(x,y-1);//从这里产生分支 
        return o;
    }
}

```

#### 2.3.2 动态规划

```c++
//过河卒动态规划解法，来源：https://www.luogu.org/discuss/show/132916 
//时间复杂度O(n^2)
#include <iostream>
#include <cstdio>
#include <cstring>
#include <ctime> 
using namespace std;
long long f[1011][1011];
bool b[1011][1011];
int dx[9]={0,1,1,2,2,-1,-1,-2,-2};
int dy[9]={0,2,-2,1,-1,2,-2,1,-1};
long long n,m,x,y;
int main(){ 
    scanf("%lld %lld %lld %lld",&n,&m,&x,&y);
    clock_t startTime,endTime;
	startTime = clock();//计时开始
    for (int i=0; i<=8; ++i)
        if(x+dx[i]>=0 && x+dx[i]<=n && y+dy[i]>=0 && y+dy[i]<=m)
            b[x+dx[i]][y+dy[i]]=1;
    memset(f,0,sizeof(f));
    f[0][0]=1;
    for (int i=0; i<=n; ++i)//dp核心代码 
        for (int j=0; j<=m; ++j)   
        {
            if(!b[i-1][j] && i-1>=0)
                f[i][j]+=f[i-1][j];
            if(!b[i][j-1] && j-1>=0)
                f[i][j]+=f[i][j-1]; 
        }
    printf("%lld",f[n][m]);
    endTime = clock();//计时结束
    cout<<"\n"<<(double)(endTime - startTime) / CLOCKS_PER_SEC << "s" << endl;
    return 0;
}

```

### 2.4 [币值最大化](https://blog.csdn.net/lsdstone/article/details/90246831)

#### 2.4.1 问题描述

- 给定一排n个硬币，其面值均为整数c1, c2, …, cn, 这些整数并不一定两两不同。问如何选择硬币，使得在其原始位置互不相邻的条件下，所选硬币的总金额最大。

#### 2.4.2 解题思路

- 上述最大可选金额用f(n)表示，我们可以将所有可行的选择划分为两组：包括最后一枚硬币的和不包括最后一枚硬币的。第一组中，可选包含最后一枚硬币的，最大金额为Cn+f(n-2)，即最后一枚硬币加上前面n-2枚硬币可选的最大金额。按照f(n)的定义，另一组中可选的最大金额为f(n-1)，即前n-1枚硬币的最大金额。
- 可得出符合初始条件的递推方程：

> f(n)=max{Cn+f(n-2),f(n-1)}
> f(0)=0,f(1)=c1

- 再用回溯的方法得到获取最大值的各个币值

- 用币值大小为5 1 2 10 6 4 的几枚硬币为例子

- 通过上述方程列表：
  ![image-20201028144510289](C:\Users\UryWu\AppData\Roaming\Typora\typora-user-images\image-20201028144510289.png)

- 再通过回溯法得到所选择的硬币

- 分为两种情况，即选择了第n-1个和没选择第n-1个硬币，如果f(n)=f(n-1)则选择了第n-1个反之则没有选择第n-1个。

#### 2.4.3 伪代码

```
coinmax(c[0..n])
c[0] <- 0
f[0] <- 0
f[1] <- c[1]
for i <- 2 to n
	f[i] <- max(c[i] + f[i-2], f[i-1])
return f[n]
```

时间复杂度O(n)

#### 2.4.4 代码如下

```c
// a币值最大化.cpp : 定义控制台应用程序的入口点。
#include "stdafx.h"
#include"math.h"

#define max(x,y)  (x>y)?x:y
#define MAX 20
int c[MAX];//代表价值
int f[MAX];

int coinmax(int n)
{
    c[0] = 0;//初始化c[0]及f[0]
    f[0] = 0;
    f[1] = c[1];

    for(int i = 2; i <= n; i++)
    {
        f[i] = max(c[i] + f[i - 2], f[i - 1]);
        //获取最大币值
    }
    return f[n];
}


int main()
{
    int n;
    printf("请输入有多少个纸币：");
    scanf("%d", &n);
    printf("请分别输入纸币的价值：");
    for (int i = 1; i <= n; i++)
    {
        scanf("%d", &c[i]);
    }
    int arr[MAX];//定义arr数组表示所选择的硬币
    int num = 0;
    printf("最大币值为：%d\n", coinmax(n));
    for (int i = n; i >= 1; i--)
    {
        if (f[i] == f[i - 1])//选择了第i-1个，然后再将第i-1个放进arr数组
        {
            arr[num++] = c[--i];
        }
        else{
            arr[num++] = c[i--];//没有选择第i-1个则将他本身先放入数组，
            //然后再将数组c的下标减一，arr的下标加一
        }
    }
    printf("各个币值为：");
    for (int i = 0; i<num; i++)
        printf("%d ", arr[i]);
}

```

- 运行结果如下：

  ![image-20201028144524597](C:\Users\UryWu\AppData\Roaming\Typora\typora-user-images\image-20201028144524597.png)

  
### 2.5 硬币找零问题

#### 2.5.1 问题描述

如果我们有面值为1元、3元和5元的硬币若干枚，如何用最少的硬币凑够11元？

#### 2.5.2 [思路分析](https://blog.csdn.net/wdxin1322/article/details/9501163)

#### 2.5.3 伪代码

```c++
coin_check(money[0..m], sum, count[0..n])//sum要找零多少钱
count[0] <- 0//当前所需币数
for j <- 1 to sum do//总金额数，1,2,3，……，sum
	minCoins <- j//将一块钱一块钱这种能解决所有问题的凑法来作为最差凑法
	for i <- 0 to length(money) do//遍历硬币的面值
		if j - money[i] >= 0
			temp <- count[j - money[i]] + 1//当前所需硬币数
			if temp < minCoins
				minCoins <- temp
	count[j] <- minCoins//如果没有更好的方法就是用一块钱一块钱来凑
return count[sum]
```

时间复杂度O(mn)



#### 2.5.4 [java、python代码](https://cloud.tencent.com/developer/article/1019576)

```java
package com.algorithm.dynamicprogramming;

import java.util.Arrays;

/**
 * 找零问题
 * Created by yulinfeng on 7/5/17.
 */
public class Money {
    public static void main(String[] args) {
        int[] money = {1, 3, 2, 5};
        int sum = 8;
        int count = money(money, sum);
        System.out.println(count);
    }

    private static int money(int[] money, int sum) {
        int[] count = new int[sum + 1];
        count[0] = 0;
        for (int j = 1; j < sum + 1; j++) {//总金额数，1,2,3，……，sum
            int minCoins = j;
            for (int i = 0; i < money.length; i++) {//遍历硬币的面值
                if (j - money[i] >= 0) {
                    int temp = count[j - money[i]] + 1;//当前所需硬币数
                    if (temp < minCoins) {
                        minCoins = temp;
                    }
                }
            }
            count[j] = minCoins;
        }
        System.out.println(Arrays.toString(count));
        return count[sum];
    }
}
```

### 2.6 Warshall-求图闭包

#### 2.6.1 [C++实现](https://blog.csdn.net/qq_15981815/article/details/40051491?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-5.channel_param&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-5.channel_param)

```c++
#include "iostream"
#ifndef MAXSIZE
#define MAXSIZE 1000
#endif
using namespace std;
int matrix[MAXSIZE][MAXSIZE];
int size;
void getT(){
	cout<<"Input the element amounts:";
	cin>>size;
	cout<<"Input the matrix:"<<endl;
	for (int i=0;i<size;i++){
		for (int j=0;j<size;j++){
			cin>>matrix[i][j];
		}
	}
		for (int i=0;i<size;i++){
			for(int j=0;j<size;j++){
				if(matrix[i][j]==1)
				for(int k=0;k<size;k++){
					if(matrix[k][i])matrix[k][j]=1;
			}
		}
	}
}
int main(int argc, char const *argv[]){
	getT();
	cout<<endl<<"Result:"<<endl;
	for (int i=0;i<size;i++){
		for (int j=0;j<size;j++){
			cout<<matrix[i][j]<<" ";
		}
		cout<<endl;
	}
}
```



#### 2.6.2 伪代码

```c
Warshall(A[1..n, 1..n])
//实现计算传递闭包的Warshall算法
//输入：包括有n个顶点有向图的邻接矩阵A
//输出：该有向图的传递闭包
R(0) <- A
for k <- 1 to n do
	for i <- 1 to n do
		for j <- 1 to n do
			R(k)[i, j] <- R(k-1)[i, j] or R(k-1)[i, k] and R(k-1)[k, j]
return R(n)
```



### 2.7 Floyd-图最短路

[傻子也能看懂的弗洛伊德算法](https://blog.csdn.net/qq_34374664/article/details/52261672)
[最短路径问题---Floyd算法详解](https://blog.csdn.net/qq_35644234/article/details/60875818)

#### 2.7.1 C++实现

```c++
/*可以在这里找测试数据 ： 
**https://blog.csdn.net/qq_34374664/article/details/52261672
**https://blog.csdn.net/qq_35644234/article/details/60875818
*/
#include<cstdio>
#include<iostream>
#include<iomanip>
#define infinite 999999

using namespace std;
main()
{
	int point,line,direction;
	cout<<"无向图输入0，有向图输入1："<<endl;
	cin>>direction;
	cout<<"请输入点的个数和路线的个数："<<endl;
	cin>>point>>line;//点的个数和路线的个数
	int a[point+1][point+1];
	for(int i=1;i<=point;i++)//初始化矩阵 
		for(int j=1;j<=point;j++)
		{
			if(i==j)	a[i][j]=0;
			else a[i][j]=infinite;
		} 
	cout<<"输入图的矩阵：（例“1 2 3”从1点到2点的路程为3）"<<endl;
	int i,j;
	while(line--)//路径条数 
	{
		cin>>i>>j;
		cin>>a[i][j];
		if(direction==0)a[j][i]=a[i][j];
	}
	
	
	//Floyd核心代码 
	for(int k=1;k<=point;k++)
		for(int i=1;i<=point;i++)
			for(int j=1;j<=point;j++)
				if(a[i][j]>a[i][k]+a[k][j])
					a[i][j]=a[i][k]+a[k][j];
	
	//输出最短路径图的矩阵 
	cout<<"最短路径图的矩阵："<<endl;
	cout<<setw(6)<<" ";
	for(int i=1;i<=point;i++)
		cout<<"至点"<<i<<" ";
	cout<<endl;
	for(int i=1;i<=point;i++)
	{	
		cout<<"从点"<<i; 
		for(int j=1;j<=point;j++)
		{
			if(a[i][j]==infinite) cout<<setw(6)<<"∞";//if(a[i][j]==infinite) cout<<std::left<<setw(4)<<"∞";左对齐 
			else	cout<<setw(6)<<a[i][j];
		}
		
		cout<<endl;
		system("pause");
	}
 } 

```

#### 2.7.2 伪代码

```c
Floyd(W[1..n, 1..n])
//实现计算完全最短路径的Floyd算法
//输入：不包含长度为负的回路的图的权重矩阵w
//输出：包含最短路径长度的距离矩阵
D <- w //如果可以改写W，可省略此步
for k <- 1 to n do
	for i <- 1 to n do
		for j <- 1 to n do
			D[i, j] <- min{D[i, j], D[i, k] + D[k, j]}
return D
```

时间复杂度O(n^3)

### 2.8 [切割木棍问题——动态规划](https://blog.csdn.net/Jammg/article/details/51589662)

```c++
#include <iostream>
#include<cmath>
#include<iomanip>
//#include<vector>
#define _USE_MATH_DEFINES
#define pi acos(-1)
using namespace std;

//【算法学习】切割木棍问题——动态规划
//https://blog.csdn.net/Jammg/article/details/51589662
int Cut_Common(int seg[], int price[], int arr_len, int source_len){
    if (source_len == 0)
        return 0;
	int tmp = -1;
	for (int i = 0; i < arr_len; ++i)
	{
        if (source_len - seg[i] >= 0)
		    tmp = max(tmp, price[i] + Cut_Common(seg, price, arr_len, source_len - seg[i]));
	}
	return tmp;
}


int main(){


    int seg[] = {1,2,3,4,5,6,7,8,9,10};
    int price[] = {1,5,8,9,10,17,17,20,24,30};
    int arr_len = 9;
    int source_len = 20;
    int value = Cut_Common(seg, price, arr_len, source_len);
    cout<<value<<endl;

    return 0;
}
```



## 3 排序算法网址

### 3.1 [学会写伪代码](https://www.cnblogs.com/linuxAndMcu/p/11242905.html)

### 3.2 选择排序-暴力枚举

#### 3.2.1 伪代码

```vhdl
for i <- 0 to list.length-1 do
	min = i
    for j <- i+1 to list.length do
    	if list[j] < list[min]	min = j
	if i != min		swap(list[min],list[i])

```

#### 3.2.2 [C实现](http://c.biancheng.net/cpp/html/2442.html)

[选择排序](https://www.cnblogs.com/aoguren/p/3292895.html)

#### 3.2.3 [时间复杂度分析](https://blog.csdn.net/shengqianfeng/article/details/100023372)

### 3.3 冒泡排序-暴力枚举

#### 3.3.1 伪代码

```pascal
for i <- 0 to list.length-1 do 
	for j <- 0 to list.length-1-i do
	if list[j]>list[j+1]
        then temp = list[j+1]
        list[j+1] = list[j]
        list[j] = temp
	end
end
```

#### 3.3.2 [C实现](http://c.biancheng.net/cpp/html/2443.html)

[冒泡排序](https://blog.csdn.net/u012864854/article/details/79404463)

#### 3.3.3 [时空复杂度分析](https://blog.csdn.net/YuZhiHui_No1/article/details/44339711)



### 3.4 插入排序-减治法

#### 3.4.1 伪代码

```pascal
for i <- 1 to list.length do
	val <- list[i]
	j <- i-1
	while j>=0 && list[i]>val do
		list[j+1] <- list[j]
		j <- j-1
		end
	list[j+1] = val
end
```

#### 3.4.2 C++实现

```c++
void insertSort(int arr[], int N){
        for (int i = 1; i < N; i++) {
            int val = arr[i];
            int j = i - 1;
            while (j >= 0 && arr[j] > val){
                arr[j + 1] = arr[j];
                j--;
            }
            arr[j + 1] = val;
        }
}
```

#### 3.4.3 时间效率分析

在最坏情况下，数组完全逆序，插入第2个元素时要考察前1个元素，插入第3个元素时，要考虑前2个元素，……，插入第N个元素，要考虑前N - 1个元素。因此，最坏情况下的比较次数是1 + 2 + 3 + ... + (N - 1)，等差数列求和，结果为N^2 / 2，所以最坏情况下的复杂度为O(N^2)。

最好情况下，数组已经是有序的，每插入一个元素，只需要考查前一个元素，因此最好情况下，插入排序的时间复杂度为O(N) ,而冒泡排序需要O(n^2)次交换。

### 3.5 [分治法适用情况](https://www.cnblogs.com/steven_oyj/archive/2010/05/22/1741370.html)

1) 该问题的规模缩小到一定的程度就可以容易地解决

2) 该问题可以分解为若干个规模较小的相同问题，即该问题具有最优子结构性质。

3) 利用该问题分解出的子问题的解可以合并为该问题的解；

4) 该问题所分解出的各个子问题是相互独立的，即子问题之间不包含公共的子子问题。

第一条特征是绝大多数问题都可以满足的，因为问题的计算复杂性一般是随着问题规模的增加而增加；

**第二条特征是应用分治法的前提**它也是大多数问题可以满足的，此特征反映了递归思想的应用；

**第三条特征是关键，能否利用分治法完全取决于问题是否具有第三条特征**，如果**具备了第一条和第二条特征，而不具备第三条特征，则可以考虑用贪心法或动态规划法**。

**第四条特征涉及到分治法的效率**，如果各子问题是不独立的则分治法要做许多不必要的工作，重复地解公共的子问题，此时虽然可用分治法，但**一般用动态规划法较好**。

### 3.6 [归并排序-分治法](https://blog.csdn.net/a130737/article/details/38228369)

#### 3.6.1 伪代码

```c++
Merge(B[0,..,p-1], C[0,..,q-1], A[0,..,p+q-1])
//将两个有序数组合并为一个有序数组
//输入：两个有序数组B[0,..,p-1]和C[0,..,q-1]
//输出：A[0,..,p+q-1]中已经有序存放了B和C中的元素
i<-0;j<-0;k<-0;
while i<p and j<q do
	if B[i]<=C[j]
		A[k]<-B[j];i<-i+1
	else A[k]<-C[j];j<-j+1
	k<-k+1
if i=p
	copy C[j,..,q-1] to A[k,..,p+q-1]
else copy B[i,..,p-1] to A[k,..,p+q-1]


Mergesort(A[0,..,n-1])
//递归调用mergesort来对数组A[0,..,n-1]排序
//输入：一个可排序数组A[0,..,n-1]
//输出：非降序排列的数组A[0,..,n-1]
if n>1
	copy A[0,..,[n/2]-1] to B[0,..,[n/2]-1]
	copy A[[n/2],..,n-1] to C[0,..,[n/2]-1]
	Mergesort(B[0,..,[n/2]-1])
	Mergesort(C[0,..,[n/2]-1])
	Merge(B,C,A)
```



#### 3.6.2 [C++实现](https://blog.csdn.net/a130737/article/details/38228369)

```C++
/* Merge sort in C++ */
#include <cstdio>
#include <iostream>
 
using namespace std;
 
// Function to Merge Arrays L and R into A.
// lefCount = number of elements in L
// rightCount = number of elements in R.
void Merge(int *A,int *L,int leftCount,int *R,int rightCount) {
	int i,j,k;
 
	// i - to mark the index of left aubarray (L)
	// j - to mark the index of right sub-raay (R)
	// k - to mark the index of merged subarray (A)
	i = 0; j = 0; k =0;
 
	while(i<leftCount && j< rightCount) {
		if(L[i]  < R[j]) A[k++] = L[i++];
		else A[k++] = R[j++];
	}
	while(i < leftCount) A[k++] = L[i++];
	while(j < rightCount) A[k++] = R[j++];
}
 
// Recursive function to sort an array of integers.
void MergeSort(int *A,int n) {
	int mid,i, *L, *R;
	if(n < 2) return; // base condition. If the array has less than two element, do nothing.
 
	mid = n/2;  // find the mid index.
 
	// create left and right subarrays
	// mid elements (from index 0 till mid-1) should be part of left sub-array
	// and (n-mid) elements (from mid to n-1) will be part of right sub-array
	L = new int[mid];
	R = new int [n - mid];
 
	for(i = 0;i<mid;i++) L[i] = A[i]; // creating left subarray
	for(i = mid;i<n;i++) R[i-mid] = A[i]; // creating right subarray
 
	MergeSort(L,mid);  // sorting the left subarray
	MergeSort(R,n-mid);  // sorting the right subarray
	Merge(A,L,mid,R,n-mid);  // Merging L and R into A as sorted list.
	// the delete operations is very important
	delete [] R;
	delete [] L;
}
 
int main() {
	/* Code to test the MergeSort function. */
 
	int A[] = {6,2,3,1,9,10,15,13,12,17}; // creating an array of integers.
	int i,numberOfElements;
 
	// finding number of elements in array as size of complete array in bytes divided by size of integer in bytes.
	// This won't work if array is passed to the function because array
	// is always passed by reference through a pointer. So sizeOf function will give size of pointer and not the array.
	// Watch this video to understand this concept - http://www.youtube.com/watch?v=CpjVucvAc3g
	numberOfElements = sizeof(A)/sizeof(A[0]);
 
	// Calling merge sort to sort the array.
	MergeSort(A,numberOfElements);
 
	//printing all elements in the array once its sorted.
	for(i = 0;i < numberOfElements;i++)
	   cout << " " << A[i];
	return 0;
}
```

#### 3.6.3 时间效率分析

假设n是2的乘方，键值比较次数：

![image-20201022122445804](C:\Users\UryWu\AppData\Roaming\Typora\typora-user-images\image-20201022122445804.png)

Cmerge(n)就是合并阶段进行键值比较的次数。我们每做一步，都要进行一次比较，比较之后，两个数组中尚未处理的元素总个数-1。在最坏情况下，无论哪个数组都不会为空，除非另一个数组只剩下最后一个元素。最坏情况就是当前最小元素轮流来自于两个数组。因此，对于最坏情况来说，Cmerge(n)=n-1,递推式如下：

![image-20201022122505802](C:\Users\UryWu\AppData\Roaming\Typora\typora-user-images\image-20201022122505802.png)

因此，根据主定理，Cworst(n)∈Θ(nlogn)，若n = 2^k，我们很容易得到最差效率递推式的精确解：

​																			 ![image-20201022122542982](C:\Users\UryWu\AppData\Roaming\Typora\typora-user-images\image-20201022122542982.png)

合并排序在最坏情况下的键值比较次数非常接近排序算法在理论上的最少次数，它的另一个显著优点在于它的稳定性。

### 3.7 快速排序-分治法

#### 3.7.1 伪代码

```c++
Quicksort(A[l..r])
//用Quicksort对子数组排序
//输入：数组A[0..n-1]中的子数组A[l..r]，由左右下标l和r定义
//输出：非降序排序的子数组A[l..r]
if l<r
	s <- Partition(A[l..r])//s是分裂位置
	Quicksort(A[l..s-1])
	Quicksort(A[s+1..r])
```

#### 3.7.2 [C++实现](https://blog.csdn.net/liuchen1206/article/details/6954074)

填坑法讲解

```c++
#include<iostream>
using namespace std;
void quickSort(int a[],int,int);
int main()
{
	int array[]={34,65,12,43,67,5,78,10,3,70}, k;
	int len=sizeof(array)/sizeof(int);
	cout<<"The orginal arrayare:"<<endl;
	for(k=0;k<len;k++)
		cout<<array[k]<<",";
	cout<<endl;
	quickSort(array,0,len-1);
	cout<<"The sorted arrayare:"<<endl;
	for(k=0;k<len;k++)
		cout<<array[k]<<",";
	cout<<endl;
	system("pause");
	return 0;
}

void quickSort(int s[], int l, int r)
{
	if (l < r)
	{      
		int i = l, j = r, x = s[l];
		while (i < j)
		{
			while(i < j && s[j]>= x) // 从右向左找第一个小于x的数
				j--; 
			if(i < j)
				s[i++] = s[j];
			while(i < j && s[i]< x) // 从左向右找第一个大于等于x的数
				i++; 
			if(i < j)
				s[j--] = s[i];
		}
		s[i] = x;
		quickSort(s, l, i - 1); // 递归调用
		quickSort(s, i + 1, r);
	}
}
```

#### 3.7.3 [如何证明快速排序法的平均复杂度为 O(nlogn)？](https://www.zhihu.com/question/22393997)

### 3.8 其它学习链接（有图示）

#### 3.8.1 [十大经典排序算法（动图演示）](https://www.cnblogs.com/onepixel/p/7674659.html)

[常见的五类排序算法图解和实现（选择类：简单选择排序，锦标赛排序，树形选择排序，堆排序）](https://www.cnblogs.com/kubixuesheng/p/4359406.html)

[讲述五大常用算法的基本思想、适用情况、步骤、复杂性分析、思维过程](https://www.cnblogs.com/steven_oyj/category/246990.html)



## 4 贪心算法

### 4.1 贪婪技术的基本思想

答：贪心算法的基本思想是找出整体当中每个小的局部的最优解，并且将所有的这些局部最优解合起来形成整体上的一个最优解。因此能够使用贪心算法的问题必须满足下面的两个性质，就是下面的适用情况。



### 4.2 说明贪婪技术与动态规划各适用什么情况？ 

答：

贪婪技术适用情况：

1.整体的最优解可以通过局部的最优解来求出；

2.一个整体能够被分为多个局部，并且这些局部都能够求出最优解。使用贪心算法当中的两个典型问题是活动安排问题和背包问题。

**局部最优解就是全局最优解。**

 

动态规划适用情况：

(1) 最优化原理：如果问题的最优解所包含的子问题的解也是最优的，就称该问题具有最优子结构，即满足最优化原理。

(2) 无后效性：即某阶段状态一旦确定，就不受这个状态以后决策的影响。也就是说，某状态以后的过程不会影响以前的状态，只与当前状态有关。

(3)有重叠子问题：即子问题之间是不独立的，一个子问题在下一阶段决策中可能被多次使用到。（该性质并不是动态规划适用的必要条件，但是如果没有这条性质，动态规划算法同其他算法相比就不具备优势）

### 4.3 [Dijkstra-迪杰斯特拉算法-理解](https://blog.csdn.net/puiopp63/article/details/96102945)

### 4.4 C++代码

[C++: Dijkstra算法获取最短路径(邻接矩阵)](https://github.com/wangkuiwu/datastructs_and_algorithm/blob/master/source/graph/dijkstra/udg/cplus/MatrixUDG.cpp)

[C++: Dijkstra算法获取最短路径(邻接表)](https://github.com/wangkuiwu/datastructs_and_algorithm/blob/master/source/graph/dijkstra/udg/cplus/ListUDG.cpp)

[Dijkstra伪代码和C模版](https://blog.csdn.net/a_big_pig/article/details/44163903)



### 4.5 喷水装置（一）

此题图解

![image-20200730220439271](C:\Users\UryWu\AppData\Roaming\Typora\typora-user-images\image-20200730220439271.png)

```c++
//https://blog.csdn.net/qq_32680617/article/details/50629024 
#include<stdio.h>
#include<math.h>
#include<algorithm>
#include<iostream>
using namespace std;
int cmp(double x,double y)
{
    return x>y;//sort函数降序排列
}
int main()
{
    int m;
    scanf("%d",&m);
    while(m--)
    {
        int n;//半径的总数量
        int num=0;//记录需要用到的半径数量
        double length=20.0;//由于样例中半径是浮点数，所以草坪长度也要定义为浮点数
        double a[601];//存储输入的半径,注意半径类型为double
        scanf("%d",&n);
        for(int i=0; i<n; i++)
            scanf("%lf",&a[i]);
        sort(a,a+n,cmp);//半径降序排列
        for(int i=0; i<n; i++)
        {
            if(a[i]>1&&length>0)//如果半径大于1且剩余草坪长度大于0
            {
                length=length-2*sqrt(a[i]*a[i]-1);//sqrt是开平方函数，这里用了勾股定理，算的是圆圈能覆盖矩形框的长度，看不懂的的本文件夹有图示 
                num++;
            }
            else
            {
                printf("%d\n",num);
                break;
            }
        }
    }
    return 0;
}

```

## 5 BFS

《算法竞赛入门经典完整版(ACM竞赛入门经典)》

例题 6-14 Abbott的复仇（Abbott's Revenge, ACM/ICPC World Finals 2000, UVa 816）

有一个最多包含9*9个交叉点的迷宫。输入起点、离开起点时的朝向和终点，求一条最短路（多解时任意输出一个即可）。这个迷宫的特殊之处在于：进入一个交叉点的方向（用NEWS这4个字母分别表示北东西南，即上右左下）不同，允许出去的方向也不同。例如，1 2 WLF NR ER *表示交叉点(1,2)（上数第1行，左数第2列）有3个路标（字符“*”只是结束标志），如果进入该交叉点时的朝向为W（即朝左），则可以左转（L）或者直行（F）；如果进入时朝向为N或者E则只能右转（R），如图6-14所示。

**注意：**初始状态是“刚刚离开入口”，所以即使出口和入口重合，最短路也不为空。例如，图6-14中的一条最短路为(3,1) (2,1) (1,1) (1,2) (2,2) (2,3) (1,3) (1,2) (1,1) (2,1) (2,2) (1,2) (1,3) (2,3) (3,3)。

![img](file:///C:/Users/UryWu/AppData/Local/Temp/msohtmlclip1/01/clip_image001.png)

再次读题：第一次看时看不懂，其实就是点在移动时它的方向选择取决于它来时背后的箭头方向，假如点在（1，2）方向为E，则可以假设它来自（1，1），则它根据背后的箭头向下行驶，此时点会移动到（2，2）。然后根据它背后的箭头向右到达（2，3）。

## 6 减治法

### 6.1 欧几里得算法

求最大公约数算法：

辗转相除法

求最小公倍数算法：

最小公倍数=两整数的乘积÷最大公约数

#### 6.1.1 循环写法

```c
/*
欧几里得算法：辗转求余
原理： gcd(a,b)=gcd(b,a mod b)
当b为0时，两数的最大公约数即为a
getchar()会接受前一个scanf的回车符
*/
#include<stdio.h>
unsigned int MaxCommonFactor（int a,int b）
{
    if(b<=0)
      return a;
    return MaxCommonFactor(b,a%b);
}
   
unsigned int Gcd(unsigned int M,unsigned int N)
{
    unsigned int Rem;
    while(N > 0)
    {
        Rem = M % N;
        M = N;
        N = Rem;
    }
    return M;
}
int main(void)
{
    int a,b;
    scanf("%d %d",&a,&b);
    printf("the greatest common factor of %d and %d is ",a,b);
    printf("%d\n",Gcd(a,b));
    printf("recursion:%d\n",MaxCommonFactor(a,b));
    return 0;
}
```

#### 6.1.2 递归写法

```c++
#include <iostream>
using namespace std;

int main(){
    int gcd(int, int);
    gcd(10, 7); 
    return 0;
}

int gcd(int m, int n){
    if (!n)
    {
        cout << "最大公因数是：" << m << endl;
        return 0;
    }
    return gcd(n, m % n);
}
```



## 7 前缀和(前n项和)

题目：

10万个数，求和为10000的子串。

暴力n^2，计算量过大。

假设样例为1 3 1 2 0 10002

那满足条件的子串为2 0 10002

解题：

扫描一遍样例，用map<int Sn,int number>的number存此数，Sn存到达此数时的前n项和。

然后样例为：

1 3 1 2 0 10002的前n项和为：

1 4 5 7 7 10009

我们可以看到S6-S4=10000

所以解题的思路明了：Sm-Sl=10000 <=> Sm-10000=Sl

我每次写入数据时，计算出Sm，然后只要在map里查找Sm-10000的数是否存在就可以了。

以键查找map中的值，时间复杂度为O(logN)，输入从头到尾输入数据，计算前n项和时间复杂度为O(N)，所以程序为O(NlogN)

## 8 一些题目

### 8.1 异或交换数字

#### 8.1.1 C样例

```c
#include<stdio.h>
main()
{
	int a,b;
	a = 1,b = 2;
	a = a^b;
	b = a^b;
	a = a^b;
	printf("a = %d, b = %d",a,b);
 } 
```

#### 8.1.2 图示：

![image-20200730222223450](C:\Users\UryWu\AppData\Roaming\Typora\typora-user-images\image-20200730222223450.png)

#### 8.1.3 缺陷：

容易造成值的溢出。

#### 8.1.4 应用：

[熟练使用 C / C++ 各种 undefined behaviour 是什么样一种体验？ - Mike He的回答 - 知乎](https://www.zhihu.com/question/263756540/answer/272616108)

```c++
inline int gcd1(int x,int y){
    while(x^=y^=x^=y%=x);return y;
}

/*
do{
//取余赋值
y = y%x
//异或交换
x = x^y
y = x^y
x = x^y
}while(x);
*/
```

无需关心y与x谁大小，若是x比y大，一次gcd后，y与x的值会交换

### 8.2 [计算器ll](https://leetcode.cn/problems/basic-calculator-ii/solutions/648647/ji-ben-ji-suan-qi-ii-by-leetcode-solutio-cm28/)

#### 8.2.1 方法一：栈
思路

由于乘除优先于加减计算，因此不妨考虑先进行所有乘除运算，并将这些乘除运算后的整数值放回原表达式的相应位置，则随后整个表达式的值，就等于一系列整数加减后的值。

基于此，我们可以用一个栈，保存这些（进行乘除运算后的）整数的值。对于加减号后的数字，将其直接压入栈中；对于乘除号后的数字，可以直接与栈顶元素计算，并替换栈顶元素为计算后的结果。

具体来说，遍历字符串 s，并用变量 preSign 记录每个数字之前的运算符，对于第一个数字，其之前的运算符视为加号。每次遍历到数字末尾时，根据 preSign来决定计算方式：

- 加号：将数字压入栈；
- 减号：将数字的相反数压入栈；
- 乘除号：计算数字与栈顶元素，并将栈顶元素替换为计算结果。
代码实现中，若读到一个运算符，或者遍历到字符串末尾，即认为是遍历到了数字末尾。处理完该数字后，更新 preSign为当前遍历的字符。

遍历完字符串 s 后，将栈中元素累加，即为该字符串表达式的值。

作者：力扣官方题解
#### 8.2.2 代码
```cpp
class Solution {
public:
    int calculate(string s) {
        vector<int> stk;
        char preSign = '+';
        int num = 0;
        int n = s.length();
        for (int i = 0; i < n; ++i) {
            if (isdigit(s[i])) {//如果是数字
                num = num * 10 + int(s[i] - '0');
            }
            if (!isdigit(s[i]) && s[i] != ' ' || i == n - 1) {//如果是字符或计算器表达式未结束
                switch (preSign) {
                    case '+':
                        stk.push_back(num);
                        break;
                    case '-':
                        stk.push_back(-num);
                        break;
                    case '*':
                        stk.back() *= num;
                        break;
                    default:
                        stk.back() /= num;
                }
                preSign = s[i];
                num = 0;
            }
        }
        return accumulate(stk.begin(), stk.end(), 0);
    }
};
```

#### 8.2.3 复杂度分析

时间复杂度：O(n)，其中 n 为字符串 s 的长度。需要遍历字符串 s 一次，计算表达式的值。

空间复杂度：O(n)，其中 n 为字符串 s 的长度。空间复杂度主要取决于栈的空间，栈的元素个数不超过 n。

### 8.3 计算器III

[【LeetCode - 772】基本计算器 III\_leetcode 772\_学哥斌的博客-CSDN博客](https://blog.csdn.net/qq_29051413/article/details/108574581)
逆波兰计算器的原理是使用逆波兰表达式来计算出表达式的值，我们人类能够熟练使用的是中缀表达式，比如2×(9+6/3-5)+4就是一个中缀表达式，但是看到上面的简单计算器就知道处理起来很麻烦。于是有一种逆波兰计算器，计算是在逆波兰表达式（也叫做后缀表达式）的基础上。

逆波兰计算器的计算过程为：从左到右扫描后缀表达式，遇到数字就入栈，遇到操作符就从栈弹出两个数字，然后计算得到的值继续入栈，继续扫描表达式，直到扫描完毕得到结果。

中缀表达式：<font color="#ff0000">2 × (9 + 6 / 3 - 5) + 4</font>
对应的后缀表达式为：<font color="#ff0000">2 9 6 3 / + 5 - * 4 +</font>
逆波兰计算器执行过程：从左到右扫描后掇表达式
![](ACM算法+题目.assets/image-20230821192230355.png)

从逆波兰计算器的扫描过程可以看到，过程特别简单，代码写起来也比较容易。但现在的难点在于：如何把中缀表达式转成后缀表达式？

  这个过程已经有大神给出来了，我们记下来即可：
  1、初始化两个栈：运算符栈s1和存储中间结果的栈s2；
  2、从左到右扫描中缀表达式；
  3、遇到操作数时，压入到栈s2；
  4、遇到运算符时：
    1）如果s1为空或s1栈顶为左括号"("，则压入到s1；
    2）不满足1），则和s1栈顶运算符比较优先级，高于，则压入s1；
    3）不满足1）和2），弹出s1栈顶运算符并压入到s2，再次回到2。
  5、遇到右括号")“时，依此弹出s1并压入s2，直到遇到左括号”)"为止，此时丢掉一对括号；
  6、重复2-5，直到扫描完毕；
  7、将s2栈弹出压入到s1，然后s1弹出全部，弹出的顺序即为后缀表达式。
  
```java
/**
     * 中缀转后缀
     *
     * @param infix
     * @return
     */
    public List<String> infixToSuffix(List<String> infix) {
        List<String> suffix = new ArrayList<>();
        Stack<String> stack1 = new Stack<>();   // 只用于保存操作符
        Stack<String> stack2 = new Stack<>();   // 用于保存中间结果
        for (int i = 0; i < infix.size(); i++) {
            String tmp = infix.get(i);
            if (isOper(tmp)) {   // 操作符要根据情况来入栈 1
                if (stack1.isEmpty() || "(".equals(tmp)) {
                    // 如果 stack1 是空的，或者 tmp 是左括号，直接入栈
                    stack1.push(tmp);
                } else { // stack1 不是空的，且 tmp 不是左括号
                    if (")".equals(tmp)) {
                        // tmp 是右括号，则把 stack1 遇到左括号之前，全部倒入 stack2
                        while (!"(".equals(stack1.peek())) {
                            stack2.push(stack1.pop());
                        }
                        stack1.pop();   // 丢掉左括号
                    } else {
                        // tmp 是 +-*/ 其中之一
                        while (!stack1.isEmpty() && priority(stack1.peek()) >= priority(tmp)) {
                            // 在 tmp 能够碾压 stack1 的栈顶操作符之前，把 stack1 的栈顶操作符倒入 stack 2 中
                            stack2.push(stack1.pop());
                        }
                        // 离开 while 时，要么 stack1 已经倒空了，要么就是现在 tmp 可以压住 stack.peek() 了
                        stack1.push(tmp);
                    }
                }
            } else { // 操作数直接入栈 2
                stack2.push(tmp);
            }
        }

        // stack1 剩余操作符全部倒入 stack2
        while (!stack1.isEmpty()) {
            stack2.push(stack1.pop());
        }

        // stack2 的逆序才是结果，所以要再倒一次
        while (!stack2.isEmpty()) {
            stack1.push(stack2.pop());
        }

        // 现在 stack1 的元素倒出来的顺序就是后缀表达式
        while (!stack1.isEmpty()) {
            suffix.add(stack1.pop());
        }

        return suffix;
    }

```



[关于leetcode772题基本计算器3的逆波兰式解法的讲解\_leetcode 基本计算器3](https://blog.csdn.net/yxg520s/article/details/127565682?spm=1001.2101.3001.6650.6&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-6-127565682-blog-124301527.235%5Ev38%5Epc_relevant_sort&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-6-127565682-blog-124301527.235%5Ev38%5Epc_relevant_sort&utm_relevant_index=7)
将中缀转后缀
1、首先构造一个运算符栈，此运算符在栈内遵循越往栈顶优先级越高的原则。
2、读入一个用中缀表示的简单算术表达式，为方便起见，设该简单算术表达式的右端多加上了优先级最低的特殊符号“#”。
3、从左至右扫描该算术表达式，从第一个字符开始判断，如果该字符是数字，则分析到该数字串的结束并将该数字串直接输出。
4、如果不是数字，该字符则是运算符，此时需比较优先关系。
具体做法是：将该字符与运算符栈顶的运算符的优先关系相比较。如果该字符优先关系高于此运算符栈顶的运算符，则将该运算符入栈。若不是的话，则将栈顶的运算符从栈中弹出，直到栈项运算符的优先级低于当前运算符，将该字符入栈。
5、重复步骤1～2，直至扫描完整个简单算术表达式，确定所有字符都得到正确处理，便可以将中缀式表示的简单算术表达式转化为逆波兰表示的简单算术表达式。

## 9 大佬给的学习路径

### 9.1 未完成：

ACM所有算法网址 https://blog.csdn.net/int1282951082/article/details/52128991
ACMC++STL https://blog.csdn.net/chencsmat/article/details/47778757
ACM桶排序https://www.cnblogs.com/ECJTUACM-873284962/p/6935506.html
ACM快速幂 https://www.cnblogs.com/Roni-i/p/7163565.html
ACM矩阵快速幂 https://blog.csdn.net/nyist_tc_lyq/article/details/52981353
ACM最大公约数 https://www.cnblogs.com/linyujun/p/5167914.html
ACM卡特兰数https://blog.csdn.net/hangelsing/article/details/47807663
ACM第一类斯特灵数https://blog.csdn.net/meixiuxiudd/article/details/52215923
ACM第二类斯特灵数https://www.cnblogs.com/Lattexiaoyu/archive/2012/07/10/2584667.html
ACM逆元https://blog.csdn.net/acdreamers/article/details/8220787
ACM DFS和BFS https://blog.csdn.net/HelloWorld10086/article/details/38359033
ACM 博弈论https://www.cnblogs.com/kuangbin/archive/2011/08/28/2156426.html
ACM 树状数组https://blog.csdn.net/ljd4305/article/details/10101535
ACM 线段树https://blog.csdn.net/qq_26071477/article/details/51636464
ACM 背包问题https://blog.csdn.net/winter2121/article/details/70185099
ACM 最大区间查询https://blog.csdn.net/niushuai666/article/details/6624672/
ACM 并查集https://blog.csdn.net/fkjslee/article/details/48809903
ACM 字典树https://blog.csdn.net/u011787119/article/details/46991691

ACM判断点在多边形内还是外部https://blog.csdn.net/thearcticocean/article/details/48632391
ACM线段交https://blog.csdn.net/wordsin/article/details/79215342
ACM求凸包https://www.cnblogs.com/jbelial/archive/2011/08/05/2128625.html
ACM凸包求面积https://blog.csdn.net/moon_no2015/article/details/52416572
ACM极角排序https://blog.csdn.net/hysfwjr/article/details/8949810
ACM质数筛法和因子的个数https://blog.csdn.net/w20810/article/details/43702087
ACM质数筛法和欧拉函数筛法https://blog.csdn.net/update7/article/details/70943545
ACM中国剩余定理https://www.cnblogs.com/linyujun/p/5199415.html
ACM欧拉定理https://blog.csdn.net/u012905448/article/details/39163531
ACMDFS和BFS代码https://blog.csdn.net/dreamzuora/article/details/51137132
ACM拓扑排序https://blog.csdn.net/u011787119/article/details/47256769
ACM最小生成树primehttps://blog.csdn.net/acm_jl/article/details/50896855
ACM匈牙利算法https://blog.csdn.net/lw277232240/article/details/72615522
ACMNim博弈https://blog.csdn.net/clover_hxy/article/details/53818624
ACM动归小问题https://www.cnblogs.com/WABoss/p/DP.html
ACM动态规划http://acm.pku.edu.cn/summerschool/acm-icpc%E6%9A%91%E6%9C%9F%E8%AF%BE_%E5%8A%A8%E8%A7%84.pdf

### 9.2 在看：

ACM最短路算法https://blog.csdn.net/harrety/article/details/47205601

### 9.3 已看：

反转单向链表 https://www.jianshu.com/p/bd6a64d36916

### 9.4 [花花酱的表世界个人主页](https://space.bilibili.com/9880352)

## 10 leetcode问题

[花花酱的表世界的个人空间-花花酱的表世界个人主页-哔哩哔哩视频](https://space.bilibili.com/9880352)

### 10.1 [codeforces的div1和div2区别](https://zhuanlan.zhihu.com/p/259971233#:~:text=%E6%AF%94%E8%B5%9B%E5%90%8D%E7%A7%B0%E5%90%8E%E9%9D%A2%E6%8B%AC%E5%8F%B7%E9%87%8Cdiv%E8%A1%A8%E7%A4%BA%E7%9A%84%E6%98%AF%E9%9A%BE%E5%BA%A6%E7%AD%89%E7%BA%A7%EF%BC%8Cdiv1%E6%98%AF%E6%9C%80%E9%AB%98%E9%9A%BE%E5%BA%A6%E3%80%82,%E9%9C%80%E8%A6%81%E6%9C%891900%E4%BB%A5%E4%B8%8A%E7%9A%84rating%E6%89%8D%E5%8F%AF%E4%BB%A5%E6%8A%A5%E5%90%8D%E3%80%82)

比赛名称后面括号里div表示的是难度等级，div1是最高难度。需要有1900以上的rating才可以报名。div2难度会简单很多，基本上学过算法和数据结构都可以进去做个一两题。div2的比赛前两题基本上都不涉及什么算法，主要是考验思维。一般到了C题之后才会考察一些算法和数据结构。

### 10.2 [codeforces和leetcode比较](https://www.zhihu.com/question/505751267/answer/2283982956)
总体来说 LeetCode 作为面向求职者的 OJ 其难度是“够的”。但没必要硬和面向竞赛的 OJ 比，因为往后根本不是一个赛道。比如 Codeforces Div1 A ~ B 基本就是 Div2 D ~ E 了。瞅瞅 OI Wiki 上那堆东西，不学个一半左右看完题估计就下机了，还玩个锤子。

刷 LeetCode 和刷 Div2 A ~ C 差不多，大部分竞赛知识根本不涉及（这很合理，不是吗？），只能避免开局卡签到题。

对标CF 2000分左右吧，相当于Div2 C到D的难度。
对标XCPC区域赛的话确实也就铜牌题。
况且leetcode所谓难题都是些套路DP，只会这些连铜牌都拿不到。
发布于 2021-12-13 17:11

厚米soaring
区域铜牌银牌题也有一些套路啊[大笑]高级数据结构板子题，铜牌现在还是挺水的，个人感觉会做你说的lc hard的题，可能不一定能拿铜，反过来也差不多，能拿铜也不一定能做
2021-12-14
### 10.3 [leetcode还是牛客网](https://www.zhihu.com/question/317497607/answer/642442147)



接下来是建议：

1 坚持刷leetcode，根据经验，刷够一百多题的时候已经足以处理大部分的面试，刷够三百题白板编码基本毫无压力，甚至还有点想笑。如果是社招，可以直接忽略这条，

2 如果是校招，笔试之前可以看一看对应公司往年的题目，虽然根据我的经验，看了也没啥用，做不出来也做不出来。

3 牛客的讨论区，除了内推消息和面经之外的内容还是少看，除了增加焦虑没有其他任何用处。刚刚提到校招笔试题目很难，但也有很多大佬能够做对大部分或者全对。希望不要焦虑，因为据我观察，很多进到BATTMD还有amazon、ms这些地方的人也不见得能刷的出来很多。重要的是要提高自己的水平，保持平常心，坚持刷题。

4 刷题的话，时间充足建议leetcode按顺序刷，时间不够的话top 100 interview一定要刷，同时刷掉过程中推荐的相关题目（leetcode在编码界面会推荐）

5 最后反思过去的一年发现，牛客给我带来的是内推机会、焦虑、焦虑、焦虑、焦虑，而leetcode给我带来的是面试时候自信和从容，而且，leetcode相比牛客而言也更加纯粹。面试现场白板编码的时候，才知道leetcode诚不欺我。

利益相关：拿到过几个以算法考核闻名的公司offer，非acm选手。



### 10.4 [社招主要是八股408 大厂才算法](https://leetcode-cn.com/circle/discuss/8gcs1E/)

[你是小王吧还是小基吧L2](https://leetcode-cn.com/u/a445146313/)

2021-07-09

我之前天真的拿着别人校招的面经去社招，被虐的不成人形。

首先社招会深挖八股问，和算法的比例大概是四六开或者二八开，所以毫无疑问是看书更重要。

其次是<font color='red'>社招要求更高，容忍度很低，基本八股2点答不上来或者打错就凉了，所以重点功夫还是看八股问和项目吧。</font>

<font color='red'>算法考核只有大厂会要求，中小厂对算法要求并且难度都不高。</font>

因此准备时间分配上因该是看书，然后再是算法的中易难度。难的放弃掉这样子。



[幻想世界L2](https://leetcode-cn.com/u/huan-xiang-shi-jie-YKzENcm0Kb/) 2021-07-07

要，大厂基本上都需要



2021-07-08

算法，数据结构，操作系统，网络等基础知识

### 10.5 必问

thatsaid

2021-07-08
必问，很久没看的话一定要刷

### 10.6 程序员上班后还刷算法题吗？


#### 10.6.1 准备跳槽
个体差别很大，身边同事除了准备跳槽，平常没听说刷的。
我个人偶尔刷，只是作为一种消遣。
发布于 2019-11-18 14:01
#### 10.6.2 [升职加薪或者跳槽的，必刷](https://www.zhihu.com/question/356122264/answer/2709301289)
刷！！！特别是想要升职加薪或者跳槽的，必刷！！！现在的面试要求越来越高，特别是社招，有一些小公司也都要问算法，更别说一下中大厂了，那都是必问！！！别问怎么知道的，问就是实际经验积累，都是血泪史呀

我学习算法也一两年了，之前都是自己在网上看看视频，自己刷题，但是效果也不是很大，不过前一段时间朋友推荐，我报了一个算法班，就是饥人谷新出的一个算法课，两千多，还不错，现在差不多构建出算法中的知识体系了，无隅老师也很厉害，基本上面试者会碰到的题他都会讲，还会提供很多模板，思路也都很好，很容易理解~
不过老师教了也要自己花时间去做的，我这2个月基本上是没有什么娱乐活动了，一有时间就在看题刷题，没办法，其他报了这个算法班的同学都好卷，只能尽力追上卷王们的脚步了，不过这2个月下来收获也确实多，比我之前自己刷题的一两年时间学的都多
老师说总的差不多有200道题，各种类型知识点都会覆盖，然后每道题都得让我们刷3遍，是的3遍！！！所以真的没有时间去玩了，然后最近又开始死磕动态规划了，真的有点难，不过跟着老师的视频学习就还好，慢慢来
再给你们看一下这个两千多的算法课有多少内容，真的很值！！！

### 10.7 [2000-还是别考虑 是否写在简历](https://www.zhihu.com/question/351354334/answer/1111760976)
我来说个简单的例子以前去深圳寒武纪acm冬令营，寒武纪的cto表示cf直接给他看codeforces分数就可以考虑进来实习了，当然人家老总喜欢这个。首先知道的人是少数。打多少分也是个问题 ，2000-还是别考虑了，没有意义的
发布于 2020-03-28 22:42
