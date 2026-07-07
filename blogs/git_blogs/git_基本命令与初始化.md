# Git 基本命令与初始化

> 来源：合并自 [blogs/git_blogs/Git.md](Git.md) 与 [blogs/git_blogs/git_study.md](git_study.md)。

本篇汇总"建仓库 → 提交 → 推上去"全流程用的基本命令，以及日常最频繁的几条（status / add / commit / push / rm --cached）。

---

## 目录

1. [批量更新多个目录的命令组合](#批量更新多个目录的命令组合)
2. [从 0 上传本地仓库到 GitHub](#从-0-上传本地仓库到-github)
3. [首次推送可能报错的处理](#首次推送可能报错的处理)
4. [git status：查看当前状态](#git-status查看当前状态)
5. [git rm --cached：删除已 add 的缓存](#git-rm---cached删除已-add-的缓存)

---

## 批量更新多个目录的命令组合

实际使用时不会一个个 `git add`，一般是下面这一组动作（来自 `My_Library` 仓库的真实提交历史）：

```bash
git status

git add Important_thoughts/health/*
git add Books/Psychology/*
git add blogs/travel*
git add "blogs/嵌入式&电子*"
git add plan/*
git add blogs/Git.md
git add Important_thoughts/创业、经济、财务、政治文化相关/香港银行卡.md
git add Important_thoughts/粤语日语*
git add Resume_Job/面试题/*
git add blogs/C++_study/黑马程序员匠心之作C++教程从0到1入门编程,学习编程不再难/讲义/C++核心编程.md
git add blogs/C++_study/C++_study_note.md
git add blogs/C++_study/ACM/ACM算法+题目.md
git add blogs/cmake.md
git add Important_thoughts/社交、沟通、社会/社会、生活与人.md
git add README.md
git add QuickOpenFileProgram.ahk
git add TrayIcon.ahk
git add 双拼全拼切换.bat
git add 小鹤音形for手机搜狗百度自定义方案.txt
git add 小鹤音形自定义短语导入.dat

git status

git commit -m "update health dir"
git commit -m "update 嵌入式&电子"
git commit -m "update travel dir"
git commit -m "update plan dir"
git commit -m "commit Git.md"
git commit -m "upload Hong Kong card"
git commit -m "update 粤语日语"
git commit -m "Resume_Job面试题"
git commit -m "C++_study"
git commit -m "cmake"
git commit -m "社会、生活与人"

git push origin master
```

> 💡 路径里有空格、中文、`&`、`+` 等特殊字符时**一定要加引号**，否则 shell 会拆词、`*` 会被 glob 展开出错。

---

## 从 0 上传本地仓库到 GitHub

参考：[上传本地文件（夹）到 GitHub 和更新仓库文件（知乎）](https://zhuanlan.zhihu.com/p/136355306)。视频修正版见 [B 站](https://www.bilibili.com/video/BV1fa4y1H7Fd?t=349.7)。

### 0. 配置身份（全局，只需一次）

```bash
git config --global user.name "UryWu"
git config --global user.email "urywu@qq.com"
```

### 1. 在文件夹里生成 `.git`

```bash
git init
```

### 2. 把文件加入缓存区

`.` 代表当前目录（含子目录）全部加入：

```bash
git add .
```

提交指定文件：

```bash
git add README.md
```

### 3. 查看当前状态（可选）

```bash
git status
```

### 4. 提交到本地仓库

```bash
git commit -m "first upload"
```

### 5. 关联远端仓库

```bash
git remote add origin https://github.com/your-username/my-awesome-project.git
```

或 SSH 形式：

```bash
git remote add origin git@github.com:your-username/my-awesome-project.git
```

真实例子：

```bash
git remote add origin https://github.com/UryWu/enterprise_strategy_consult_assistant.git
git remote add origin https://github.com/UryWu/data_sim_card_purchase.git
```

### 6. 推送到远端

```bash
git push origin master
```

首次推送建议带 `-u` 建立追踪关系：

```bash
git push -u origin master
```

之后就可以直接 `git push` / `git pull`，不用每次写 origin 和分支名。

---

## 首次推送可能报错的处理

报错：

```
error: failed to push some refs to https://github.com/xxx/test.git
```

原因通常是**本地仓库和远端仓库彼此不相干**——本地只有 `picture`，远端只有 `readme.md`，远端拒绝直接覆盖。

两种解法（任选其一）：

```bash
# 方式一：变基后再推
git pull --rebase origin master
git push origin master
```

```bash
# 方式二：允许不相关历史合并（会弹出编辑器，输入 :wq 退出）
git pull origin master --allow-unrelated-histories
git push origin master
```

---

## git status：查看当前状态

```bash
git status
```

输出会告诉你：

- 当前在哪个分支
- 工作区有哪些文件被修改、删除、新增
- 暂存区（index）里有哪些待提交的内容
- 与远端的领先 / 落后关系

日常使用频率最高的"看一眼"命令，**几乎所有故障排查的第一步**。

---

## git rm --cached：删除已 add 的缓存

参考：[git 命令删除缓存区（git add）的内容](https://blog.csdn.net/zlq_CSDN/article/details/83794900)。

```bash
# 1. 仅从缓存中删除，物理文件保留
git rm --cached 文件名

# 2. 缓存 + 物理文件一起删（慎用）
git rm -f 文件名

# 3. 删除整个目录下所有已 add 的文件（加 -r）
git rm -r --cached 文件名
```

### 典型场景

`.gitignore` 改完之后**之前已经被 add 进索引的文件不会被忽略**。这时必须用 `git rm --cached` 把它们从索引里踢出去，物理文件保留：

```bash
git rm -r --cached build/
git commit -m "stop tracking build/"
```

### 注意事项

- `git rm --cached` 只会改索引，**不会**删除磁盘上的真实文件。
- 删完之后要 `git commit`，否则下次 `git status` 还会看到这些文件是 "deleted" 状态。

---

> 写于 2026-07-07。配套 [git_远程同步与强推.md](git_远程同步与强推.md) 阅读。