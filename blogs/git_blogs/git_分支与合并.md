# Git 分支与合并

> 来源：[blogs/git_blogs/Git.md](Git.md) 的「根据历史 commit 创建新分支」章节。

从某个历史 commit 重新开一条线，把原分支重命名 / 切换走，是开发中很常见的需求（重新发版、保留旧版作为备用、保留某次提交作为特性分支）。

---

## 目录

1. [典型场景](#典型场景)
2. [方案一：`git checkout -b` 创建并切换](#方案一git-checkout--b-创建并切换)
3. [方案二：`git branch` 创建后手动切换](#方案二git-branch-创建后手动切换)
4. [两种方式对比](#两种方式对比)
5. [常见配套命令](#常见配套命令)

---

## 典型场景

```bash
$ git log --graph --oneline --decorate --all
* 5f8b66a (HEAD -> master) fix: use correct FFmpeg 8.x DLL names with version numbers
* 7495244 feat: add Logger class for centralized log file path from config.json
* add3e04 config: update ffmpeg_exe to FFmpeg full build path
* 7fb5a29 docs: add detailed line-level comments to videoplayerwindow
```

需求：

> 想回到 `7fb5a29` 备份点重新开 master，把原 master 改名为 `ffmpeg-videoplayer` 留作特性分支。

**关键原则：保持 master 的线性发展，从备份点重新开始，原开发分支保留作为特性分支。**

---

## 方案一：`git checkout -b` 创建并切换

`git checkout -b <新分支名> <起始点>` = 创建分支 + 切换 HEAD 一气呵成。

```bash
# 1. 把当前 master 重命名为 ffmpeg-videoplayer
git branch -m master ffmpeg-videoplayer

# 2. 基于 7fb5a29 创建并切换到新 master
git checkout -b master 7fb5a29

# 3. 查看结果
git log --graph --oneline --decorate --all
```

---

## 方案二：`git branch` 创建后手动切换

如果想先建好分支、之后再决定什么时候切过去，分两步：

```bash
# 1. 重命名当前 master
git branch -m master ffmpeg-videoplayer

# 2. 仅创建新 master，不切换 HEAD
git branch master 7fb5a29

# 3. 验证
git log --graph --oneline --decorate --all

# 4. 切到新 master
git checkout master
```

---

## 两种方式对比

| 场景 | 命令 |
| :--- | :--- |
| 创建分支但不切换 | `git branch <新分支名> <起始点>` |
| 创建分支并立即切换 | `git checkout -b <新分支名> <起始点>` |
| 重命名当前分支 | `git branch -m <新名字>` |

---

## 常见配套命令

```bash
# 列出所有分支（本地 + 远端追踪）
git branch -a

# 删除本地分支（已合并）
git branch -d <分支名>

# 强制删除本地分支（未合并）
git branch -D <分支名>

# 删除远端分支
git push origin --delete <分支名>
```

---

> 写于 2026-07-07。