# 清理GitHub远端.git目录的内容历史记录 — 完整过程记录

> 仓库：`UryWu/urywu.github.io`
> 时间：2026-07-09
> 工具：BFG Repo-Cleaner 1.15.0
> 结果：✅ 成功

---

## 一、问题背景

- 仓库 `.git` 目录膨胀到 180+MB
- 历史中有大量大文件（zip、7z、rar、psd 等）需要彻底清理

---

## 二、解决方案：BFG Repo-Cleaner

```bash
cd "G:\Projects\projects_others\temp\urywu.github.io"

# 1. 扫描并重写历史：删除所有 >1MB 的 blob
java -jar bfg-1.15.0.jar --strip-blobs-bigger-than 1M

# 2. 清理 reflog 和 gc
git reflog expire --expire=now --all
git gc --prune=now --aggressive

# 3. 推送（远端有旧 commit，先尝试普通推送，被拒后强制推送）
git push
git push -f
```

---

## 三、BFG 执行结果

- 扫描到 **135 个 packfile blob**
- 发现 **13 个大 blob**（>1MB）
- 共 **37 个 commit**
- 重写 **75 个 object id**
- `refs/heads/main`：`97153cdc` → `14aa7bfc`

### 删除的文件清单

| 文件名 | 大小 |
|--------|------|
| Beyond Compare 4.7z | 22.7 MB |
| ChsPinyinEUDPv1.lex | 2.1 MB |
| TabSuspender.rar | 2.1 MB |
| get_code.7z | 5.6 MB |
| get_code.rar | 9.3 MB |
| get_code.zip | 10.2 MB |
| tampermonkey-backup-chrome-2023-11-23T01-39-20-944Z.txt | 5.1 MB |
| tampermonkey_beta.rar | 1.4 MB |
| tianruoocr-cl-v1.3.8.2.7z | 46.8 MB |
| typora1.2.4-Windows(破解包).zip | 72.1 MB |
| 剧本杀背景.psd | 8.8 MB |
| 小鹤音形for手机搜狗百度自定义方案.txt | 1.1 MB |
| 小鹤音形自定义短语导入.dat | 2.0 MB |

**累计删除：约 198MB**

---

## 四、推送结果

```
$ git push
To https://github.com/UryWu/urywu.github.io
 ! [rejected]        main -> main (fetch first)
error: failed to push some refs to 'https://github.com/UryWu/urywu.github.io'

$ git push -f
Enumerating objects: 135, done.
Counting objects: 100% (135/135), done.
Delta compression using up to 12 threads
Compressing objects: 100% (76/76), done.
Writing objects: 100% (135/135), 2.71 MiB | 39.63 MiB/s, done.
Total 135 (delta 45), reused 135 (delta 45), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (45/45), done.
To https://github.com/UryWu/urywu.github.io
 + 97153cd...14aa7bf main -> main (forced update)
```

---

## 五、最终状态

```
$ git log
commit 14aa7bfc91b2b7b43c0b929f208974ac50e1dddc (HEAD -> main, origin/main, origin/HEAD)
Author: UryWu <urywu@qq.com>
Date:   Thu Jul 9 03:00:35 2026 +0800

    delete: all stuff, because I move them to other place
    Former-commit-id: 97153cdc764751aa7f1440c4ee7aff45f02d201e

commit 4a2741485d79a6d56e18e515063c4fe3baa41eb6
Author: UryWu <urywu@qq.com>
Date:   Wed Jul 8 23:55:32 2026 +0800

    docs: 提交主页
    Former-commit-id: 74e48d01374c778e18c73139f202af35cce67a78
...
```

每个 commit message 都保留了 `Former-commit-id: xxx` 字段，方便追溯原始 commit。

---

## 六、后续验证

为了确认远端真的清理干净了，需要重新克隆到全新目录：

```bash
cd "G:\Projects\projects_others\temp"
rm -rf verify-clone
git clone https://github.com/UryWu/urywu.github.io.git verify-clone
du -sh verify-clone/.git
```

预期结果：`.git` 应该只有 **几十 KB**，不再是 180+MB。

---

## 七、服务端清理

### 方法一 提交工单让github官方清理

website:

```
https://support.github.com/contact-next/product-selection/repositories?source=default
```

subjects:

```
需要帮助清理UryWu/urywu.github.io仓库的孤儿对象
```

Please describe your repository issue:

```
我刚用 BFG 清理了 UryWu/urywu.github.io 仓库的历史大文件（已 force push 完成，新的 main 只有 5 个 commit）。但仓库的存储空间统计仍然是180+MB，应该是被 force push丢弃的孤儿对象还残留在对象库里。请帮忙对这个仓库运行一次 git gc --prune=now 清理孤儿对象。
```



### 方法二 删掉仓库后重建



## 八、经验总结

### 关键命令

1. **BFG 主体**：`java -jar bfg.jar --strip-blobs-bigger-than 100M`
2. **清理三件套**：`reflog expire` + `gc --prune=now --aggressive` + `push -f`
3. **按类型删文件**：`--delete-files "*.zip"`

### 注意事项

- BFG 会保护当前 HEAD 的 commit，如果要彻底清空，可以 `--no-blob-protection`
- 强推会丢失所有远端历史——所有协作者必须重新 clone
- GitHub 不会自动 GC 孤儿对象，必须主动清理（bfg / filter-repo / 联系 Support）
- fork 出去的仓库清理不掉，需要联系 GitHub Support