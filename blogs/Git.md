### Git 指令使用

#### 更新My_Library/Important_thoughts/health库
```git
git status
git add Important_thoughts/health/*
git add Books/Psychology/*
git add blogs/travel*
git add "blogs/嵌入式&电子*"
git add plan/*
git add blogs/Git.md

git status

git commit -m "update health dir"
git commit -m "update 嵌入式&电子"
git commit -m "update travel dir"
git commit -m "update plan dir"
git commit -m "commit Git.md"

git push origin master
```

#### [上传本地文件（夹）到GitHub和更新仓库文件](https://zhuanlan.zhihu.com/p/136355306)

1. **git init** ：在此文件夹生成一个.git隐藏文件；
2. **git add .** : 将文件添加到缓存区( 注意这个"."，是有空格的，"."代表这个test这个文件夹下的目录全部都提交，也可以通过git add 文件名 提交指定的文件)；
3. **git status**：查看现在的状态，也可以不看，随你啦，可以看到picture文件夹里面的内容都提交上去了；
4. **git commit -m "这里是注释"**：提交添加到缓存区的文件
5. **git remote add origin [https://xxx](https://link.zhihu.com/?target=https%3A//xxx)@xxx/test.git** ： 添加新的git方式的origin, github上创建好的仓库和本地仓库进行关联
6. git push origin master : 把本地库的所有内容推送到远程仓库（github）上，即上传本地文件，如果显示下图，则说明上传成功

**可能遇到的报错**

error: failed to push some refs to https://github.com/xxx/test.git

7. 如果报上图的错误，则需要输入 git pull origin master命令；

- 如果报上图的错误， **其实这个问题是因为 两个 根本不相干的 git 库， 一个是本地库（只有picture）， 一个是远端库(test仓库里只有readme文件)， 然后本地要去推送到远端， 远端觉得这个本地库跟自己不相干， 所以告知无法合并 ，解决方法：先把两部分内容合并以下，有两种方式**

- - 方式一：输入“ `git pull --rebase origin master` ” ，然后输入git push origin master语句，即可

- - 方式二：输入“ git pull origin master --allow-unrelated-histories ”（会弹到文件里面，输入“:wq”退出该文件，如果没有遇到，请忽略），然后输入git push origin master语句，即可

#### [如何在 GitHub 提交第一个 pull request](https://www.freecodecamp.org/chinese/news/how-to-make-your-first-pull-request-on-github/)
学习分支使用，增加新特性的备份。

另一个参考博客：
[Github pull request详细教程（提交代码到他人仓库）\_github提交代码到别人仓库\_I an的博客-CSDN博客](https://blog.csdn.net/CY2333333/article/details/113731490)

#### [git命令删除缓存区（git add）的内容_zlq_csdn的博客 ](https://blog.csdn.net/zlq_CSDN/article/details/83794900)



1、git rm --cached +文件名 ->这个命令不会删除物理文件，只是将已经add

进缓存的文件删除。

2、git rm --f +文件路名 ->这个命令不仅将文件从缓存中删除，还会将

物理文件删除，所以使用这个命令要谨慎。

3、若删除已经添加缓存的某一个目录下所有文件的话需要添加一个参数 -r

git rm -r --cached 文件名

#### [git status：查看现在的状态](https://zhuanlan.zhihu.com/p/136355306)

**git status**：查看现在的状态，也可以不看，随你啦，可以看到picture文件夹里面的内容都提交上去了；



### Git

#### [常用 Git 指令](https://www.javanav.com/val/25275ed95c914a94978c7f3046533962.html)

  2020-12-09

<img src="Git.assets\image__20201210113653.png" alt="img"  />

#### [important 十分钟学会正确的github工作流，和开源作者们使用同一套流程](https://www.bilibili.com/video/BV19e4y1q7JJ/)

1.git clone // 到本地
2.git checkout -b xxx 切换至新分支xxx
（相当于复制了remote的仓库到本地的xxx分支上
3.修改或者添加本地代码（部署在硬盘的源文件上）
4.git diff 查看自己对代码做出的改变
5.git add 上传更新后的代码至暂存区
6.git commit 可以将暂存区里更新后的代码更新到本地git
7.git push origin xxx 将本地的xxxgit分支上传至github上的git
\-----------------------------------------------------------
（如果在写自己的代码过程中发现远端GitHub上代码出现改变）
1.git checkout main 切换回main分支
2.git pull origin master(main) 将远端修改过的代码再更新到本地
3.git checkout xxx 回到xxx分支
4.git rebase main 我在xxx分支上，先把main移过来，然后根据我的commit来修改成新的内容
（中途可能会出现，rebase conflict -----》手动选择保留哪段代码）
5.git push -f origin xxx 把rebase后并且更新过的代码再push到远端github上
（-f ---》强行）
6.原项目主人采用pull request 中的 squash and merge 合并所有不同的commit
\----------------------------------------------------------------------------------------------
远端完成更新后
1.git branch -d xxx 删除本地的git分支
2.git pull origin master 再把远端的最新代码拉至本地

2022-10-05 21:55👍484

#### [【小技巧】(超详细！)解决Github无法显示图片以及README无法显示图片](https://blog.csdn.net/qq_41709370/article/details/106282229)

也有说是DNS污染了，这里简要介绍一下DNS 污染：网域服务器缓存污染（DNS cache pollution），又称域名服务器缓存投毒（DNS cache poisoning），是指一些刻意制造或无意中制造出来的域名服务器数据包，把域名指往不正确的IP地址。一般来说，在互联网上都有可信赖的网域服务器，但为减低网络上的流量压力，一般的域名服务器都会把从上游的域名服务器获得的解析记录暂存起来，待下次有其他机器要求解析域名时，可以立即提供服务。一旦有关网域的局域域名服务器的缓存受到污染，就会把网域内的计算机导引往错误的服务器或服务器的网址。

尝试配置hosts文件，直接指向github的服务器。用ipaddress查一下raw.githubusercontent.com 的ip

修改hosts文件，mac的hosts在

```markdown
/etc/hosts
```

添加

```python
199.232.68.133 raw.githubusercontent.com
199.232.68.133 githubusercontent.com
```

这三种路径都可以：

```shell
![contents](./contents.png)
![contents](https://github.com/RGNil/2020MCM_paper/raw/master/contents.png)
![contents](https://github.com/RGNil/2020MCM_paper/blob/master/contents.png)
```





#### [如果不删除缓存，修改的.gitignore文件不会生效](https://www.jianshu.com/p/85c2b19a09cc)

这种方式可以应用于修改.gitignore文件后，如果不删除缓存，修改的.gitignore并不会生效，仓库仍然会有忽略的文件。



不删除，下次有修改后提交，只会更新修改的部分。



#### [Git——三大分区【工作区 / 暂存区 / 版本区】](https://blog.csdn.net/qq_36749906/article/details/113722282)

1. 工作区
  Git的工作区也就是我们平时编辑代码的目录文件夹。

2. 暂存区
  暂存区就是一个暂时放置修改文件记录的地方。以往仓库中放货物为例，向仓库中放货物总是一车车的拉，因为如果货物一件件的拉，当想回到之前某个状态时，需要把货物一件件往外撤，当数量很大时会加大管理难度。如果把货物一车车拉货拉进仓库，那么若想回到之前某个状态，只需要拿走几车货就好，减少了操作管理难度。

  所以暂存区的作用是将要多个文件的多处修改暂时存储，最后将这些修改作为一个版本提交。

3. 版本区
  版本区可以看作是一个仓库，每次将暂存区中打包好后修改的东西送到仓库中，是各种修改的版本信息最后存储的地方。

4. 三个区的切换命令
4.1 工作区 => 暂存区 —— git add
  git add可将多个文件添加到暂存区。

$ git add readme.md Test1.py
1
4.2 暂存区 => 版本区 —— git commit
  git commit将暂存区当中的所有文件一次性提交到版本区，-m参数后跟着每次提交说明，对哪些地方进行修改的简述。

$ git commit -m "commit the last Version"
1
4.3 版本区 => 暂存区 —— git reset --mixed
  git reset命令--mixed跟着版本号，是指把该版本号提交的内容从版本区位置回滚到暂存区。

$ git reset --mixed d5d43ff
1
4.4 暂存区 => 工作区 —— git reset --soft
  git reset命令--soft跟着版本号，是指把该版本号提交的内容从暂存区位置回滚到工作区。

$ git reset --soft d5d43ff
1
4.5 版本区 => 暂存区 => 工作区 —— git reset --hard
  git reset命令--hard跟着版本号，是指把该版本号提交的内容从版本区位置回滚到工作区。

$ git reset --hard d5d43ff




#### [密码泄漏到 GitHub 会发生的](https://github.com/ruanyf/weekly/blob/master/docs/issue-134.md)

2、[密码泄漏到 GitHub，会发生什么？](https://threadreaderapp.com/thread/1324360905237372929.html)

几天前，我做了一个小实验，故意生成了一个假的 AWS 密钥，将其提交到公共存储库，看看会发生什么。

我先向 GitHub 推送。

- 15:27，我推送了带有密钥的提交。
- 15:34（7分钟后），我收到了 @GitGuardian 的电子邮件，通知我可能有密钥泄漏。
- 15:38（11分钟后），有人开始拿这个密钥入侵我的账户。

接下来的2小时内，我又收到了5条警报，分别来自德国、荷兰、英国和乌克兰。根据 User-Agent，入侵的脚本机器人使用 Python 和 Node.js SDK。

接着，我又向 GitLab 推送。

- 16:24，我推送了带有密钥的提交。
- 17:26（62分钟后），第一次入侵来自法国。根据 User-Agent，入侵脚本使用了 Python SDK。

我没有从 GitLab 收到任何提醒或警告。我知道 GitLab 确实提供了此功能，可悲的是，它们仅适用于付费用户。

结论：

1. 入侵者对 GitHub 的扫描多于 GitLab 。
2. 如果使用 GitHub，则应使用 @GitGuardian。
3. 如果使用 GitLab，最好升级到付费用户。



#### [形象讲解git]( https://www.zhihu.com/question/29894004/answer/46237730)

**举个栗子：**你在大家上随便找了个人，看人家的衣服很漂亮。你按照别人的衣服样式，自己复制了一份(**clone**)，别人既然穿出来了，就不怕他人抄。

过了一段时间，人家觉得有些地方不够美观，进行了一些改动，然后再次穿到自己身上秀出来了(**push**)。

这个时候你仍然可以将新改动的部分再次抄过来(**fetch**)，然后合并到你的衣服上(**merge**)。这两步可以合并为一步，即**[pull](https://www.zhihu.com/search?q=pull&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A46237730})**。

后来，你觉得衣服的有些部分不够美观，如你想把长袖改成短袖。没问题，你自己改，改完后穿上(**commit**)也觉得很美，你想“既然这么美，要不把改动也告诉给别人吧”，然后你**duang**就想上前拉住别人，“**来来来，看看我的改动好不好**”。别人肯定会想“**你谁啊？有病吧？**”

问题出现了，如果你本身是一个很牛X的服装设计师，看到有些人的衣服设计的实在是太烂，完全看不下去了，你下定决心，“我要更漂亮、更实用、更节能”。那么怎么办？

第一步：要先**知会**(**[fork](https://www.zhihu.com/search?q=fork&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A46237730})**)一下对方，“**我要针对你的设计进行调整了**”

第二步：你仍然需要先**复制(clone)**一份，你肯定不能直接在别人身上改动吧

第三步：修改完成后，需要自己先**上身(commit)**看看效果

第四步：如果对于改动满意，那么好，这个时候就可以**告知(push)**对方，"**我刚才说要对你的设计进行修整，现在是修整后的效果，你看看，满意否？**"

当然，这个时候，对方是不是接受，那就看人家具体的意愿啦。=====================================================================

所以，我的理解是，**如果你想push，请先fork**；**如果只是拿来主义，那么直接clone然后pull就可以了**。

这个设计理念应该是包含了人与人直接最基本的一个**尊重**。

[编辑于 2015-05-13 08:37](http://www.zhihu.com/question/29894004/answer/46237730)





#### [Git的奇技淫巧](https://github.com/youngyangyang04/git-tips)

简明，又详细。

#### [gitee和github比较](https://www.zhihu.com/question/384541326/answer/2456270379)

[发布于 2022-04-25 10:51](https://www.zhihu.com/question/384541326/answer/2456270379)

对于gitee客观来说，充满了铜臭的味道。对于个人开源开发者，非常不友好。总共5G的空间，所有项目加起来共5个协作者（如果你有多个项目，每个项目是不同的协作者的话，那就很多限制了）。在当前米国全力大打中国的情况下，gitee并没有放开胳膊拥抱中国开发者，而是诸多限制，有兴趣的去验一下就知道了。对于开大源库的下载，一定要登录才能下载...

github相对来说，则对开发者相对比较友好，就是不限空间之前，也比gitee强很多。除了速度慢，各方面都比gitee强好多。

gitee一开始格局就比github小很多，开源之火，还没有烧起来，就只想着赚钱...


#### [IDEA中项目集成git提交代码详细步骤](https://blog.csdn.net/qq_34377273/article/details/109157116)

2020-10-19 14:14:51





#### git还是svn？



[ma100](https://www.zhihu.com/people/ma100)2014-09-24

有一个强力领导的用git, 真正分布式开发模块用svn



[leonWang](https://www.zhihu.com/people/leon2017)2016-02-18

这，不好说，项目大的话git，平常的svn，毕竟svn比git上手快，不过貌似越来越多企业从svn转git了。版本控制嘛，这两个自然都要懂啊👍2

##### SVN目录权限设置好

[Nate](https://www.zhihu.com/people/sdf-asdf-22)2018-02-24

我也是喜欢用SVN的，SVN有很多特性Git是做不到的，比如目录权限设置，checkout子目录。另外推荐个好用的SVN仓库[http://svnbucket.com](http://link.zhihu.com/?target=http%3A//svnbucket.com)
知乎用户2017-05-27
作为老板，有员工离职你就知道svn其实也挺好的。。。👍3

[KiwiZhang](https://www.zhihu.com/people/KiwiPapa)回复知乎用户2018-01-11

这个跟SVN和Git关系不大。SVN一样有本地文件，只是没有log记录。他真想偷代码，记录一些重要log还是很容易的。Git一样可以分库给权限，一样可以只有几个人拥有全部代码权限。
其实最关键的是，一定要按组分工，不要让一个人啥都干，啥都干意味着啥都知道，门清儿，这人一走代码没有秘密。国内没有版本管理工具的公司不一样可以把代码拷走么？

[Bowen](https://www.zhihu.com/people/bowen1020)回复知乎用户2018-03-03
哈哈，我明白你意思。但其实有些东西防不住的。

##### [svn和git相比的优点，我认识到的主要有三点:](https://www.zhihu.com/question/399890301/answer/1270678917)

1. svn操作相对简单。
2. svn可以只操作某个文件或者某个文件夹。
3. svn管理二进制文件更方便。

svn对于非开发人员来说，操作是相当简单的。尤其是windows上，tortoise svn里鼠标点点checkout，update，commit这几个操作就可以了。而很多开发人员对git的理解和使用是一团糟。

各种文档按照目录划分好，给不同的人配置访问操作不同目录的权限，用svn是非常方便的。用git的话，需要服务器端支持，而且可能做不到文件文件夹粒度的。像gerrit，只能在仓库和分支粒度上进行权限控制。免费版的gitlab就更粗放了，不知道收费版的gitlab怎么样，还没用过。

svn可以只操作一个文件，但git是以commit为基本操作单位的。一个commit引用到了一个版本所有的文件和文件夹。如果其中包含了很多二进制文件的话，克隆一个仓库可能动辄几G几十个G。虽然有一些优化方法，但明显没有svn想要哪个就下载哪个来的方便。git可以通过创建指向tree和blob对象的tag来操纵一个目录或者一个文件，但目前还没有很好的官方实现。“部分克隆”功能虽然在release notes里提到了，还没实装。以后即使实装了，操作起来估计也不会很方便，又有新命令和一大堆参数要学习。如果学校只教svn的话，那就好好学习svn。git通过自学也是没问题的，网上有很多不错的教程。我强烈推荐pro git这本书。

[编辑于 2020-06-08 10:34](http://www.zhihu.com/question/399890301/answer/1270678917)

SVN是中心化版本控制系统，GIT是分布式版本控制系统。

##### SVN能进行项目目录级别的读、写、访问权限控制，而GIT做不到

权限控制，SVN能进行项目目录级别的读、写、访问权限控制，而GIT做不到，因为GIT是针对开源项目开发，所以GIT通过分支合并时的审查策略来勉强绕过此问题。仓储大小，SVN代码全记录在服务器中，GIT每份仓库Clone都拥有代码的全记录，意味着对于SVN而言，服务器的才是全的，你下载下来的可以小一点。而对于GIT，你下下来的，和服务器上的是一样的。所以使用SVN，会减少各开发机的物理空间占用。不过这不一定意味着传输时间的减少，因为git是自带压缩传输的，而svn没有。
[编辑于 2020-06-07 06:10](http://www.zhihu.com/question/399890301/answer/1268640993)

##### 绝大部分公司没什么可保密的

除了2014年工作的第二家公司使用 SVN 之外，之后所有公司都适用 git。有人说 SVN 相比 git 可以设置目录权限，但是绝大部分公司不需要这个，没什么可保密的。

[发布于 2020-06-07 01:11](https://www.zhihu.com/question/399890301/answer/1268521868)



##### [企业使用git多一些，原因如下：](https://zhidao.baidu.com/question/1991938638077555307.html#:~:text=git%E6%98%AF%E5%88%86%E5%B8%83%E5%BC%8F%E7%AE%A1,%E4%B8%AA%E4%BB%A3%E7%A0%81%E5%BA%93%E5%B0%B1%E5%AE%8C%E4%BA%86%E3%80%82)

2018-04-09

- 因为git版本库占用空间小；
- git是分布式管理系统，完全可以不对代码进行备份；
- git不用时时联网查询；
- 如果客户端离服务器端非常远，在网速糟糕的情况下，用svn下载代码速度远不上git。



#### bug1:git push 报错

想上传el-admin项目的更新：

```
git push -u origin master
```

**description:**

```bash
git提交报错fatal: unable to access ‘https://github.com/tata20191003/autowrite.git/‘: Failed to connec
```

##### [**solution1 failed:**](https://blog.csdn.net/qq_36257146/article/details/116736207)

参考：[Linux 系统查看代理，关闭代理](https://blog.csdn.net/weixin_44984664/article/details/108028704)

无论开启或者关闭本机的clash代理都无效，但是git clone还是能下载代码。所以是git bash的代理无法走clash，需要在git中额外设置代理：

```
export http_proxy=http://192.168.2.14:7890
export https_proxy=http://192.168.2.14:7890
```

有登录验证的窗口弹出，但是输入密码后验证失败。

<img src="Git.assets/image-20220610123545382.png" alt="image-20220610123545382" style="zoom:50%;" />

这个窗口结束后，有出现一个窗口需要再次验证，但是结果是失败的：

```bash
Logon failed, use ctrl+c to cancel basic credential prompt.
remote: Support for password authentication was removed on August 13, 2021. Please use a personal access token instead.
remote: Please see https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/ for more information.
fatal: Authentication failed for 'https://github.com/UryWu/eladmin/'
```

看到上面的链接，指示信息如下：

- If you have [two-factor authentication](https://help.github.com/en/github/authenticating-to-github/securing-your-account-with-two-factor-authentication-2fa) enabled for your account, you are already required to use token- or SSH-based authentication.

你已经使用ssh验证？那不是可以直接上传？



##### [**solution2 failed:**](https://blog.csdn.net/qq_35495339/article/details/92847819)

重新生成密钥还是失败：

[Github 生成SSH秘钥（详细教程）](https://blog.csdn.net/qq_35495339/article/details/92847819)

查看邮箱

```bash
git config user.email
```

查看用户名

```bash
git config user.name
```

设置邮箱

```bash
git config --global user.email 'urywu@qq.com'
```

同样的报错：

```bash
Logon failed, use ctrl+c to cancel basic credential prompt.
giremote: Support for password authentication was removed on August 13, 2021. Please use a personal access token instead.
remote: Please see https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/ for more information.
fatal: Authentication failed for 'https://github.com/UryWu/eladmin/'
```

##### [**solution3:**](https://cloud.tencent.com/developer/article/1861466)

参考：[GitHub不再支持密码验证解决方案：SSH免密与Token登录配置](https://cloud.tencent.com/developer/article/1861466)
发布于2021-08-14 19:34:12

<font color='red'>密码验证于2021年8月13日不再支持，也就是今天intellij不能再用密码方式去提交代码。请用使用 personal access token 替代。</font>



因为https代码源无法使用token登录，所以只能改用ssh源了。

更改本地git项目工程源为ssh的源：

```bash
git remote set-url origin git@github.com:UryWu/eladmin.git
```

查看本地[.git\config](F:\Projects\projects_java\work\Intelligent_legal_affairs_platform\el-admin\eladmin\.git\config)文件，已经修改代码源，但是无用，config文件如下：

```bash
[core]
	repositoryformatversion = 0
	filemode = false
	bare = false
	logallrefupdates = true
	symlinks = false
	ignorecase = true
[remote "origin"]
	url = git@github.com:UryWu/eladmin.git
	fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
	remote = origin
	merge = refs/heads/master
[guser]
	email = ‘urywu@qq.com
```

这里两个ssh代码源对比：

```
git@github.com:UryWu/eladmin.git  # 这个是github原生的
git@ssh.fastgit.org:UryWu/eladmin.git  # 是fastgit镜像加速，服务器在香港
```



```
https://github.com/UryWu/eladmin.git  # 这是https代码源
```

上传成功！

**<font color='red'>注意</font>**，不要使用fastgit的SSH源，否则会无法git push，验证失败：

```bash
$ git push -u origin master
ssh: connect to host ssh.fastgit.org port 22: Connection refused
fatal: Could not read from remote repository.
Please make sure you have the correct access rights
and the repository exists.
```

最好使用github原生的代码源。



##### [solution4 token:](https://blog.csdn.net/qq_43382853/article/details/119221234)

[github令牌验证（密码验证将要失效）](https://blog.csdn.net/qq_43382853/article/details/119221234)

于 2021-07-29 21:42:20 发布





##### 参考命令：

[Linux 系统查看代理，关闭代理](https://blog.csdn.net/weixin_44984664/article/details/108028704)

查看代理

```shell
env|grep -i proxy
```

关闭代理

```shell
 export http_proxy=""
 export https_proxy=""
 export HTTP_PROXY=""
 export HTTPS_PROXY=""
```

开启代理

```shell
 export http_proxy="http://192.168.2.14:7890"
 export https_proxy="http://192.168.2.14:7890"
 export HTTP_PROXY="http://192.168.2.14:7890"
 export HTTPS_PROXY="http://192.168.2.14:7890"
```







#### 不要用 git push --force

1、[git push --force-with-lease](https://blog.csdn.net/wpwalter/article/details/80371264)（中文）

不要用 git push --force，而要用 git push --force-with-lease 代替。在你上次提交之后，只要其他人往该分支提交给代码，git push --force-with-lease 会拒绝覆盖。



#### [互联网公司用Git还是SVN多呢？](https://www.zhihu.com/question/67044963)



#### [如何在github上提交PR(Pull Request)](https://cloud.tencent.com/developer/article/1999727)



#### ssh忘记密码

先把github上我的ssh key删掉：

<img src="Git.assets/image-20230324102555625.png" alt="image-20230324102555625" style="zoom:50%;" />

<img src="Git.assets/image-20230324102631944.png" alt="image-20230324102631944" style="zoom: 50%;" />

打开C:\Users\UryWu\.ssh，在这里打开一个cmd窗口，输入：

`ssh`

然后输入密码，确定覆盖。

然后把id_rsa.pub里的内容粘贴到github的Authentication Keys里。



#### [**Git 的奇技淫巧 简单指令与解释**](https://hellogithub.com/article/9aed28d4d64b4649bb364685ef557ae4)



#### [git-sim repo可视化](https://github.com/initialcommit-com/git-sim#git-sim)





### [使用 SSH 密钥密码](https://docs.github.com/zh/authentication/connecting-to-github-with-ssh/working-with-ssh-key-passphrases#adding-or-changing-a-passphrase)

### svn

[SVN使用教程 - 快速上手\_哔哩哔哩\_bilibili](https://www.bilibili.com/video/BV1k4411m7mP/)
更多文字版教程：https://svnbucket.com/posts/
这是最好的SVN教程了，我对这个结论负责...

svn是什么？
	代码版本管理工具
	它能记住你每次的修改
	查看所有的修改记浓
	恢复到任何历史版本
	恢复已经删除的文件

SVN限Git比，有什么优势
	使用简单，上手快
	目录级权限控制，企业安全必备
	子目录Checkout，成少不必要的文件检出
	主要应用：
	开发人员用来做代码的版本管理
	用与存储一些重要的文件，比合同
	公可内部文件共享，并几能按日录划分权限

SVN仓库
	推荐：svnbucket.com,SVN桶
	现在最好用的服务

安装SVN客户端
	windows:TortoiseSVN
	Mac:Cornstone


### [一张图看懂开源协议的区别](https://zhuanlan.zhihu.com/p/272543821)

![image-20230723064735038](Git.assets/image-20230723064735038.png)


#### [最近几年的国内开源软件侵权事件](https://blog.csdn.net/sunjing/article/details/4815685)

[麒麟操作系统](https://so.csdn.net/so/search?q=%E9%BA%92%E9%BA%9F%E6%93%8D%E4%BD%9C%E7%B3%BB%E7%BB%9F&spm=1001.2101.3001.7020)与FreeBSD代码事件

麒麟操作系统是由国防科技大学、中软公司、联想公司、浪潮集团和民族恒星公司合作研制的闭源服务器操作系统。此操作系统是863计划重大攻关科研项目，目标是打破国外操作系统的垄断，研发一套中国自主知识产权的服务器操作系统。
在2006年4月27日网友Dancefire的一篇技术分析文章中指出，通过对麒麟操作系统进行反汇编，麒麟操作系统与美国开放源代码的FreeBSD 操作系统5.3版本相似度竟然在90%以上。更多的证据指出，麒麟操作系统仅仅是对开源的FreeBSD进行了一定的修改，根本不是新闻媒体所说的 “中国独立研发成功”和“拥有完全自主版权的内核”。

匿名用户2010.01.09 
freebsd的协议好像是自由使用的吧，不要求公开源码的，苹果os也是基于freebsd内核做的界面，同样不公开源代码。如果麒麟真的是如文中所说那样，顶多只能算是抄袭，而不是侵权



企业侵犯开源软件很危险

上面列出的三个事件，只是冰山一角，企业主体都是大型的软件公司，包括互联网NO1的腾讯，还有国防科技大学。应该说对于软件的版权和知识产权都是相当的了解，还记得腾讯起诉珊瑚虫版QQ作者陈寿福吗？企业侵犯开源软件是相当危险的，采用GPL许可证的开源软件，在国际上有很多胜诉案例。

2009年9月22日在巴黎AFPA上诉法院裁决EDU4公司违反了GNU GPL协议，在分发软件时只提供了二进制文件，而拒绝提供源代码。这个诉讼是法国的一个教育组织AFPA提出的。在2000年，AFPA从Edu4那里购买了新的课堂使用的计算机设备。不久，AFPA发现随设备分发的一个使用GPL 协议的VNC软件。但是经过多次交涉，Edu4拒绝提供这个版本VNC的源代码，同时Edu4在被发现后，还删除了软件中的版权与许可声明。这些行为都违反了GPL许可条款的规定。

2007年2月Skype被起诉违反了GPLv2许可协议，自由软件基金会(FSF,Free Software Foundation)认为Skype基于Linux的Skype WiFi电话使用了GPLv2代码，但却没有按照许可证的要求发布修改后的代码。德国一法庭调查后认定事实确凿，宣判Skype违反了协议规定，GPL获得胜利。随后Skype表示不服判决，上诉至慕尼黑的德国高等法院。上周四，Skype撤回了上诉请求。

2006年位于德国GmbH的D-Link德国分部因违法GPL受到了惩罚，这次诉讼案件是由Harald Welte发起的，他是一位有名的Linux开发人员。D-Link德国公司在他们的D-GSM600 NAS产品中使用了Linux内核和其他GPL授权的代码，但是他们没有附带相关的授权协议说明，或者说如何获得相关代码。