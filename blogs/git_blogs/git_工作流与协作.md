# Git 工作流与协作

多人协作的核心套路：fork → clone → 分支开发 → push → PR → 合并 → 清理。本篇把这条主链路串起来。

---

## 目录

1. [正确 GitHub 工作流](#正确-github-工作流)
2. [提交第一个 Pull Request](#提交第一个-pull-request)
3. [三大分区：工作区 / 暂存区 / 版本区](#三大分区工作区--暂存区--版本区)
4. [形象讲解 git：fork / clone / push / pull](#形象讲解-gitfork--clone--push--pull)
5. [DNS 污染导致 GitHub 图片不显示](#dns-污染导致-github-图片不显示)
6. [如何在 GitHub 上提交 PR](#如何在-github-上提交-pr)

---

## 正确 GitHub 工作流

参考：[十分钟学会正确的 GitHub 工作流，和开源作者们使用同一套流程](https://www.bilibili.com/video/BV19e4y1q7JJ/)

### 主流程（开发新特性）

```bash
1. git clone                       # 把远端仓库复制到本地
2. git checkout -b xxx             # 切换到新分支 xxx
   # （相当于把 remote 的仓库复制到本地的 xxx 分支上）
3. 修改 / 添加代码
4. git diff                        # 查看自己的改动
5. git add                         # 把改动加入暂存区
6. git commit -m "..."             # 把暂存区的更新提交到本地 git
7. git push origin xxx             # 把本地 xxx 分支推送到 GitHub
```

### 写代码过程中远端 GitHub 出现改变

```bash
1. git checkout main               # 切换回 main 分支
2. git pull origin master          # 把远端最新的修改拉回本地
3. git checkout xxx                # 回到自己的开发分支
4. git rebase main                 # 在 xxx 分支上，先把 main 移过来，然后根据自己的 commit 重放
   # （中途可能 rebase conflict —— 手动选择保留哪段代码）
5. git push -f origin xxx          # 把 rebase 后更新过的代码强推回远端
6. 原项目主人采用 pull request 中的 "squash and merge" 合并所有 commit
```

### 远端 PR 合并完成后

```bash
1. git branch -d xxx               # 删除本地特性分支
2. git pull origin master          # 再把远端最新代码拉到本地
```

---

## 提交第一个 Pull Request

参考：[如何在 GitHub 提交第一个 pull request](https://www.freecodecamp.org/chinese/news/how-to-make-your-first-pull-request-on-github/)

辅助参考：[Github pull request 详细教程（提交代码到他人仓库）](https://blog.csdn.net/CY2333333/article/details/113731490)

目的：学习分支使用 + 增加新特性的备份。

---

## 三大分区：工作区 / 暂存区 / 版本区

参考：[Git——三大分区【工作区 / 暂存区 / 版本区】](https://blog.csdn.net/qq_36749906/article/details/113722282)

### 1. 工作区

Git 的工作区也就是平时编辑代码的目录文件夹。

### 2. 暂存区

暂存区就是一个**暂时放置修改文件记录**的地方。

以仓库放货物为例：向仓库放货物总是一车车地拉。如果货物一件件地拉，当想回到之前某个状态时，需要把货物一件件往外撤，数量大时管理困难。

如果把货物一车车拉进仓库，想回到某个状态时只需要拿走几车，减少操作管理难度。

**所以暂存区的作用是把多个文件的多处修改暂时存储，最后把这些修改作为一个版本提交。**

### 3. 版本区

版本区可以看作一个仓库，每次将暂存区中打包好的修改送到仓库，是各种修改版本信息最后存储的地方。

### 三个区的切换命令

| 切换方向 | 命令 |
| :--- | :--- |
| 工作区 → 暂存区 | `git add` |
| 暂存区 → 版本区 | `git commit -m "..."` |
| 版本区 → 暂存区 | `git reset --mixed <commit>` |
| 暂存区 → 工作区 | `git reset --soft <commit>` |
| 版本区 → 暂存区 → 工作区 | `git reset --hard <commit>` |

```bash
git add readme.md Test1.py
git commit -m "commit the last Version"

git reset --mixed d5d43ff
git reset --soft d5d43ff
git reset --hard d5d43ff
```

---

## 形象讲解 git：fork / clone / push / pull

参考：[形象讲解 git](https://www.zhihu.com/question/29894004/answer/46237730)

> 你在大街上随便找了个人，看人家的衣服很漂亮。你按照别人的衣服样式，自己复制了一份（**clone**），别人既然穿出来了，就不怕你抄。

> 过了一段时间，人家觉得有些地方不够美观，进行了一些改动，然后再次穿到自己身上秀出来（**push**）。

> 这个时候你仍然可以将新改动的部分再次抄过来（**fetch**），然后合并到你的衣服上（**merge**）。这两步可以合并为一步，即 **pull**。

> 后来，你觉得衣服有些地方不够美观，如你想把长袖改成短袖。你自己改，改完后穿上（**commit**）也觉得很美，"既然这么美，要不把改动也告诉给别人吧"，然后 duang 就想上前拉住别人，"来来来，看看我的改动好不好"。别人肯定会想"你谁啊？有病吧？"

### 问题出现了——怎么贡献给别人？

如果你本身是一个很牛 X 的服装设计师，看到有些人的衣服设计实在太烂，下定决心"我要更漂亮、更实用、更节能"。怎么办？

1. 先要**知会**（**fork**）对方："我要针对你的设计进行调整了"
2. 仍然需要先**复制**（**clone**）一份，你肯定不能直接在别人身上改动
3. 修改完成后，自己先**上身**（**commit**）看看效果
4. 如果对改动满意，**告知**（**push**）对方："我刚才说要对你的设计进行修整，现在是修整后的效果，你看看满意否？"

当然对方是不是接受，就看人家具体意愿。

**所以：**

- **如果你想 push，请先 fork**
- **如果只是拿来主义，直接 clone 然后 pull 就可以了**

这个设计理念包含了人与人之间最基本的尊重。

---

## DNS 污染导致 GitHub 图片不显示

参考：[解决 Github 无法显示图片以及 README 无法显示图片](https://blog.csdn.net/qq_41709370/article/details/106282229)

**DNS 污染**（DNS cache pollution / DNS cache poisoning）：刻意或无意中制造出来的域名服务器数据包，把域名指往不正确的 IP。

### 解决方案：配置 hosts 指向 GitHub 服务器

用 ipaddress 查一下 `raw.githubusercontent.com` 的 IP：

- macOS 的 hosts 在 `/etc/hosts`
- Windows 的 hosts 在 `C:\Windows\System32\drivers\etc\hosts`

添加：

```
199.232.68.133 raw.githubusercontent.com
199.232.68.133 githubusercontent.com
```

### README 显示图片的三种写法

```markdown
![contents](./contents.png)
![contents](https://github.com/RGNil/2020MCM_paper/raw/master/contents.png)
![contents](https://github.com/RGNil/2020MCM_paper/blob/master/contents.png)
```

三种路径都可以用。

---

## 如何在 GitHub 上提交 PR

参考：[如何在 GitHub 上提交 PR（Pull Request）](https://cloud.tencent.com/developer/article/1999727)

详见前面 [正确 GitHub 工作流](#正确-github-工作流) 章节。

---

> 写于 2026-07-07。