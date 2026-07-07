# Git Tag 标签管理

> 来源：[blogs/git_blogs/git_study.md](git_study.md) 的「tag 和代码是完全不相关的两条路径」+「打 tag 时自动附加到本地最新的 commit」两节。

发版时离不开 tag，但很多人把 tag 当分支用，或者忘了 `git push` 默认不带 tag——这篇文章把这两件事一次讲清楚。

---

## 目录

1. [两条互不干扰的通道](#两条互不干扰的通道)
2. [三个易混点](#三个易混点)
3. [推荐的工作流](#推荐的工作流)
4. [打 tag 的几种姿势](#打-tag-的几种姿势)
5. [轻量 tag vs 附注 tag](#轻量-tag-vs-附注-tag)
6. [验证当前 HEAD](#验证当前-head)

---

## 两条互不干扰的通道

| 通道 | 推送命令 | 拉取命令 |
| --- | --- | --- |
| **分支（代码）** | `git push origin main` | `git fetch origin main` |
| **Tag（标签）** | `git push origin v1.1.0` 或 `--tags` | `git fetch origin --tags` |

一次 `git fetch` 默认不会拉 tag，要显式加 `--tags`；一次 `git push` 默认不会推 tag，要显式带 tag 名（或 `--tags` / `--follow-tags`）。

---

## 三个易混点

1. **Tag 不是分支**——它是 commit 的别名（指向特定 commit），不是会前进的指针。所以 tag 一旦发布就**永远固定**在那一个 commit 上。
2. **代码 push 不带 tag**——`git push origin main` 不会把 `v1.1.0` 一起带走。先 `git push origin main` 再 `git push origin v1.1.0` 一定是两次操作。
3. **Tag 拉取默认也不带**——`git fetch` 不拉 tag，需要加 `--tags`。

---

## 推荐的工作流

```bash
# 1. 推送代码
git push origin main

# 2. 打 tag 并推送
git tag v1.2.0 -m "消息"
git push origin v1.2.0

# 或一次性推所有 tag
git push origin --tags

# 一键推送全部（commit + 关联的 tag）
git push --follow-tags
```

`--follow-tags` 是最优雅的：**只推送 HEAD 关联的 tag**（打过这个 commit 的那个），而不是所有本地 tag。在 release/release-tools 仓库里很常见。

---

## 打 tag 的几种姿势

执行 `git tag <name>` 不带任何 commit 参数时，**默认打在 HEAD 指向的最新 commit 上**。

```bash
# 打在最新 commit（默认）
git tag v1.2.0

# 打在指定 commit
git tag v1.2.0 abc1234
git tag v1.2.0 abc1234 -m "消息"

# 打在某个历史 commit
git tag v1.2.0 HEAD~3   # 往前数第 3 个
```

### 实际场景示例

```bash
# 场景1：发布后立刻打 tag（最常见）
git commit -m "feat: release v1.2.0"
git tag v1.2.0          # 自动打在刚才那个 commit
git push origin main
git push origin v1.2.0

# 场景2：补打历史 tag（忘了打）
git tag v1.1.0 abc1234  # 指定历史 commit hash
git push origin v1.1.0

# 场景3：打轻量 tag（不带消息）
git tag v1.2.0          # 轻量 tag（不推荐，建议带 -m）

# 场景4：打附注 tag（带消息，推荐）
git tag v1.2.0 -m "Release v1.2.0: 修复了 xxx bug"
```

---

## 轻量 tag vs 附注 tag

| 类型 | 命令 | 存储内容 | 推荐度 |
| :--- | :--- | :--- | :--- |
| 轻量 tag | `git tag v1.2.0` | 仅 commit hash | ❌ 不推荐 |
| 附注 tag | `git tag v1.2.0 -m "消息"` | commit hash + 打 tag 人 + 时间 + 消息 | ✅ 推荐 |

**附注 tag 相当于"带签名的里程碑"**，在 release 场景下更专业（`git describe` 能识别、CI/CD 可追溯）。

---

## 验证当前 HEAD

打 tag 之前先确认 HEAD 在哪：

```bash
# 查看当前所在 commit
git log -1 --oneline

# 或者
git rev-parse HEAD
```

打 tag 时不带 commit 参数会打在 HEAD 上：

```bash
git tag v1.2.0          # 会打在当前 HEAD
```

---

## 总结规则

> **`git tag <name>` = 永远打在当前 HEAD**（除非手动指定 commit）

完整发版流程：

```bash
# 1. 确保代码已提交
git add .
git commit -m "release v1.2.0"

# 2. HEAD 就是最新 commit，直接打 tag
git tag v1.2.0 -m "Release v1.2.0"

# 3. 推送（两条独立通道）
git push origin main
git push origin v1.2.0

# 或一键搞定
git push --follow-tags
```

这样 tag 就和代码 commit 一一对应——**tag 是代码快照的锚点**，不是独立分支。

---

> 写于 2026-07-07。