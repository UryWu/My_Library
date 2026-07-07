### [一日一技：如何从多个Jupyter Notebook中找到需要代码段](https://cloud.tencent.com/developer/article/1480586)

#### macOS or Linux:

```shell
ls *.ipynb | xargs grep "keyword"
```



包含空格和引号：

```shell
find *.ipynb -print0 | xargs -0 grep '未闻Code'
```



#### windows：

##### **方法 1：使用 CMD（`findstr` 命令）**

###### **基本命令**

```
findstr /n /i "keyword" *.ipynb
```

###### **参数说明**

- `/n`：显示匹配行的**行号**。
- `/i`：忽略大小写（如需区分大小写，则去掉此参数）。
- `"keyword"`：要搜索的关键词（支持简单的正则表达式）。
- `*.ipynb`：仅搜索 `.ipynb` 文件（可替换为 `*.*` 搜索所有文件）。

###### **示例输出**

```
test1.ipynb:5:print("This line contains keyword")
test2.ipynb:10:# keyword is here
```

###### **递归搜索子目录**

```
findstr /s /n /i "keyword" *.ipynb
```

- `/s`：递归搜索所有子目录。

------

##### **方法 2：使用 PowerShell（`Select-String` 命令）**

###### **基本命令**

```
Get-ChildItem -Filter *.ipynb | Select-String -Pattern "keyword" -CaseSensitive
```

###### **参数说明**

- `-Filter *.ipynb`：仅搜索 `.ipynb` 文件。
- `-Pattern "keyword"`：要搜索的关键词（支持正则表达式）。
- `-CaseSensitive`：区分大小写（忽略大小写则去掉此参数）。

###### **示例输出**

```
test1.ipynb:5:print("This line contains keyword")
test2.ipynb:10:# keyword is here
```

###### **递归搜索子目录**

```
Get-ChildItem -Recurse -Filter *.ipynb | Select-String -Pattern "keyword"
```

- `-Recurse`：递归搜索所有子目录。

###### **高亮显示关键词**

```
Get-ChildItem -Filter *.ipynb | Select-String -Pattern "keyword" | ForEach-Object {
    Write-Host "$($_.FileName):$($_.LineNumber):$($_.Line)" -ForegroundColor Yellow
}
```

- 匹配的行会以黄色高亮显示。

------

e.g:

```shell
Get-ChildItem -Filter *.ipynb | Select-String -Pattern ".format" | ForEach-Object {
    Write-Host "$($_.FileName):$($_.LineNumber):$($_.Line)" -ForegroundColor Green
}
```



##### **方法 3：输出到文件**

###### **CMD**

```
findstr /n /i "keyword" *.ipynb > results.txt
```

- 将结果保存到 `results.txt` 文件。

###### **PowerShell**

```
Get-ChildItem -Filter *.ipynb | Select-String -Pattern "keyword" | Out-File -FilePath results.txt
```

- 将结果保存到 `results.txt` 文件。

------

##### **总结**

| **功能**       | **CMD (`findstr`)**               | **PowerShell (`Select-String`)**         |
| :------------- | :-------------------------------- | :--------------------------------------- |
| **基本搜索**   | `findstr /n "keyword" *.ipynb`    | `Select-String -Pattern "keyword"`       |
| **递归搜索**   | `findstr /s /n "keyword" *.ipynb` | `Get-ChildItem -Recurse | Select-String` |
| **区分大小写** | 默认不区分（`/i` 忽略）           | `-CaseSensitive`                         |
| **高亮显示**   | ❌ 不支持                          | ✅ 支持（`Write-Host`）                   |
| **输出到文件** | `> results.txt`                   | `| Out-File results.txt`                 |

**推荐使用 PowerShell**，因为它功能更强大，支持正则表达式和高亮显示，适合复杂搜索需求。



### Variable Inspector不好用，不如PySnooper

[【Jupyter notebook设置】 墙裂推荐Variable Inspector | DeBug工具PySnooper | 暗色系个性化\_Suexy\_的博客-CSDN博客](https://blog.csdn.net/Suexy_/article/details/102516961)

PySnooper可以知道代码具体运行情况，对于查看函数内部运转十分有用！！举一个简单的例子：
![](jupyter%20lab使用.assets/image-20230722113405724.png)


### [vscode-jupyter与jupyterlab的比较 - 知乎](https://zhuanlan.zhihu.com/p/493282170)

#### jupyterlab插件垃圾、debug弱


#### vscode-jupyter markdown渲染差 速度慢
[QuarkQuartet](https://www.zhihu.com/people/eafe8b210b09c9b8a361e2c9902c616f)
vscode jupyter的markdown字体渲染非常烂，标题字体非常大，正文非常小。无论你怎么调字体，这个比例大小是不会变的。再看看google colab的界面渲染，真是一个天上一个地下。
2022-06-14


### bug

#### bug1:markdown cell无法渲染、跳转
**description:**
jupyter lab左侧的标题栏无法跳转。
当cell中的markdown已经渲染的时候可以点击左侧的目录跳转：
![](jupyter%20lab使用.assets/image-20230722105605014.png)

当markdown cell变为源代码模式的时候则无法跳转，但有时可以跳转，大部分时候不可以跳转。
![](jupyter%20lab使用.assets/image-20230722105704309.png)

**solution 1:**
总结：
ctrl+enter或控制台输入并执行：Render Markdown on Cells

解决过程：
[Add "Render all markdown cells" command, or automatically render markdown](https://github.com/jupyterlab/jupyterlab/issues/6017#top)
**[maresb](https://github.com/maresb)** commented [on Mar 8, 2019](https://github.com/jupyterlab/jupyterlab/issues/6017#issuecomment-470839618)
Thanks for all the feedback, and for explaining the mouse-click issue. If I understand correctly, it sounds like it may be feasible to implement a toggle setting "Render Markdown on Cell Exit", assuming that by default it is set to "off"?
点击View->Activate Command Palette
![](jupyter%20lab使用.assets/image-20230722111523839.png)
输入并执行：Render Markdown on Cells

只要输入：rena，就能显示Render Markdown on Cellsx选项了。

![](jupyter%20lab使用.assets/image-20230722111619601.png)
所有进入编辑模式的markdown重新渲染，又可以点击目录来跳转了。
如果渲染后还是不能跳转，就得刷新网页页面。


#### bug2:升级jupyter lab到4.0之后无法打开
**description:**
I upgraded the jupyter lab into version 4.0.2, then I cannot launch jupyter lab and receive the error message like this:
```shell
No module named jupyterlab
```

Exception output:

**solution:**
卸载后重装，实在不行再创一个新的conda环境。

#### bug3:原来能执行的代码未经变动执行报错
**description:**

**solution:**
重启jupyter lab

#### bug42:runoob的代码点击拷贝入jupyter lab运行报字符错误
**description:**
When execute code:
点击右边的这个复制，会复制到一些无法执行的，看不见的字符。
![](jupyter%20lab使用.assets/image-20230722152258718.png)

Exception output:
```shell
SyntaxError: invalid character in identifier
```

**solution:**
需要手动选中复制。
![](jupyter%20lab使用.assets/image-20230722152354701.png)

