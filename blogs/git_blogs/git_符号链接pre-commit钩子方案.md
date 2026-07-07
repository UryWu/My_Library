# Windows 下用 pre-commit / post-commit 钩子把符号链接源内容提交到 GitHub

> 配套上一篇 [Windows下Git链接与文件提交问题.md](Windows下Git链接与文件提交问题.md)。
> 那篇讲"为什么 Git 不会把符号链接的源文件内容带上去"，这篇讲"用一对 Git 钩子把它做掉"。

---

## 目录

1. [目标](#目标)
2. [最终方案概览](#最终方案概览)
3. [pre-commit 钩子（实现）](#pre-commit-钩子实现)
4. [post-commit 钩子（实现）](#post-commit-钩子实现)
5. [完整代码（可直接复用）](#完整代码可直接复用)
6. [一路上踩的坑](#一路上踩的坑)
7. [调试方法](#调试方法)
8. [局限与替代方案](#局限与替代方案)

---

## 目标

工作树里某个 `.md` 是符号链接，指向仓库外（比如 `G:\Projects\xxx\docs\foo.md`）的真实源文件。

想要的结果：

| 位置 | 内容 |
|---|---|
| **本地工作树** | 仍是符号链接，编辑器读源文件 |
| **GitHub 仓库** | 普通文件 (mode `100644`)，blob 是源文件真实内容 |

光 `git add` + `git commit` 不行——Git 把符号链接记成 mode `120000` + 路径字符串，GitHub 上看到的是断链。

**唯一可行**：在 commit 流程里把符号链接"物化"成源内容，commit 完再把工作树恢复回符号链接。

---

## 最终方案概览

两个钩子 + 一个临时 manifest：

```
工作树（符号链接）── git add ──> 暂存（120000 + 路径字符串）
                                          │
                                          ▼
                              pre-commit 钩子介入
                              ─ 删符号链接
                              ─ 写源内容到工作树
                              ─ 强制把暂存条目从 120000 改成 100644
                              ─ 写一行到 .git/symlinks-manifest
                                          │
                                          ▼
                                     commit 发生
                                          │
                                          ▼
                             post-commit 钩子介入
                              ─ 读 manifest
                              ─ 用 mklink 重建符号链接
                              ─ 删 manifest
                                          │
                                          ▼
工作树（符号链接）                GitHub（100644 + 源内容）
```

- 暂存文件：[.git/symlinks-manifest](.git/symlinks-manifest)（仓库本地、不入库、commit 完即删）
- 钩子脚本：[.git/hooks/pre-commit](.git/hooks/pre-commit)、[.git/hooks/post-commit](.git/hooks/post-commit)
- 用 `git commit --no-verify` 可绕过这俩钩子

---

## pre-commit 钩子（实现）

### 整体流程

```bash
对每个 staged 文件（diff-filter=AMT）：
    if 是符号链接：
        if 目标存在且是普通文件：
            ORIG   = readlink(path)               # 原始目标字符串
            TARGET = readlink -f(path)            # 解析后的绝对路径

            rm -f $path                           # 删符号链接
            git update-index --remove $path       # 删索引条目（关键：此时文件已不存在）
            cat $TARGET > $path                   # 写源内容成实文件
            git add $path                         # 重新 stage，mode 100644

            echo "$path|$ORIG|$TARGET" >> .git/symlinks-manifest
```

### 关键点

1. **必须先 `rm` 再 `git update-index --remove`**——`--remove` 只在文件**不存在**于工作树时才会删索引条目。如果顺序反了，索引条目留着，`git add` 不会改 mode。

2. **`cat > file` 不能直接用**——shell 重定向会跟符号链接，结果是把源文件 truncate 掉。必须先 `rm` 删链接，再用 `cat` 写到那个**不再存在的路径**。

3. **`cp` 也不行**——MSYS / Git Bash 在 Windows 上跨盘符时会报 `cp: ... are the same file` 然后 exit 1。

4. **不能用 `git rm --cached`**——它会检查 `staged content different from both the file and the HEAD`，我们正是这种状态（索引是路径字符串、工作树是源内容、HEAD 是上一版的源内容），会拒绝执行。`git update-index --remove` 是无条件删除，不挑食。

5. **`diff-filter` 必须是 `AMT`**，不是 `AM`——符号链接 ↔ 实文件的 mode-only 变化被 Git 归类为 **Type change (T)**，不是 Modified (M)。漏了 T 钩子就不会触发。

---

## post-commit 钩子（实现）

### 整体流程

```bash
读 .git/symlinks-manifest
为每条 (path, orig_target, resolved)：
    rm -f $path
    # 在 Windows 上用 mklink（ln -s 退化成复制）
    写到临时 .bat：
        chcp 65001 > nul        ← 必须！切 UTF-8 码页
        mklink "<path>" "<target>"
    cmd /c <temp.bat>
删 .git/symlinks-manifest
```

### 关键点

1. **`ln -s` 在 Windows MSYS 下退化为复制**——`mklink` 才是 Windows 原生建符号链接的命令。直接用 `ln -s` 会得到一个内容是源文件副本的"假符号链接"，看起来对但其实不是。

2. **必须用 `mklink` via `.bat`**——MSYS 直接调 `cmd /c "mklink ..."` 时，遇到路径里的 `+` 或某些字符会报 "filename syntax incorrect"。把 `mklink` 命令写进临时 `.bat` 文件再 `cmd /c <bat>` 就能绕过 cmd 的命令行解析坑。

3. **`.bat` 顶部必须 `chcp 65001 > nul`**——MSYS 出来的中文路径是 UTF-8 字节流，cmd 默认用系统 ANSI 码页（中文 Windows 是 GBK）解析，会把中文乱码成 `M-eM-.M-^I...` 一类不可识别的字节，导致 mklink 失败。`chcp 65001` 切到 UTF-8 码页就解决了。

4. **Windows 需要 Developer Mode 或管理员权限**才能建符号链接（`SeCreateSymbolicLinkPrivilege`）。在 *设置 → 更新和安全 → 开发者选项* 里开 "开发人员模式" 最省事，不用给整个 shell 提权。

---

## 完整代码（可直接复用）

### [`.git/hooks/pre-commit`](.git/hooks/pre-commit)

```bash
#!/usr/bin/env bash
# pre-commit hook: resolve symlinks in staged files to their target content.
# See blogs/git_符号链接pre-commit钩子方案.md for the rationale.

set -e

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

MANIFEST="$REPO_ROOT/.git/symlinks-manifest"
: > "$MANIFEST"

# Added, modified, OR type-changed. The last filter matters: a staged file
# that switches from a real file to a symlink (or vice versa) shows up as a
# Type change in `git diff`, not Modified, so `AM` would silently miss it
# -- which is exactly our case when the user re-stages a recreated symlink
# against a HEAD that holds the synced real-file blob.
STAGED=$(git diff --cached --name-only --diff-filter=AMT)
[ -z "$STAGED" ] && exit 0

SYNCED=()
while IFS= read -r FILE; do
    [ -z "$FILE" ] && continue
    case "$FILE" in
        .git/*|.git) continue ;;
    esac

    FULL_PATH="$REPO_ROOT/$FILE"

    if [ -L "$FULL_PATH" ]; then
        ORIG_TARGET=$(readlink "$FULL_PATH" 2>/dev/null || echo "")
        RESOLVED=$(readlink -f "$FULL_PATH" 2>/dev/null || echo "")

        if [ -n "$RESOLVED" ] && [ -f "$RESOLVED" ]; then
            # 1. Remove the symlink from the working tree.
            rm -f -- "$FULL_PATH"

            # 2. Drop the index entry NOW while the file is gone from the
            #    work tree. `git update-index --remove` only removes the
            #    index entry if the file is gone, so it must run between
            #    `rm` and the `cat >` that recreates the file.
            git update-index --remove -- "$FILE" 2>/dev/null || true

            # 3. Write the source content as a regular file
            cat -- "$RESOLVED" > "$FULL_PATH"

            # 4. Stage as a regular file (100644, with new blob)
            git add -- "$FILE"

            # Record for post-commit to restore the symlink
            printf '%s\n' "$FILE|$ORIG_TARGET|$RESOLVED" >> "$MANIFEST"
            SYNCED+=("  $FILE  <-  $ORIG_TARGET")
        else
            echo "pre-commit: WARN  $FILE is a symlink with non-file target: ${ORIG_TARGET:-<unreadable>}" >&2
        fi
    fi
done <<< "$STAGED"

if [ ${#SYNCED[@]} -gt 0 ]; then
    echo "pre-commit: resolved ${#SYNCED[@]} symlink(s) to source content:"
    printf '%s\n' "${SYNCED[@]}"
    echo "pre-commit: post-commit will restore the symlinks."
fi

exit 0
```

### [`.git/hooks/post-commit`](.git/hooks/post-commit)

```bash
#!/usr/bin/env bash
# post-commit hook: restore symlinks that pre-commit resolved.
# See blogs/git_符号链接pre-commit钩子方案.md for the rationale.

set -e

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

MANIFEST="$REPO_ROOT/.git/symlinks-manifest"
[ -f "$MANIFEST" ] || exit 0

# Build a .bat script with `mklink` commands. We avoid `ln -s` because on
# Windows MSYS / Git Bash without admin / Developer Mode it silently
# degrades to copying the source file. `mklink` honors whatever privilege
# Git Bash inherits from the launching shell.
BAT_RAW=$(mktemp --suffix=.bat)
BAT_WIN=$(cygpath -w "$BAT_RAW")

{
    echo "@echo off"
    # Switch to UTF-8 codepage so non-ASCII path bytes from cygpath are
    # interpreted correctly. Without this, cmd defaults to ANSI (e.g. GBK
    # on Chinese Windows) and mangles UTF-8 byte sequences.
    echo "chcp 65001 > nul"
    echo "setlocal"
    while IFS='|' read -r FILE ORIG_TARGET RESOLVED; do
        [ -z "$FILE" ] && continue
        FULL_PATH="$REPO_ROOT/$FILE"

        TARGET_STR="${ORIG_TARGET:-$RESOLVED}"
        [ -z "$TARGET_STR" ] && continue

        LINK_WIN=$(cygpath -w -- "$FULL_PATH")
        TARGET_WIN=$(cygpath -w -- "$TARGET_STR")

        # mklink fails if the link file already exists, so delete first.
        echo "if exist \"$LINK_WIN\" del /F /Q \"$LINK_WIN\""
        echo "mklink \"$LINK_WIN\" \"$TARGET_WIN\""
    done < "$MANIFEST"
    echo "endlocal"
} > "$BAT_RAW"

# Execute the .bat. `cmd //c` lets MSYS pass the Windows path through.
cmd //c "$BAT_WIN" 2>&1 || true
rm -f -- "$BAT_RAW"

# Report
RESTORED=0
FAILED=0
while IFS='|' read -r FILE ORIG_TARGET RESOLVED; do
    [ -z "$FILE" ] && continue
    FULL_PATH="$REPO_ROOT/$FILE"
    TARGET_STR="${ORIG_TARGET:-$RESOLVED}"
    if [ -L "$FULL_PATH" ]; then
        RESTORED=$((RESTORED + 1))
        echo "  $FILE  ->  $TARGET_STR"
    else
        FAILED=$((FAILED + 1))
        echo "  $FILE  ->  $TARGET_STR  (FAILED to restore)" >&2
    fi
done < "$MANIFEST"

if [ "$RESTORED" -gt 0 ]; then
    echo "post-commit: restored $RESTORED symlink(s) in working tree:"
fi
if [ "$FAILED" -gt 0 ]; then
    echo "post-commit: $FAILED symlink(s) failed to restore (check Developer Mode / admin rights)" >&2
fi

rm -f -- "$MANIFEST"
exit 0
```

### 启用钩子

```bash
chmod +x .git/hooks/pre-commit .git/hooks/post-commit
```

---

## 一路上踩的坑

按踩坑顺序排，每条都附"症状 → 根因 → 修复"。

| # | 症状 | 根因 | 修复 |
|---|---|---|---|
| 1 | `cat src > dst` 之后源文件变 0 字节 | shell 重定向跟符号链接，把目标文件 truncate 了 | 先 `rm` 删链接，再写新文件 |
| 2 | `cp` 报 `cp: ... are the same file` 然后 exit 1 | MSYS 在跨盘符路径上会误判 | 不走 `cp`，改用 `rm + cat >` |
| 3 | commit 里 mode 还是 `120000` | `git add` 不会把已有 symlink 索引条目从 120000 改成 100644（`core.symlinks` 只影响 checkout） | 先 `git update-index --remove` 删条目，再 `git add` 重建为 100644 |
| 4 | `git rm --cached` 报 `staged content different from both the file and the HEAD` | 索引是路径字符串、工作树是源内容、HEAD 又是上一版源内容，三者全不一样，`rm --cached` 拒绝执行 | 改用 `git update-index --remove`，无条件删除 |
| 5 | pre-commit 看上去跑了但索引没变 | `update-index --remove` 在 `cat >` 之后调，文件已存在所以 `--remove` 不删 | 调换顺序：先 `rm`，再 `update-index --remove`，最后 `cat >` |
| 6 | 改完代码重新跑，pre-commit 不触发 | 重新 stage 后是 mode-only type change，`--diff-filter=AM` 不包含 T | 改成 `--diff-filter=AMT` |
| 7 | F 盘"符号链接"其实是源文件副本 | MSYS 的 `ln -s` 在 Windows 缺权限时退化为 `cp` | 改用 `cmd //c mklink` |
| 8 | `cmd /c "mklink ..."` 报 "filename syntax incorrect" | MSYS 的参数转义和 cmd 的 `+` 解析冲突 | 把 `mklink` 写到临时 `.bat` 再 `cmd //c <bat>` |
| 9 | `.bat` 里的中文路径在 mklink 时乱码（`M-eM-.M-^I...`） | `cygpath -w` 输出 UTF-8 字节流，cmd 默认 ANSI 码页 | `.bat` 顶部加 `chcp 65001 > nul` |

第 1 条还顺带把用户的源文件弄坏了——务必先在测试仓库跑通再用到生产源文件上。

---

## 调试方法

### 看钩子到底有没有跑

在钩子顶部加 `set -x`，git 会输出每条 bash 命令：

```bash
+ set -e
++ git rev-parse --show-toplevel
+ REPO_ROOT=...
+ STAGED='...'
...
```

### 看 mode 改没改

```bash
# commit 前（应看到 100644 + 源内容）
git ls-files --stage path/to/file
# commit 后
git ls-tree HEAD path/to/file
```

### 看 manifest 写没写

```bash
cat .git/symlinks-manifest
# 格式：<path>|<orig-target>|<resolved-abs>
# pre-commit 跑完会有，commit 完应被 post-commit 删掉
```

### 看 mklink 到底报什么

在 `.bat` 里 `mklink` 那行后面加 `echo errorlevel=%errorlevel%` 和 `pause`，手动跑 `.bat` 看输出。

### 单步复现 pre-commit 流程

```bash
# 把钩子当普通脚本跑
.git/hooks/pre-commit
# 或
bash -x .git/hooks/pre-commit
```

---

## 局限与替代方案

### 局限

- **依赖 Windows Developer Mode（或管理员权限）**——`mklink` 在普通 shell 下建不了真符号链接。
- **只对 staged 文件生效**——未 stage 的符号链接不会被处理（这其实正是想要的）。
- **不支持嵌套链接**——`readlink -f` 会把整条链解析到最终目标，post-commit 重建时也是单层。
- **多 commit 之间 manifest 不持久**——`post-commit` 跑完就删，万一 `post-commit` 挂了，需要手动 `mklink` 还原。

### 替代方案（按推荐度）

1. **直接在工作树里维护实文件**（最稳）——放弃符号链接，让仓库里就是源文件本身。代价是改源文件要双份。
2. **submodule / subtree**（重）——把源文件当另一个仓库 submodule 进当前仓库。
3. **用 [skillslm](https://www.npmjs.com/package/skillslm) 一键装全**（如果只是想用 skill）——不用自己维护符号链接。
4. **`pre-commit` + `post-commit` 钩子**（本文方案）——保留符号链接 + 仓库内是真内容，**适合**：
   - 源文件在仓库外、但想 GitHub 留副本
   - 多个项目共享同一份源文件
   - 不想装新工具

### 安全注意

- 钩子在你的 shell 权限下跑——`mklink` 失败时 `cmd //c` 不会阻断 commit（`|| true`），但**不会留下破损的链接**；残留的是 pre-commit 写进去的**实文件**，不会丢数据。
- 想强制阻断：在 `cmd //c` 那行去掉 `|| true`，并在 `post-commit` 末尾 `exit 1` 当 $FAILED > 0。

---

## 总结

> **博客里的"硬链接/符号链接 → 提交源内容"唯一可行方案"必须把源文件复制到仓库目录"，由 pre-commit + post-commit 钩子自动化掉了。**

技术选型回顾：
- 不用 `cp`（MSYS 跨盘符误报）
- 不用 `cat > file`（跟符号链接 truncate 源）
- 不用 `git rm --cached`（拒绝 staged-content-different）
- 不用 `ln -s`（Windows 退化为复制）
- 不用 `git add` 单独跑（不改 mode）
- 不用 `core.symlinks=true`（这只是 checkout 选项）
- **用 `rm` + `git update-index --remove` + `cat >` + `git add`**
- **用 `chcp 65001` + `.bat` + `mklink`**

调试重点：`set -x` 走一遍 + `git ls-files --stage` 看索引 + `git ls-tree HEAD` 看仓库。索引 mode 和内容是两件事，要分别验证。

---

> 写于 2026-07-07。Windows 10 + Git for Windows 2.x + MSYS / Git Bash。`core.symlinks=false`（仓库 local config 覆盖 system 的 true）。
