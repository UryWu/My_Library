# Git 泄漏与安全

> 来源：合并自 [blogs/git_blogs/Git.md](Git.md) 与 [blogs/git_blogs/git_study.md](git_study.md) 的「泄漏密码」+「SSH 密钥」+「密码泄漏到 GitHub 会发生什么」三节。

不小心把密钥推到公共仓库怎么办？SSH key 怎么改密码？这两件事虽然小但出错代价大，留个档。

---

## 目录

1. [密码泄漏到 GitHub 会发生什么？](#密码泄漏到-github-会发生什么)
2. [从历史 commit 里彻底删除敏感文件](#从历史-commit-里彻底删除敏感文件)
3. [SSH 密钥密码管理](#ssh-密钥密码管理)

---

## 密码泄漏到 GitHub 会发生什么？

参考：[密码泄漏到 GitHub，会发生什么？](https://github.com/ruanyf/weekly/blob/master/docs/issue-134.md)

实验：故意生成一个假的 AWS 密钥提交到公共仓库。

**GitHub**：

- 15:27，推送带密钥的提交
- 15:34（7 分钟后），收到 @GitGuardian 的邮件通知
- 15:38（11 分钟后），开始有人拿这个密钥入侵

接下来 2 小时又收到 5 条警报，分别来自德国、荷兰、英国和乌克兰。入侵脚本用 Python 和 Node.js SDK。

**GitLab**：

- 16:24，推送带密钥的提交
- 17:26（62 分钟后），第一次入侵来自法国

没有从 GitLab 收到任何提醒。GitLab 确实有这功能，但仅对付费用户开放。

**结论**：

1. 入侵者对 GitHub 的扫描多于 GitLab。
2. 如果用 GitHub，建议启用 @GitGuardian。
3. 如果用 GitLab，最好升级到付费用户。

---

## 从历史 commit 里彻底删除敏感文件

> ⚠️ **前提**：先备份。这两步操作会改写历史，必须用 `--force` 强推。

### 场景示例

我的密码在 `config.yaml` 里。`git log` 看到三次提交：

```bash
$ git log
commit c868a175cc1027a2dba9ed9bb157cb1f3ace2b1f (HEAD -> master, origin/master)
Author: UryWu <1345150167@qq.com>
Date:   Sat Oct 18 02:07:56 2025 +0800

    upload config.yaml

commit 28476566b9ce369147d8c525cacacf78c1e38859
Author: UryWu <1345150167@qq.com>
Date:   Sat Oct 18 02:05:21 2025 +0800

    删除 config.json

commit 95729a52539e9d76808268839e5e7ae82591b58d
Author: urywu <urywu@qq.com>
Date:   Sat Oct 18 01:08:35 2025 +0800

    first upload
```

### 方法 1：`git filter-branch`（较旧但能用）

```bash
git filter-branch --force --index-filter \
"git rm --cached --ignore-unmatch config.yaml" \
--prune-empty --tag-name-filter cat -- --all

git push origin --force
```

再次 `git log`：

```bash
$ git log
commit b3442418b41ce40d64a18e0daa44753532313219 (HEAD -> master, origin/master)
Author: urywu <urywu@qq.com>
Date:   Sat Oct 18 01:08:35 2025 +0800

    first upload
```

只剩一次提交，GitHub 页面上的 `config.yaml` 也没了。

⚠️ **但是**之前的 commit 在 GitHub 上还是访问得到（[示例链接](https://github.com/UryWu/enterprise_strategy_consult_assistant/commit/95729a52539e9d76808268839e5e7ae82591b58d#diff-d8d0422389f03d783e32e627250fe29834bd09c6361640d1ff00661dd6820034)）：

> This commit does not belong to any branch on this repository, and may belong to a fork outside of the repository.

从仓库主页找不到访问链接。

#### 多文件删除

```bash
git filter-branch --force --index-filter \
"git rm --cached --ignore-unmatch main.py core\rag_policy_analyzer.py database\mongo_db.py" \
--prune-empty --tag-name-filter cat -- --all

git push origin --force
```

如果报错 "no upstream branch"：

```bash
fatal: The current branch master has no upstream branch.
```

需要带 `--set-upstream`：

```bash
git push --set-upstream origin master --force
```

### 方法 2：`git filter-repo`（推荐但本机未配通）

```bash
# 安装
pip install git-filter-repo

# 从整个历史中移除 secret.txt
git filter-repo --path secret.txt --invert-paths

# 推送到所有分支和 tag
git push origin --force --all
git push origin --force --tags
```

> 💡 `filter-repo` 比 `filter-branch` 更快更安全，是社区推荐的新工具。

---

## SSH 密钥密码管理

### 添加或更改密码

参考：[使用 SSH 密钥密码](https://docs.github.com/zh/authentication/connecting-to-github-with-ssh/working-with-ssh-key-passphrases#adding-or-changing-a-passphrase)

通过输入以下命令，您可以**更改现有私钥的密码**而无需重新生成密钥对：

```bash
ssh-keygen -p -f ~/.ssh/id_ed25519
# Enter old passphrase: [输入旧密码]
# Key has comment 'your_email@example.com'
# Enter new passphrase (empty for no passphrase): [输入新密码]
# Enter same passphrase again: [重复新密码]
# Your identification has been saved with the new passphrase.
```

### ssh 忘记密码怎么办

1. 先把 GitHub 上你的 SSH key 删掉（Settings → SSH and GPG keys → Delete）
2. 打开 `C:\Users\UryWu\.ssh`，在这里打开一个 cmd 窗口，输入 `ssh`
3. 输入新密码，确定覆盖
4. 把新的 `id_rsa.pub` 内容粘贴到 GitHub 的 Authentication Keys 里

---

> 写于 2026-07-07。强烈建议：在提交前用 `git diff --staged` 多看一眼，敏感配置走 `.gitignore` + 环境变量而不是直接进仓库。