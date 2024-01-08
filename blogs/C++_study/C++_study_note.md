
### 未分类

#### 1.程序中有sum += 一项的，记得在每组测试数据的末尾添sum = 0;

#### 2.return前有语句须以分号隔开；

#### 3.一般而言，比较正常的数据的话，一般都是算完时间复杂度后次数换算关系为1亿次约等于1秒

#### 4.记得头文件后加using namespace std;

#### 6.函数或递归传值

```c++
‌‌‌‌　　sum(int a)
‌‌‌‌　　{
    a+=1;
   printf("%d",a);
‌‌‌‌　　}
‌‌‌‌　　int main()
‌‌‌‌　　{
    int a=1;
    sum(a--);//给函数传过去的是1，若是sum(--a)给函数传过去的就是0;
‌‌‌‌　　}
```

#### 7.对数log的使用#include<stdio.h>   log10(100) = 2;

‌‌‌‌　　https://blog.csdn.net/weixin_37609825/article/details/79850874

#### 8.[计算一个数字的长度的几种方法](https://blog.csdn.net/u010942041/article/details/62060682)

##### 公式法

‌‌‌‌　　根据数学公式直接计算结果.

```cpp
‌‌‌‌　　int length(double n)
‌‌‌‌　　{
    return (int)log10(n)+1;
‌‌‌‌　　}
```

##### 普通方法

‌‌‌‌　　每次去掉一位,sum加1.

```cpp
‌‌‌‌　　int length(int n)
‌‌‌‌　　{
    int sum=0;
    while(n)
    {
        n/=10;
        sum++;
    }
    return sum;
‌‌‌‌　　}
```

##### 字符串方法

```c++
‌‌‌‌　　int task3_12(){
    int number,j;
    cout<<"请输入一个不多与5位的整数："<<endl;
    cin>>number;

    string str = to_string(number);
    cout<<"它是"<<str.size()<<"位数"<<endl;
‌‌‌‌　　}
```



#### 9.[关于codeblocks无法调试](https://www.cnblogs.com/shangjindexiaoqingnian/p/5728454.html)

#### 10.[学霸教你如何科学的打开 Leetcode](https://mp.weixin.qq.com/s?__biz=MzIzNTI3MTQxMg==&mid=2652536046&idx=1&sn=3bd45b6a448fe5dfb74ae59de6c89838&chksm=f3077975c470f063212eb42ce6385c5127666d7f08abeb4a3d641049ecd96f22c373979ce133&scene=21#wechat_redirect)



#### 11.[malloc - invalid conversion from void* to double*](https://stackoverflow.com/questions/30088025/malloc-invalid-conversion-from-void-to-double)

```c
‌‌‌‌　　double* a = NULL;
‌‌‌‌　　a = malloc(n*sizeof(double));//报错代码
```

‌‌‌‌　　此段代码在C编译器中编译通过，但在C++编译器中报错：空类型void\*无法转换为double\*类型，在C++编译器中需要手动转换类型：

```c++
‌‌‌‌　　double* a = NULL;
‌‌‌‌　　a = (double *)malloc(n*sizeof(double));//报错代码
```

#### 12.另类赋值方法：

```c++
‌‌‌‌　　int i(0), j(4-1);
‌‌‌‌　　cout<<i<<" "<<j<<endl;
```

#### [13.C/C++ 模拟键盘操作（一）](https://blog.csdn.net/qq_40757240/article/details/105504524#%E8%99%9A%E6%8B%9F%E9%94%AE%E5%80%BC%E5%A4%A7%E5%85%A8)

#### 14.链表结构体

‌‌‌‌　　1.c语言要求变量声明语句必须放在所有可执行语句之前
‌‌‌‌　　无论是结构体变量声明还是什么，必须放在调用函数后面
‌‌‌‌　　见网址：
‌‌‌‌　　https://wenda.so.com/q/1534404455211098?src=140
‌‌‌‌　　但是。cpp文件就不会这样：
‌‌‌‌　　https://blog.csdn.net/lcr_happy/article/details/52467693

‌‌‌‌　　2.创建链表时务必记得动态分配结构体，我在这个上面吃了不少亏。

‌‌‌‌　　3.PCH creation pointer
‌‌‌‌　　因为你的头文件里有垃圾语句

‌‌‌‌　　4.0x0表示null为空

‌‌‌‌　　5.链表必须记得malloc,还有用的节点就不要free

#### [15.size_t 这个类型的意义是什么？](https://www.zhihu.com/question/24773728)

‌‌‌‌　　跨平台。
‌‌‌‌　　不同平台的size_t会用不同的类型实现，使用size_t而非int或unsigned可以写出扩展行更好的代码。

‌‌‌‌　　[发布于 2014-08-08](https://www.zhihu.com/question/24773728/answer/28920345)



‌‌‌‌　　直接的回答--------------------------size_t = **t**ypeof(**size**of(X))

‌‌‌‌　　[编辑于 2017-08-09](https://www.zhihu.com/question/24773728/answer/210698057)



‌‌‌‌　　学过计算机组成原理应该不会对此有疑问。int小于等于数据线宽度，size_t大于等于地址线宽度。

‌‌‌‌　　size_t存在的最大原因可能是因为：地址线宽度历史中经常都是大于数据线宽度的。

‌‌‌‌　　在数据只有8位的年代，地址率先进入10位，12位，在数据16位的年代，地址也已经进入了20位，24位。

‌‌‌‌　　目前的int普遍是32位，而size_t在主流平台中都是64位。

‌‌‌‌　　size_t为什么存在？因为无论int还是unsigned都很可能小于size_t需要的大小，所以必须有个size_t。
‌‌‌‌　　链接：https://www.zhihu.com/question/24773728/answer/210659978

### [推荐看黑马c++](https://www.bilibili.com/video/BV1et411b73Z?p=138)

‌‌‌‌　　[本地的讲义 C++核心编程](F:\Files\My_Library\blogs\C++_study\黑马程序员匠心之作C++教程从0到1入门编程,学习编程不再难\讲义\C++核心编程.md)

‌‌‌‌　　深拷贝浅拷贝看这里也行：

‌‌‌‌　　[27 类和对象-对象特性-深拷贝与浅拷贝](https://www.bilibili.com/video/BV1et411b73Z?p=110)

### 邝煜云 C++教程

#### [day19 006_拷贝构造函数概念及实例](https://www.bilibili.com/video/BV1fZ4y1F7Vt?p=183)

```c++
‌‌‌‌　　class Point1{
    Point1(const Point1 &p); //拷贝构造函数，用于快速初始化类。
‌‌‌‌　　};
‌‌‌‌　　Point1::Point1(const Point1 &p){//拷贝构造函数
    this->x = p.x;
    this->y = p.y;
‌‌‌‌　　}
```

#### [day20 002_类的静态成员及静态函数](https://www.bilibili.com/video/BV1fZ4y1F7Vt?p=185)

‌‌‌‌　　到目前为止，使用static可 进行的5种说明有:
‌‌‌‌　　1.局部静态变量
‌‌‌‌　　2.全局静态变量
‌‌‌‌　　3.具有静态存储类别的函数
‌‌‌‌　　4.类的静态数据成员
‌‌‌‌　　5.类的静态函数成员
‌‌‌‌　　1)局部静态变量
‌‌‌‌　　●在函数或块的内部说明的静态变量
‌‌‌‌　　●它的作用域仅局部于函数或块
‌‌‌‌　　●它的“生命期”却与整个程序的执行期相同

‌‌‌‌　　2)全局静态变量
‌‌‌‌　　●在所有函数的外部说明
‌‌‌‌　　●它的作用域仅局部于单文件
‌‌‌‌　　●它的“生命期”却与整介程序的执行期相同
‌‌‌‌　　3)静态函数
‌‌‌‌　　●只能在本文件的内部被调用
‌‌‌‌　　●在其他文件中均不可见
‌‌‌‌　　4)静态数据成员
‌‌‌‌　　●static修饰的类中的数据成员
‌‌‌‌　　●为该类的所有对象所共享

‌‌‌‌　　5)静态函数成员
‌‌‌‌　　●由关键字static修饰的类中的函数成员
‌‌‌‌　　●类的静态函数成员没有this指针，不能使用const关键字
‌‌‌‌　　●通常只在其中处理类的静态数据成员值

‌‌‌‌　　<img src="F:\Files\ACM\C++笔记assets\静态成员函数与静态变量调用关系.png" style="zoom:67%;" />



‌‌‌‌　　类的静态成员为其所有对象所共享，不管有多少对象，静态成员只有一份存于内存中。

‌‌‌‌　　所以在函数内，静态变量只初始化一次，每次调用都是上一次使用留下的结果。

‌‌‌‌　　static也是让变量只允许在本文件使用，外部文件无法使用。？？

‌‌‌‌　　- **静态变量的初始化：**

‌‌‌‌　　类的头部定义：

```c++
‌‌‌‌　　class B
‌‌‌‌　　{
‌‌‌‌　　public:
    const static int a = 10;
    static int b;
    static void FuncClassB( ){
    ...
    }
    void FuncA( ){
        cout <<”FuncA函数”<< endl ;
        return; 
    }
‌‌‌‌　　};
```

‌‌‌‌　　static const a = 1;与const static a = 1;一样可相互代替。

1. 类在内部初始化静态变量必须加const

```c++
‌‌‌‌　　const static int a = 10;
```

2. 或者在静态函数里面初始化。

```c++
‌‌‌‌　　class B{
    static int GetPersonCount( );//或者在静态函数里面初始化。
    personCount = 100 ;
    return personCount;
‌‌‌‌　　}
```

3. 外部初始化

```c++
‌‌‌‌　　intB::b=100;
```

   

‌‌‌‌　　- **静态成员可以不通过对象访问，而是通过类访问，即使没有创建任何对象。**

‌‌‌‌　　<img src="./C++笔记assets\静态成员是属于类的.png" alt="静态成员属于类" style="zoom:67%;" />

```c++
‌‌‌‌　　class B{
    static void FuncClassB( )|
    cout << "FuncB函数” << endl;
    return; 
‌‌‌‌　　};
```

‌‌‌‌　　这里用类B::可以直接调用静态类static FuncClassB();而不用实例化B b;

‌‌‌‌　　![](F:\Files\My_Library\blogs\C++_study\ACM\C++笔记assets\main函数截图.png)	

‌‌‌‌　　这里写B::FuncA();是错的，因为FuncA()不为静态类，必须通过实例化对象来使用。

#### [day20 003_类的静态成员及静态函数](https://www.bilibili.com/video/BV1fZ4y1F7Vt?p=186)

‌‌‌‌　　<font color='red'>static成员函数是属于类的，而不属于所有对象。</font>而const成员函数属于对象的(属于对象的成员函数都对应this指针)。他表明函数不会修改所属的对象。

‌‌‌‌　　所以这里类里面的成员函数不能同时有static和const：

‌‌‌‌　　<img src="F:\Files\ACM\C++笔记assets\矛盾的静态成员函数.png" style="zoom:67%;" />

‌‌‌‌　　this也是只有对象内部的成员函数才能使用，static使成员函数属于所有对象，矛盾，所以this在static里无法用：

‌‌‌‌　　<img src="F:\Files\ACM\C++笔记assets\this属于对象.png" style="zoom:67%;" />

#### [day20 004_常量函数成员](https://www.bilibili.com/video/BV1fZ4y1F7Vt?p=187)



```c++
‌‌‌‌　　struct Birthday{
    ...
‌‌‌‌　　};

‌‌‌‌　　class ...{
    Birthday birthday;//这里再加个const使常量更加安全，更不可变：const Birthday birthday;
    
    Birthday FuncConst( )const{
        birthday.year = 2000;//此行有错，因为const使函数内部为常量不可变。
    	return birthday;
    } 
‌‌‌‌　　};
```



‌‌‌‌　　修饰符const要加<font color='red'>在函数说明的尾部</font>，它是函数类型的一部分。<font color='red'>在该函数的实现部分也要加Iconst关键字。</font>

```c++
‌‌‌‌　　class ...{
	Birthday FuncConstA() const;//声明常量函数。
‌‌‌‌　　};
‌‌‌‌　　int B::b = 100;

‌‌‌‌　　Birthday B::FuncConstA() const //在外部实现函数必须加const
‌‌‌‌　　{
	return birthday;
‌‌‌‌　　}
```

#### [day20 007_友元类实例](https://www.bilibili.com/video/BV1fZ4y1F7Vt?p=190)

‌‌‌‌　　![](F:\Files\My_Library\blogs\C++_study\ACM\C++笔记assets\友元函数和友元类特点.png)

```c++
‌‌‌‌　　class A
‌‌‌‌　　{
‌‌‌‌　　private:
    friend void FuncFriendA(){
        cout << "友元函数A" << endl;
    }
    friend void FuncFriendB();
    friend class B;
‌‌‌‌　　};
‌‌‌‌　　class B
‌‌‌‌　　{
    //
‌‌‌‌　　};

‌‌‌‌　　friend void FuncFriendB(){//这样写是错误的
    //...
‌‌‌‌　　}
‌‌‌‌　　void FuncFriendB(){//应该这样写
    //...
‌‌‌‌　　}
```

‌‌‌‌　　[函数f为类A的友元函数:](https://www.bilibili.com/video/BV1fZ4y1F7Vt?p=189&t=355.1)
‌‌‌‌　　●它不是A的函数成员
‌‌‌‌　　●可以在类A的说明内，也可以在类外
‌‌‌‌　　<font color='red'>●有权访问和调用A的所有私有及保护成员</font>

‌‌‌‌　　[类B为类A的友元类:](https://www.bilibili.com/video/BV1fZ4y1F7Vt?p=189&t=512.8)
‌‌‌‌　　●可能是与类A无关的另外一个类
‌‌‌‌　　●要在类外说明，就是类B的定义要写在A类外
‌‌‌‌　　●B的每个函数都有权访问和调用类A的所有成员

```c++

‌‌‌‌　　class Box
‌‌‌‌　　{
‌‌‌‌　　private:
    float width;
    friend void PrintWidth(Box box);
    friend class BoxA;
‌‌‌‌　　public:
    float length;
    void Setwidth(float width);//假如这里设置为私有，则此函数无法被box.Setwidth调用
‌‌‌‌　　};
‌‌‌‌　　void PrintWidth(Box box){
    cout << "盒子的宽度: " << box.width << endl;
‌‌‌‌　　}
‌‌‌‌　　void Box::Setwidth(float width)
‌‌‌‌　　{
    this->width = width; 
‌‌‌‌　　}
‌‌‌‌　　class BoxA//类B的定义要写在A类外
‌‌‌‌　　{
‌‌‌‌　　public:
    void PrintInfo(int width, Box &box)
    {
        box.Setwidth(width);
        cout << "盒子的宽度为:" << box.width << endl;//这个float Box::width是Box类的私有成员，如果BoxA不是Box类的友元类的话，BoxA无法访问box.width
    }
‌‌‌‌　　};

‌‌‌‌　　int main(void){
    Box box ;
	box.Setwidth(10.0f);//假如Setwidth设置为私有，则此函数无法被box调用
    PrintWidth(box);//这个友元函数破除了Box的封装。
    
    BoxA boxA;
    boxA.PrintInfo(20, box);//由于BoxA是Box类的友元类，所以BoxA可访问float Box::width

    return 0;
‌‌‌‌　　}
```



##### [C++运算符的重载---以成员函数方式重载---以友元函数方式重载](https://www.cnblogs.com/southcyy/p/10260626.html)

‌‌‌‌　　- 一般情况下，建议一元运算符使用类的成员函数，二元运算符使用友元函数
  - 运算符的操作需要修改类对象的状态，则使用成员函数。如需要做左值操作数的运算符（=，+=，*=，++，--）
  - 运算时，有数与对象的混合运算时，必须使用友元函数
  - 二元运算中，第一个操作数为非对象时，必须使用友元函数。如输入输出运算符<< >>



| 运算符                                                  | 建议使用       |
| ------------------------------------------------------- | -------------- |
| 所有一元运算符                                          | 成员函数       |
| = () [] ->                                              | 必须是成员函数 |
| += -= /= *= ^= &= != %= >>= <<= ,似乎带等号的都在这里了 | 成员函数       |
| 所有其它二元运算符,例如: -.+,*,/                        | 友元函数       |
| << >>                                                   | 必须是友元函数 |

‌‌‌‌　　因为流操作符的第一个对象是ostream、istream不可能在那里面重载函数。

#### [浅谈重写和重载的区别java](https://zhuanlan.zhihu.com/p/166139107)



#### [day20 009_运算符重载实例](https://www.bilibili.com/video/BV1fZ4y1F7Vt?p=192)

```c++
‌‌‌‌　　class Point{
    public:
        Point(){}
        Point(int x, int y){
            this->x = x;
            this->y = y;
        }

        Point operator+(const Point& p1){
            Point p;
            p.x = this->x + p1.x;
            p.y = this->y + p1.y;
            return p;
        } //正确做法，运算符重载只要写一个参数就够了，另外一个是自己。
        
        // Point operator+(const Point& p1, const Point& p2) //参数过多，会报错。must have either zero or one argument
        // {
        //     Point p;
        //     p.x = p1.x + p2.x;
        //     p.y = p1.y + p2.y;
        //     return p;
        // }

        friend void pointPrint(Point &p){ //破除private的封装，因为private使你无法直接访问p.x。
            cout << "(" << p.x << "," << p.y << ")" <<endl;
        }
    private:
        int x, y;
‌‌‌‌　　};

#include <iostream>
#include <string>
‌‌‌‌　　using namespace std;

‌‌‌‌　　int main(){
    //求知讲堂2021C语言/C++视频99天完整版 学完可就业 day20 009_运算符重载实例 **
    // friend void pprint()(Point &p);
    Point a(1,1),b(2,2);
    Point c = a+b;
    pointPrint(c);

    return 0;
‌‌‌‌　　}
```

#### [day20 011_继承与多态的实例](https://www.bilibili.com/video/BV1fZ4y1F7Vt?p=194)

‌‌‌‌　　继承方式包括3种:公有继承public、私有继承private和保护继承protected。如果不显式地给出继承方式，<font color='red'>缺省的类继承方式是私有继承private。</font>

```c++
‌‌‌‌　　class A : public B, public C{
	...
‌‌‌‌　　};
```

‌‌‌‌　　多重继承指的是一个类可以同时从多于一个的父类那里继承行为和特征，然而我们知道Java为了保证数据安全，它**只允许单继承**。

‌‌‌‌　　[java提高篇(九)-----实现多重继承](https://www.cnblogs.com/chenssy/p/3389027.html)，这里法一是利用接口多继承，法二是创建多个内部类来多继承。都挺麻烦的，接口要重新写，内部类操作比较麻烦。

‌‌‌‌　　<img src="F:\Files\ACM\C++笔记assets\派生类对基类成员的访问权限.png" style="zoom: 67%;" />

‌‌‌‌　　假如派生类以public继承基类，基类B类中所有的数据、函数访问属性保持不变，而基类的私有成员不可在派生类中被访问：

```c++
‌‌‌‌　　class A : public B{}
```

‌‌‌‌　　假如派生类以protected继承基类，基类B类中所有的数据、函数访问属性变为protected，而基类的私有成员不可在派生类中被访问：

```c++
‌‌‌‌　　class A : protected B{}
```

‌‌‌‌　　假如派生类以private继承基类，基类B类中所有的数据、函数访问属性变为private，而基类的私有成员不可在派生类中被访问：

```c++
‌‌‌‌　　class A : private B{}
```



‌‌‌‌　　private只被类内访问。<font color='red'>protected声明的成员称为受保护的成员.它不能被类外访问，可以被派生类的成员函数访问。但是派生类对象无法访问父类protected数据。</font>

‌‌‌‌　　public所有对象可访问。在公有继承时，<font color='red'>派生类的成员函数可访问基类中的公有成员和保护成员;派生类的对象仅可访问基类中的公有成员。</font>C++语言习题与解析第二版(李春葆).pdf 190 (5)

‌‌‌‌　　对象比成员函数低一个级别。

‌‌‌‌　　如果在类体中既不写关键字private,又不写public ,就默认为private。在一个类体中，关键字private和public可以分别出现多次。每个部分的有效范围到出现另一个访问限定符或类体结束时(最后一个右花括号)为止。

‌‌‌‌　　**继承与派生关系，应该注意以下6点:**
‌‌‌‌　　1)一个类可以派生出多个派生类。
‌‌‌‌　　2)一个类可有一个或多个基类，称为单-继承和多重继承。
‌‌‌‌　　3)派生类又可有派生类，称为多级继承。
‌‌‌‌　　<font color='red'>4)继承关系不可循环。</font>
‌‌‌‌　　<font color='red'>5)构造函数和析构函数都不能被派生类所重载。</font>

```c++
‌‌‌‌　　B b;
‌‌‌‌　　b.~A();//A类是B类的父类，这里b无法显式调用基类A的析构函数，会报错，因为你不能代替别人去死，也不能代替别人出生。构造函数也无法显式调用。
‌‌‌‌　　b.~B();//没有问题
```

‌‌‌‌　　<font color='red'>6)友元不能被继承。</font>

#### [day20 012_子类构造函数的实例](https://www.bilibili.com/video/BV1fZ4y1F7Vt?p=195)

```c++
‌‌‌‌　　class People	//基类
‌‌‌‌　　{
    protected: 
        char* name;
        int age;
    public: 
     	People(){};
        People(char* name, int age);
‌‌‌‌　　};

‌‌‌‌　　class Student : public People	//派生类
‌‌‌‌　　{
    private:
    	float score;
    public :
    	Student(char* name, int age, float score);//因为子类有更多的属性，所以需要重写构造函数。
‌‌‌‌　　};

‌‌‌‌　　//这里后面的People的name, age在派生类初始化的时候赋值来自前面Student的char* name, age。
‌‌‌‌　　Student::Student(char* name, int age, float score) : People(name, age){
    this->score = score;
‌‌‌‌　　}
‌‌‌‌　　//正常的派生类构造写法，更清晰。需要基类写一个空的构造函数，否则报错People不存在默认的构造函数。
‌‌‌‌　　Student::Student(char* name, int age, float score){
    this->name = name;
    this->age = age;
    this->score = score;
‌‌‌‌　　}

```



### 千锋-嵌入式物联网教程 800集

‌‌‌‌　　这个教程包含内容：c,c++,qt,32,esp,js,，shell,makefile,一个ti的处理器，网络协议，linux应用。估计还没说全，虽然有些讲的都是表面，但能把这些学完，不懵逼，确实是人才。

#### [2.1-4.15构造函数的浅拷贝](https://www.bilibili.com/video/BV1FA411v7YW?p=220)

‌‌‌‌　　[精准空降](https://www.bilibili.com/video/BV1FA411v7YW?p=220&t=586.5)

‌‌‌‌　　我们一般写的拷贝函数是浅拷贝。假如你在构造函数里申请了堆区的内存（列如malloc、new创建变量），那么在析构函数里free或delete这个内存，这样没问题，但是假如你拷贝了A对象，新对象为B，那么A对象和B对象指向的堆内存是相同的，A对象的堆区释放了，而B对象还指向着A对象的堆区，这样会报错。这就是浅拷贝的问题。

```c++
‌‌‌‌　　Person (const Person &p){
    mAge = p.mAge;
‌‌‌‌　　}
```



#### [2.1-4.16拷贝构造函数的深拷贝](https://www.bilibili.com/video/BV1FA411v7YW?p=221)

```c++
‌‌‌‌　　Person (const Person &p){
    mAge = p.mAge;
    name = (char *)malloc(strlen(p.name)+1);
    strcpy(name, p.name)
‌‌‌‌　　}
```

### [嵌入式开发从基础到项目 2021 精品教程 大学生必备课程](https://www.bilibili.com/video/BV1EB4y1N7iD?p=5)

‌‌‌‌　　10.5万播放 · 总弹幕数450 2021-07-10 21:09:30

‌‌‌‌　　包括c、单片机、stm、rtos、linux和项目知识点



### 格式

#### [C++ cout 输出 16, 8 , 2进制](https://www.cnblogs.com/Robotke1/archive/2013/05/06/3063295.html)

```c++
#include <iostream>
#include <iomanip>
#include <bitset>
‌‌‌‌　　using namespace std;

‌‌‌‌　　cout<<char('A'+1)<<endl;//将数字以字符输出：
‌‌‌‌　　cout<<hex<<"Hex:"<<a<<endl;//16进制
‌‌‌‌　　cout<<oct<<"Oct:"<<a<<endl;//8进制
‌‌‌‌　　cout<<bitset<32>(a)<<endl;//2进制
```



### string

#### [C++基础-string截取、替换、查找子串函数](https://blog.csdn.net/ezhou_liukai/article/details/13779091)

1. ##### 截取子串

‌‌‌‌　　​    s.substr(pos, n)   截取s中从pos开始（包括0）的n个字符的子串，并返回

‌‌‌‌　　​    s.substr(pos)     截取s中从从pos开始（包括0）到末尾的所有字符的子串，并返回

#### [C++ String遍历、查找、替换、插入和删除](https://zhuanlan.zhihu.com/p/47035907)

‌‌‌‌　　**[C++中的string::compare的使用](https://blog.csdn.net/tao_627/article/details/53585899)**

```c++
‌‌‌‌　　if(str3.compare("apple") == 0)
        cout << str3 << " is an apple!" << endl;
```

‌‌‌‌　　为0则相同。

#### [C++中string的拼接](https://blog.csdn.net/ljp1919/article/details/48134335)

```c++
‌‌‌‌　　string str;
‌‌‌‌　　str += "a"; //采取引用对象效率更高
‌‌‌‌　　str = str+ "a";  //创建新的对象效率低
‌‌‌‌　　str = "a" + "b";  //这样写报错
‌‌‌‌　　str = str + "a" + "b";  //只能这样写
```

#### C++中数字转string

```c++
‌‌‌‌　　int task3_12(){
    int number,j;
    cout<<"请输入一个不多与5位的整数："<<endl;
    cin>>number;

    string str = to_string(number);
    cout<<"它是"<<str.size()<<"位数"<<endl;
‌‌‌‌　　}
```

#### %u && 字符串前的L

‌‌‌‌　　c语言中的%u是输入输出格式说明符，表示按unsigned int格式输入或输出数据。 %d 有符号10进制整数 %i 有符号10进制整数 %o 无符号8进制整数



‌‌‌‌　　字符串前面加L表示该字符串是Unicode字符串。

### char

#### [C++ str系列函数 （包含strtok用法）](https://blog.csdn.net/modiziri/article/details/41748421)



### 指针

#### 指针*与结构体取值

```c++
‌‌‌‌　　int *p;
‌‌‌‌　　int a;
‌‌‌‌　　//p->asd相当于a.asd
```

#### [C++中int \*p[4]和 int (\*q)[4]的区别](https://blog.csdn.net/ajioy/article/details/6951643)

‌‌‌‌　　前: 指针数组;是一个元素全为指针的数组.
‌‌‌‌　　后: 数组指针;可以直接理解是指针,只是这个指针类型不是int也不是char而是 int [4]类型的数组.(可以结合函数指针一并看看......)

‌‌‌‌　　int\*p[4]------p是一个指针数组，每一个指向一个int型的
‌‌‌‌　　int (\*q)[4]---------q是一个指针，指向int[4]的数组。或者写为`int [4](*q)`

‌‌‌‌　　两者在定义的时候如下：

‌‌‌‌　　int k;
‌‌‌‌　　cin>>k;

‌‌‌‌　　char *p[2];
‌‌‌‌　　p[0]=new char[k];
‌‌‌‌　　p[1]=new char[k];

‌‌‌‌　　char (*b)[2];
‌‌‌‌　　b=new char\[k][2];

#### 给结构体指针赋值

```c++
#include <iostream>
#include <map> // STL头文件没有扩展名.h
#include <vector>
#include <cstring>
#include <stdlib.h>
#include<iomanip>
#include <typeinfo>
‌‌‌‌　　using namespace std;

‌‌‌‌　　typedef  struct  AAA{
    int a;
‌‌‌‌　　} A,*pA;

‌‌‌‌　　typedef  struct  BBB{
        pA sta;
‌‌‌‌　　} B,*pB;

‌‌‌‌　　int main(){
    pA num1 = (pA)malloc(sizeof(A));//必须给指针结构体动态分配内存
    num1->a = 0;
    cout << num1->a << endl;
    // pB num2;
    // num->sta->a = 3;
    // cout << num2->sta->a <<endl;
    // return 0;
‌‌‌‌　　}
```

#### [书上讲指针法要比下标法访问数组速度快，是嘛？](http://bbs.chinaunix.net/thread-602420-1-1.html)

‌‌‌‌　　下标先取一次数组首地址，然后加上偏移，在取一次地址才得到实际的地址
‌‌‌‌　　指针直接取地址，相当于比下标少了第一个步骤

#### [声明结构变量时C++中可以省略结构struct](https://blog.csdn.net/smileufo/article/details/96483051)

‌‌‌‌　　Astruct a;//C++

‌‌‌‌　　struct Astruct a;//C或C++

‌‌‌‌　　所以有时候就不用使用typedef了

#### [指针常量和常量指针const* char 和 const char*](https://blog.51cto.com/u_6924918/1267052)

‌‌‌‌　　谭浩强 pdf 313

‌‌‌‌　　Time * const p;p是指向Time对象的常指针,p的值(即p的指向)不能改变
‌‌‌‌　　const Time * p;p是指向Time类常对象的指针,其指向的类对象的值不能通过指针来政变

### 多线程

‌‌‌‌　　[C++ 使用_beginthreadex创建线程、线程句柄(等待线程关闭)、线程id的作用(发送线程消息)](https://blog.csdn.net/qq_24127015/article/details/102799278)

### 学习书籍推荐

‌‌‌‌　　不看书，c++都写不了个像样的程序，语法是一方面，怎么用才是c++的精髓
‌‌‌‌　　推荐的书
‌‌‌‌　　Essential C++：快速了解和使用C++，字少，但涉及一些类语法，最适合没碰过C++的但有其它语言经验的，如果对编程一片空白还是看第二本吧。该书作者在工作中碰到要使用别的语言，但自己C++很好，需要一本能快速入门的书，又基础字又多的肯定不行，还好找到了这种书，所以他后来写了这一本，沿用了同一个前缀名
‌‌‌‌　　C++ Premier Plus：语法大全，太多所以不能快速入门，定位是基础，任何人都可以看，很厚，语法太多没办法，但是网上对语言的教学也是基础，有一个叫什么菜鸟C语言什么的网站挺好的，也是教语法的
‌‌‌‌　　在看懂语法后怎么写程序，语法用不对自己会感觉莫名其妙的，入门专用：Effective C++。More Effective C++。
‌‌‌‌　　讲类的继承，虚函数表指针，虚函数表，多重继承这些东西在内存中的排布，就是类的底层。该书作者参与了一个用C写C++编译器的开发，这些都是在这过程遇到的：Inside the C++ Object Model。
‌‌‌‌　　反正是名作：Effective STL。STL源码剖析。
‌‌‌‌　　这些书在最后都说了学习C++最后还得学STL(标准模板库)和标准C++
‌‌‌‌　　这些是我个人的意见

‌‌‌‌　　2020-01-18 01:28

‌‌‌‌　　所以rust的诞生是必须的。

‌‌‌‌　　2019-12-30 19:41



‌‌‌‌　　Rust为保证安全性过于复杂。

### 句柄是数组下班

‌‌‌‌　　【潜水】四川-^_^ 17:22:45
‌‌‌‌　　系统又要让你能用，又不能让你知道里面具体结构，然后就给你一个能操作的映射地址，好像是这样吧？

‌‌‌‌　　【潜水】成都-DLC 17:23:32
‌‌‌‌　　如果句柄是个指针，那么用户就可以获取指针指向的内存，从而有破坏内核内存的危险，windows肯定不会这样做，所以句柄只是存了个数，类似于数组下标，句柄存的就是下标的值，而用户指导下标，不知道数组在哪，所以无法破坏内核

‌‌‌‌　　【潜水】成都-DLC 17:24:49
‌‌‌‌　　然而这个句柄在32位下和64位下的大小应该都是和指针大小是一致的，所以在语言中它是个指针，但这个指针并不指向内存

### 用智能指针替代指针

‌‌‌‌　　effective c++早就建议用引用和智能指针替代了。



### 对象



#### [C++对象创建的几种方式 不同堆栈内存分配](https://blog.csdn.net/tkwxty/article/details/103186106)

```c++
#include<stdio.h>
‌‌‌‌　　using namespace std;
‌‌‌‌　　class ObjectClass{
‌‌‌‌　　public:
	void fun(){
		printf("Hello, Im c++ objectClass\n");
	}
‌‌‌‌　　};

‌‌‌‌　　int main(){
	ObjectClass obj1;//栈中分配  ，由操作系统进行内存的分配和管理
	ObjectClass obj2 = obj1; //栈中分配  ，由操作系统进行内存的分配和管理
	obj1.fun();//"." 是结构体成员引用
	obj2.fun();//"." 是结构体成员引用

	ObjectClass * obj3 = new ObjectClass(); //堆中分配  ，由管理者进行内存的分配和管理，用完必须delete()，否则可能造成内存泄漏
	obj3->fun();//->是指针引用
	delete(obj3);
	return 0;
‌‌‌‌　　}	

```



### [如何查看Dll中包含了哪些函数](https://blog.csdn.net/zztoll/article/details/105325155)

‌‌‌‌　　法2

```shell
‌‌‌‌　　"C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Tools\MSVC\14.29.30133\bin\Hostx64\x86\dumpbin.exe" /exports C:\Windows\SysWOW64\ws2_32.dll
```

### [C++关键字explicit的详解及用法cbNotes的博客](https://blog.csdn.net/cbNotes/article/details/39520205)
‌‌‌‌　　在C++中，explicit关键字用来修饰类的构造函数，被修饰的构造函数的类，不能发生相应的隐式类型转换，只能以显示的方式进行类型转换。

‌‌‌‌　　下面以具体实例来说明。
  建立people.cpp 文件，然后输入下列内容： 
```cpp
‌‌‌‌　　class People 
‌‌‌‌　　{ 
	public: 
	int age; People (int a)  {    age=a;  } 
‌‌‌‌　　};

‌‌‌‌　　void foo ( void ) 
‌‌‌‌　　{   
	People p1(10);  //方式一  
	People* p_p2=new People(10); //方式二  
	People p3=10; //方式三 
‌‌‌‌　　}
```
‌‌‌‌　　这段C++程序定义了一个类people，包含一个构造函数，这个构造函数只包含一个整形参数a，可用于在构造类时初始化age变量。
‌‌‌‌　　然后定义了一个函数foo，在这个函数中我们用三种方式分别创建了三个10岁的“人”。
‌‌‌‌　　第一种是最一般的类变量声明方式。
‌‌‌‌　　第二种方式其实是声明了一个people类的指针变量，然后在堆中动态创建了一个people实例，并把这个实例的地址赋值给了p_p2.
‌‌‌‌　　第三种方式就是我们所说的特殊方式，为什么说特殊呢？我们都知道，C/C++是一种强类型语言，不同的数据类型是不能随意转换的，如果要进行类型转换，必须进行显式强制类型转换，而这里，没有进行任何显式的转换，直接将一个整型数据赋值给了类变量p3. 
‌‌‌‌　　因此，可以说，这里进行了一次隐式类型转换，编译器自动将对应于构造函数参数类型的数据转换为了该类的对象，
‌‌‌‌　　因此方式三经编译器自动转换后和方式一最终的实现方式是一样的。

‌‌‌‌　　explicit关键字到底是什么作用呢？它的作用就是禁止这个特性。如文章一开始而言，凡是用explicit关键字修饰的构造函数，  
‌‌‌‌　　编译时就不会进行自动转换，而会报错。

下面的四个例子值得看。


### ‌‌‌‌[.hpp与.h区别](https://blog.csdn.net/f_zyj/article/details/51735416)
.hpp，本质就是将.cpp的实现代码混入.h头文件当中，定义与实现都包含在同一文件，则该类的调用者只需要include该.hpp文件即可，无需再将cpp加入到project中进行编译。而实现代码将直接编译到调用者的obj文件中，不再生成单独的obj，采用hpp将大幅度减少调用project中的cpp文件数与编译次数，也不用再发布lib与dll文件，因此非常适合用来编写公用的开源库。

hpp的优点不少，但是编写中有以下几点要注意：
1、是Header Plus Plus的简写。（.h和.hpp就如同.c和.cpp似的）
2、与.h类似，.hpp是C++程序头文件格式。
3、是VCL专用的头文件,已预编译。
4、是一般模板类的头文件。
5、一般来说，.h里面只有声明，没有实现，而.hpp里声明实现都有，后者可以减少.cpp的数量。
6、.h里面可以有using namespace std，而.hpp里则无。
7、不可包含全局对象和全局函数。
