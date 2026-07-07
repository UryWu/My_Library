# Git 中文与文件操作

> 来源：[blogs/git_blogs/git_study.md](git_study.md) 的「让 Git 直接显示中文而不是八进制数字」+「重命名文件提交」+「`.gitignore` 缓存」三节。

中文文件名、八进制编码、重命名、删除文件——这些是日常 `git status` 里最容易让人"看不懂到底发生了什么"的几件事。

---

## 目录

1. [让 Git 直接显示中文（不要八进制）](#让-git-直接显示中文不要八进制)
2. [重命名文件提交](#重命名文件提交)
3. [`.gitignore` 改完不生效？](#gitignore-改完不生效)

---

## 让 Git 直接显示中文（不要八进制）

Git 在某些情况下会把 **非 ASCII 文件名** 用 **八进制转义** 显示，例如：

```
python\347\254\224记.md
```

这在排查问题、复制粘贴路径时极其痛苦。

**让 Git 直接显示中文（推荐）：**

```bash
git config --global core.quotepath false
```

设置一次就永久生效。

---

## 重命名文件提交

### 问题场景

把 `blogs/python环境管理-uv-pip卸载后，pyproject.toml不更新.md` 重命名为 `blogs/python环境管理-uv-uv_pip卸载包后，pyproject.toml不更新_uv_lock.md`，然后 `commit`、`push`。

结果发现**本地**和**远端**的旧文件都没被删除：

```bash
$ git rm --cached blogs/python环境管理-uv-pip卸载后，pyproject.toml不更新.md

fatal: pathspec 'blogs/python环境管理-uv-pip卸载后，pyproject.toml不更新.md' did not match any files
```

> `pathspec did not match any files` = Git 找不到这个路径（多半是文件名敲错了，或者根本没有这个文件）。

### 先确认仓库里到底有什么

```bash
# 看 Git 索引里有没有这个旧文件
git ls-files | grep uv_pip

# 看 blogs 目录里 Git 记录的所有文件
git ls-files blogs
```

### 用 `git add -u` 一次性同步修改和删除

```bash
git add -u
```

含义：

```
-u = update
只记录 修改 和 删除
不会添加新文件
```

所以它**只会提交删除和修改，不会提交新增文件**——正好是重命名场景想要的。

```bash
git commit -m "delete old blog file"
git push
```

`git status` 之后的对比：

- **`git add -u` 前**：`deleted` 显示红字（未添加的修改）
- **`git add -u` 后**：`deleted` 显示绿字（删除已加入 commit）

### 排查发现：原来是文件名敲错了

```bash
# 不存在：
git rm "blogs/python环境管理-uv-pip卸载后，pyproject.toml不更新.md"

# 应该是：
git rm "blogs/python环境管理-uv-uv_pip卸载后，pyproject.toml不更新.md"
```

### 重命名最干净的处理方式

如果纯粹是重命名（不夹杂其他改动），用 `git mv` 一步到位：

```bash
git mv \
"blogs/python环境管理-uv-uv_pip卸载后，pyproject.toml不更新.md" \
"blogs/python环境管理-uv-uv_pip卸载包后，pyproject.toml不更新_uv_lock.md"

git commit -m "rename blog file"
git push
```

---

## `.gitignore` 改完不生效？

参考：[如果不删除缓存，修改的 `.gitignore` 文件不会生效](https://www.jianshu.com/p/85c2b19a09cc)。

`.gitignore` 改完之后**之前已经被 add 进索引的文件不会被忽略**。

必须先把它从索引里踢出去：

```bash
git rm -r --cached <目录或文件>
git commit -m "stop tracking xxx"
```

不删缓存，下次有修改后提交，只会更新修改的部分——`.gitignore` 看起来就像"失效了"。

### 典型场景

```bash
# 把整个 build/ 目录从 Git 索引里移除
git rm -r --cached build/
git commit -m "untrack build/"
```

之后 `.gitignore` 里加的 `build/` 才真正生效。

---

## 小抄

| 需求 | 命令 |
| :--- | :--- |
| 让中文文件名正常显示 | `git config --global core.quotepath false` |
| 重命名文件 | `git mv 旧名 新名` |
| 同步删除 + 修改（不加新文件） | `git add -u` |
| 从索引移除但保留物理文件 | `git rm --cached <file>` |
| 从索引移除整个目录 | `git rm -r --cached <dir>` |

---

> 写于 2026-07-07。