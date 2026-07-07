# Git 远程同步与强推

> 来源：合并自 [blogs/git_blogs/Git.md](Git.md) 的「登录失败 / bug1: git push 报错」+ [blogs/git_blogs/git_study.md](git_study.md) 的「登录失败 / 远端领先本地，强制提交落后的本地到远端」+「不要用 git push --force」三节。

`git push` 报错有十几种姿势，本篇汇总最常踩的几类坑：**登录失败、代理、SSH 改用、token、强推**。

---

## 目录

1. [`git push` 报错的典型现象](#git-push-报错的典型现象)
2. [登录失败系列排查](#登录失败系列排查)
3. [解决方案汇总](#解决方案汇总)
4. [SSH vs HTTPS 的选择](#ssh-vs-https-的选择)
5. [代理配置](#代理配置)
6. [`--force` vs `--force-with-lease`](#-force-vs---force-with-lease)
7. [远端领先本地，强制本地覆盖远端](#远端领先本地强制本地覆盖远端)

---

## `git push` 报错的典型现象

### 1. 推送失败

```bash
$ git push -u origin master
git提交报错 fatal: unable to access 'https://github.com/tata20191003/autowrite.git/': Failed to connect
```

或者：

```
Logon failed, use ctrl+c to cancel basic credential prompt.
remote: Support for password authentication was removed on August 13, 2021. Please use a personal access token instead.
remote: Please see https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/ for more information.
fatal: Authentication failed for 'https://github.com/UryWu/eladmin/'
```

### 2. 没有上游分支

```bash
$ git push origin --force
fatal: The current branch master has no upstream branch.
```

这时需要带上 `--set-upstream`：

```bash
git push --set-upstream origin master --force
```

---

## 登录失败系列排查

### 1. 代理相关

**方法 1：检查 Windows 全局代理或 Git Bash 启动代理**

```bash
env | grep -i proxy
```

看到类似输出说明代理还在生效：

```
HTTP_PROXY=http://127.0.0.1:7890
HTTPS_PROXY=http://127.0.0.1:7890
```

清除代理：

```bash
unset HTTP_PROXY
unset HTTPS_PROXY
unset http_proxy
unset https_proxy
```

**方法 2：临时给某个命令指定代理**

```bash
git -c http.proxy=192.168.169.105:10809 -c https.proxy=192.168.169.105:10809 update-git-for-windows
```

### 2. 更新 Git for Windows

参考：[Logon failed Even i entered the correct username and Password in git Bash?](https://stackoverflow.com/questions/67948392/logon-failed-even-i-entered-the-correct-username-and-password-in-git-bash)

```bash
git update-git-for-windows
```

更新完之后运行 `git push origin master` 的登录时，会用浏览器授权登录。

---

## 解决方案汇总

### Solution 1：检查代理（失败常见）

[Linux 系统查看代理，关闭代理](https://blog.csdn.net/weixin_44984664/article/details/108028704)

无论开启还是关闭本机的 Clash 代理都无效，但 `git clone` 能下载代码——说明 Git Bash 的代理走不通 Clash，需要在 Git 里额外设置：

```bash
export http_proxy=http://192.168.2.14:7890
export https_proxy=http://192.168.2.14:7890
```

### Solution 2：检查 SSH 密钥（失败常见）

[Github 生成 SSH 秘钥（详细教程）](https://blog.csdn.net/qq_35495339/article/details/92847819)

```bash
git config user.email
git config user.name
git config --global user.email 'urywu@qq.com'
```

### Solution 3：GitHub 不再支持密码验证，必须用 SSH 或 Token

参考：[GitHub 不再支持密码验证解决方案：SSH 免密与 Token 登录配置](https://cloud.tencent.com/developer/article/1861466)

> 🔴 **2021-08-13 起，GitHub 不再支持 HTTPS 密码验证**。今天起 IntelliJ 等客户端不能再用密码方式提交代码，必须用 **Personal Access Token** 替代。

因为 HTTPS 仓库不能用 token 登录（GitHub 会拒绝密码），所以必须**改用 SSH**：

```bash
git remote set-url origin git@github.com:UryWu/eladmin.git
```

改完后 `.git/config` 看起来像：

```ini
[core]
    repositoryformatversion = 0
    filemode = false
    bare = false
    logallrefupdates = true
    symlinks = false
    ignorecase = true
[remote "origin"]
    url = git@github.com:UryWu/eladmin.git
    fetch = +refs/heads/*:refs/remotes/origotes/*
[branch "master"]
    remote = origin
    merge = refs/heads/master
```

**上传成功！**

### Solution 4：Personal Access Token

参考：[github 令牌验证（密码验证将要失效）](https://blog.csdn.net/qq_43382853/article/details/119221234)

在 GitHub Settings → Developer settings → Personal access tokens 里生成一个 token，然后：

- HTTPS URL：`https://<token>@github.com/your/repo.git`
- 或者在弹窗里把 token 当密码粘进去

---

## SSH vs HTTPS 的选择

| 来源类型 | 写法 | 备注 |
| :--- | :--- | :--- |
| **GitHub 原生 SSH** | `git@github.com:UryWu/eladmin.git` | ✅ 推荐 |
| fastgit 镜像 SSH | `git@ssh.fastgit.org:UryWu/eladmin.git` | ❌ 端口被拒，无法 push |
| HTTPS | `https://github.com/UryWu/eladmin.git` | ⚠️ 需 token |

> 🔴 **不要用 fastgit 的 SSH 源**：
>
> ```bash
> $ git push -u origin master
> ssh: connect to host ssh.fastgit.org port 22: Connection refused
> ```
>
> 镜像站只支持下载，不支持 push。

---

## 代理配置

```bash
# 查看代理
env | grep -i proxy

# 关闭代理
export http_proxy=""
export https_proxy=""
export HTTP_PROXY=""
export HTTPS_PROXY=""

# 开启代理
export http_proxy="http://192.168.2.14:7890"
export https_proxy="http://192.168.2.14:7890"
export HTTP_PROXY="http://192.168.2.14:7890"
export HTTPS_PROXY="http://192.168.2.14:7890"
```

---

## `--force` vs `--force-with-lease`

参考：[git push --force-with-lease（中文）](https://blog.csdn.net/wpwalter/article/details/80371264)

**不要用 `git push --force`**，要用 `git push --force-with-lease` 代替。

在你上次提交之后，只要**其他人往该分支提交了代码**，`--force-with-lease` 会拒绝覆盖——这就是它的安全意义。

| 命令 | 行为 |
| :--- | :--- |
| `git push --force` | 无条件强制覆盖远端 |
| `git push --force-with-lease` | 只在远端没被别人更新时才强推 |

**结论：`--force-with-lease > --force`。**

---

## 远端领先本地，强制本地覆盖远端

如果**远端领先本地**，但你想**强制用本地版本覆盖远端**，需要在 Git 里使用 force push。

### 1️⃣ 最直接的方法

```bash
git push --force origin master
```

含义：用本地 master 强制覆盖远端 origin/master。

结果：远端 commit 会被重写，远端历史改变。

### 2️⃣ 更安全的方法（推荐）

```bash
git push --force-with-lease origin master
```

只有在**远端没有被别人更新**的情况下才强推，防止误删别人的 commit。

### 3️⃣ 示例场景

假设：

```
远端
A---B---C

本地
A---B
```

执行：

```bash
git push --force origin master
```

远端变成：

```
A---B
```

`C` 会消失（被覆盖）。

### 4️⃣ 如何确认当前状态

先看状态：

```bash
git status
```

如果显示：

```
Your branch is behind 'origin/master'
```

说明远端领先。

### 5️⃣ 强推前建议先看差异

```bash
git log origin/master..master   # 本地比远端多了什么
git log master..origin/master   # 远端比本地多了什么
```

### ⚠️ 强推风险

强推会：

- 重写远端历史
- 删除远端 commit
- 可能影响团队

所以通常只在：

- **个人仓库**
- **修复 commit 历史**
- **rebase 后**

使用。

### ⭐ 推荐命令

```bash
git push --force-with-lease origin master
```

> 💡 **Git 高级技巧**：如果经常需要强推当前分支，可以直接：
>
> ```bash
> git push --force-with-lease
> ```
>
> Git 会自动推送**当前分支到对应 upstream**。

---

> 写于 2026-07-07。