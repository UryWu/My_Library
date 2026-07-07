# Git 资料速查

> 来源：[blogs/git_blogs/Git.md](Git.md) 与 [blogs/git_blogs/git_study.md](git_study.md) 的「Git 常用指令 / Git 奇技淫巧 / git-sim / 常用 Git 指令」+「IDEA 中集成 Git」等速查性质的小节。

本篇只放"收藏夹"性质的内容——常用的 cheat sheet、可视化工具、集成教程。

---

## 目录

1. [常用 Git 指令速查](#常用-git-指令速查)
2. [Git 的奇技淫巧](#git-的奇技淫巧)
3. [git-sim：repo 可视化](#git-simrepo-可视化)
4. [IDEA 中集成 Git](#idea-中集成-git)
5. [常用 Git 指令参考图](#常用-git-指令参考图)

---

## 常用 Git 指令速查

参考：[常用 Git 指令](https://www.javanav.com/val/25275ed95c914a94978c7f3046533962.html)（2020-12-09）

### 仓库初始化与配置

```bash
git config --global user.name "your-name"
git config --global user.email "your-email"

git init
git clone <url>
```

### 查看与状态

```bash
git status
git log
git log --oneline --graph --decorate
git diff
git diff --cached
```

### 增删改

```bash
git add <file>
git add .
git add -u                    # 只记录修改和删除，不加新文件
git mv <old> <new>
git rm <file>
git rm --cached <file>        # 仅从缓存删除
git rm -r --cached <dir>      # 整个目录从缓存删除
```

### 提交与回滚

```bash
git commit -m "msg"
git commit --amend            # 合并到上一次 commit
git reset --soft <commit>     # 版本区 → 暂存区
git reset --mixed <commit>    # 版本区 → 暂存区 → 工作区
git reset --hard <commit>     # 全部回滚
```

### 分支

```bash
git branch                    # 列出本地分支
git branch -a                 # 列出所有分支
git branch <name>             # 创建分支
git branch -m <old> <new>     # 重命名
git branch -d <name>          # 删除已合并分支
git branch -D <name>          # 强制删除

git checkout <branch>         # 切换
git checkout -b <name>        # 创建并切换
```

### 远程同步

```bash
git remote -v
git remote add origin <url>
git remote set-url origin <url>

git fetch
git pull
git pull --rebase
git fetch origin --tags       # 拉取所有 tag

git push
git push -u origin master
git push --force-with-lease
git push origin --tags
git push --follow-tags
```

### Tag

```bash
git tag                       # 列出所有 tag
git tag <name>                # 轻量 tag（打在 HEAD）
git tag <name> <commit>       # 打在指定 commit
git tag <name> -m "msg"       # 附注 tag（推荐）
git tag -d <name>             # 删除本地 tag
```

### 撤销与恢复

```bash
git checkout -- <file>        # 撤销工作区修改
git restore <file>            # 同上（推荐）
git restore --staged <file>   # 取消暂存
```

---

## Git 的奇技淫巧

参考：

- [Git 的奇技淫巧（GitHub）](https://github.com/youngyangyang04/git-tips)
- [Git 的奇技淫巧 简单指令与解释（HelloGitHub）](https://hellogithub.com/article/9aed28d4d64b4649bb364685ef557ae4)

简明又详细。社区里最被推荐的 cheat sheet 之一。

---

## git-sim：repo 可视化

参考：[git-sim](https://github.com/initialcommit-com/git-sim#git-sim)

用命令把 git 操作可视化展示出来，适合做教学 / 演示：

```bash
pip install git-sim
git-sim log
git-sim status
git-sim commit -m "xxx"
```

会生成 mp4 动画，把命令执行前后的状态画出来。

---

## IDEA 中集成 Git

参考：[IDEA 中项目集成 git 提交代码详细步骤](https://blog.csdn.net/qq_34377273/article/details/109157116)（2020-10-19）

### 关键步骤

1. **File → Settings → Version Control → Git** — 配置 Git 可执行文件路径
2. **VCS → Enable Version Control Integration** — 启用 Git
3. **VCS → Git → Remotes** — 添加远端
4. 右上角有 Commit / Push / Pull 按钮直接用

### 注意事项

- 2021-08-13 起，**IDEA 用 HTTPS 推送会要求 Personal Access Token**（用户名 + 密码已失效）
- 建议改成 SSH 远端 URL，避免每次输入 token

---

## 常用 Git 指令参考图

参考：[常用 Git 指令图](https://www.javanav.com/val/25275ed95c914a94978c7f3046533962.html)

> ⚠️ 原图 `image__20201210113653.png` 在仓库中已丢失（原 `Git.md` 里就有这引用，但 `Git.assets/` 下找不到文件），这里删除引用，留链。

---

## 链接索引

| 主题 | 链接 |
| :--- | :--- |
| 知乎：上传本地文件到 GitHub | <https://zhuanlan.zhihu.com/p/136355306> |
| B 站：教程修正视频 | <https://www.bilibili.com/video/BV1fa4y1H7Fd?t=349.7> |
| freeCodeCamp：第一个 PR | <https://www.freecodecamp.org/chinese/news/how-to-make-your-first-pull-request-on-github/> |
| CSDN：删除缓存区内容 | <https://blog.csdn.net/zlq_CSDN/article/details/83794900> |
| 十分钟 GitHub 工作流（B 站） | <https://www.bilibili.com/video/BV19e4y1q7JJ/> |
| Git 奇技淫巧 | <https://github.com/youngyangyang04/git-tips> |
| HelloGitHub cheat sheet | <https://hellogithub.com/article/9aed28d4d64b4649bb364685ef557ae4> |
| git-sim | <https://github.com/initialcommit-com/git-sim> |
| 三大分区 | <https://blog.csdn.net/qq_36749906/article/details/113722282> |
| 形象讲解 git | <https://www.zhihu.com/question/29894004/answer/46237730> |
| gitee vs github | <https://www.zhihu.com/question/384541326/answer/2456270379> |
| git vs svn | <https://www.zhihu.com/question/399890301/answer/1270678917> |
| 开源协议速览 | <https://zhuanlan.zhihu.com/p/272543821> |
| IDEA 集成 Git | <https://blog.csdn.net/qq_34377273/article/details/109157116> |
| GitHub 不再支持密码 | <https://cloud.tencent.com/developer/article/1861466> |
| git push --force-with-lease | <https://blog.csdn.net/wpwalter/article/details/80371264> |
| SSH 密钥密码 | <https://docs.github.com/zh/authentication/connecting-to-github-with-ssh/working-with-ssh-key-passphrases> |
| DNS 污染解决 | <https://blog.csdn.net/qq_41709370/article/details/106282229> |
| 国内开源软件侵权事件 | <https://blog.csdn.net/sunjing/article/details/4815685> |
| 密码泄漏到 GitHub | <https://github.com/ruanyf/weekly/blob/master/docs/issue-134.md> |
| 如何在 GitHub 上提交 PR | <https://cloud.tencent.com/developer/article/1999727> |
| `.gitignore` 缓存清理 | <https://www.jianshu.com/p/85c2b19a09cc> |

---

> 写于 2026-07-07。