# 1 GitHub Actions CI/CD流程

看到你已经有了一套基于`tar`+`SSH`的部署脚本，这为迁移到GitHub Actions提供了很好的基础。你的项目是一个Python FastAPI应用，包含爬虫功能，目前通过脚本将整个项目目录（排除虚拟环境等）打包传输到云服务器。

## 📋 现有部署流程分析

你当前的`sync_to_cloud_server_find_tar.sh`脚本执行以下操作：

1. 使用`find`命令收集项目文件，排除`.git`、`.venv`、`__pycache__`等目录
2. 通过`tar`打包文件
3. 使用`ssh`传输到服务器`root@49.235.115.43`
4. 在`/opt/data_sim_card_purchase`目录下解压

## 🚀 GitHub Actions迁移方案

下面是一个针对你项目的完整GitHub Actions工作流配置，它复制了你现有脚本的功能，同时增加了安全性和自动化。

### 第一步：设置GitHub Secrets

在GitHub仓库中，进入 **Settings → Secrets and variables → Actions**，添加以下Secrets：

| Secret名称          | 说明               | 示例值                               |
| ------------------- | ------------------ | ------------------------------------ |
| `SERVER_HOST`       | 服务器IP地址       | `49.235.115.43`                      |
| `SERVER_USERNAME`   | SSH用户名          | `root`                               |
| `SERVER_SSH_KEY`    | SSH私钥内容        | `-----BEGIN RSA PRIVATE KEY-----...` |
| `DATABASE_PASSWORD` | 数据库密码（可选） | `your_db_password`                   |

**注意**：不要在代码中硬编码`config.yaml`里的数据库密码，应通过Secrets传递环境变量。

### 第二步：创建GitHub Actions工作流文件

在项目根目录创建`.github/workflows/deploy.yml`：



```yaml
name: 自动部署到云服务器

on:
  push:
    branches: [ main ]
  # 可选：手动触发部署
  workflow_dispatch:

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: 检出代码
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: 设置Python环境
        uses: actions/setup-python@v5
        with:
          python-version: '3.12'
          cache: 'uv'

      - name: 安装uv（快速Python包管理）
        run: |
          pip install uv
          uv --version

      - name: 安装项目依赖
        run: |
          uv sync --frozen --no-dev

      - name: 安装Playwright浏览器
        run: |
          uv run playwright install chromium --with-deps

      - name: 创建安全的配置文件
        run: |
          # 使用环境变量替换config.yaml中的敏感信息
          cat > config.yaml << 'EOF'
          # 号卡爬虫与数据库配置
          # 敏感信息已通过环境变量注入
          
          # ---------- 爬虫配置 ----------
          scrape:
            store_list_url: "https://h5.yapingkeji.com/#/pages/sales_index/my_store?mall_id=nX0WCe8vxIuIwEsXZH9r0g%253D%253D&__s=&appId="
          
          # ---------- PostgreSQL 连接 ----------
          database:
            host: localhost
            port: 5432
            user: postgres
            password: "${{ secrets.DATABASE_PASSWORD }}"
            database: data_cards_database
          EOF

      - name: 打包项目文件
        run: |
          # 创建排除列表，与你的find命令保持一致
          tar --exclude='.git' \
              --exclude='.venv' \
              --exclude='__pycache__' \
              --exclude='*.Shortcut.lnk' \
              --exclude='spider/scrape_results_20260313_015013' \
              --exclude='spider/scrape_results_20260313_040938/*' \
              --include='spider/scrape_results_20260313_040938/data_cards.json' \
              -czf deploy.tar.gz .

      - name: 传输文件到服务器
        uses: appleboy/scp-action@v0.1.7
        with:
          host: ${{ secrets.SERVER_HOST }}
          username: ${{ secrets.SERVER_USERNAME }}
          key: ${{ secrets.SERVER_SSH_KEY }}
          source: "deploy.tar.gz"
          target: "/opt/data_sim_card_purchase/"
          strip_components: 0

      - name: 在服务器上执行部署命令
        uses: appleboy/ssh-action@v1.0.3
        with:
          host: ${{ secrets.SERVER_HOST }}
          username: ${{ secrets.SERVER_USERNAME }}
          key: ${{ secrets.SERVER_SSH_KEY }}
          script: |
            cd /opt/data_sim_card_purchase
            
            # 备份当前版本（可选）
            if [ -d "current" ]; then
              timestamp=$(date +%Y%m%d_%H%M%S)
              mv current "backup_$timestamp"
            fi
            
            # 解压新版本
            tar xzf deploy.tar.gz
            
            # 清理临时文件
            rm deploy.tar.gz
            
            # 设置Python虚拟环境
            if [ ! -d ".venv" ]; then
              python3.12 -m venv .venv
            fi
            
            # 激活虚拟环境并安装依赖
            source .venv/bin/activate
            pip install uv
            uv sync --frozen --no-dev
            uv run playwright install chromium --with-deps
            
            # 重启服务（根据你的实际情况调整）
            # 如果有systemd服务
            # systemctl restart data-sim-card-api
            
            # 或者使用pm2
            # pm2 restart all
            
            # 或者直接启动（适合开发环境）
            echo "启动FastAPI服务..."
            nohup uv run python -m backend.main > app.log 2>&1 &
            
            echo "✅ 部署完成！"
            echo "服务日志: /opt/data_sim_card_purchase/app.log"
```

### 第三步：优化配置（可选）

#### 方案A：使用Docker（推荐）

如果你能使用Docker，部署会更简洁：



```yaml
# 在服务器端执行
- name: 使用Docker部署
  uses: appleboy/ssh-action@v1.0.3
  with:
    host: ${{ secrets.SERVER_HOST }}
    username: ${{ secrets.SERVER_USERNAME }}
    key: ${{ secrets.SERVER_SSH_KEY }}
    script: |
      cd /opt/data_sim_card_purchase
      docker-compose down
      docker-compose pull
      docker-compose up -d
```

#### 方案B：使用rsync（增量同步）

如果你希望更快地部署，可以使用rsync替代tar：



```yaml
- name: 使用rsync同步文件
  uses: burnett01/rsync-deployments@6.0.0
  with:
    switches: -avzr --delete
    path: ./
    remote_path: /opt/data_sim_card_purchase/
    remote_host: ${{ secrets.SERVER_HOST }}
    remote_user: ${{ secrets.SERVER_USERNAME }}
    remote_key: ${{ secrets.SERVER_SSH_KEY }}
    extra_opts: |
      --exclude=.git
      --exclude=.venv
      --exclude=__pycache__
      --exclude=*.Shortcut.lnk
      --exclude=spider/scrape_results_20260313_015013
      --exclude=spider/scrape_results_20260313_040938/*
      --include=spider/scrape_results_20260313_040938/data_cards.json
```

## 🔧 迁移步骤总结

1. **备份现有部署脚本**：保留你的`sync_to_cloud_server_find_tar.sh`作为参考

2. **设置GitHub Secrets**：添加服务器连接信息

3. **创建工作流文件**：将上面的`deploy.yml`保存到`.github/workflows/`

4. **调整排除规则**：根据你的项目需要修改tar/rsync的排除模式

5. 测试部署

   ：

   - 提交到测试分支先验证
   - 使用`workflow_dispatch`手动触发第一次部署

6. **监控与优化**：查看GitHub Actions日志，调整部署脚本

## 📊 前后对比

| 方面         | 当前方案 (tar+SSH) | GitHub Actions方案       |
| ------------ | ------------------ | ------------------------ |
| **触发方式** | 手动执行脚本       | 自动（git push）或手动   |
| **安全性**   | 密码在脚本或本地   | 通过GitHub Secrets管理   |
| **可重复性** | 依赖本地环境       | 标准化的虚拟环境         |
| **日志记录** | 本地终端输出       | GitHub Web界面，永久保存 |
| **错误处理** | 手动检查           | 自动失败通知，重试机制   |
| **扩展性**   | 修改脚本           | 添加测试、通知等步骤     |

## 🚨 重要注意事项

1. **数据库密码**：不要在`config.yaml`中硬编码密码，使用环境变量或Secrets
2. **文件权限**：确保服务器上的目录有正确的读写权限
3. **服务管理**：建议使用systemd或Docker管理FastAPI服务，而不是简单的nohup
4. **备份策略**：工作流中包含简单备份，可考虑更完整的备份方案
5. **监控**：添加健康检查步骤，确保部署后服务正常运行

## 🎯 下一步建议

1. **先测试**：在非生产服务器上测试整个流程

2. 分阶段迁移

   ：

   - 阶段1：只做文件同步，手动在服务器上启动服务
   - 阶段2：添加自动依赖安装
   - 阶段3：添加自动服务重启

3. **添加质量门禁**：在部署前加入代码检查、测试步骤

4. **设置通知**：添加Slack/邮件通知，了解部署状态

这个方案直接基于你现有的部署逻辑，保持了相同的文件排除模式，同时利用GitHub Actions提供了完整的自动化流水线。有什么具体部分需要调整或进一步解释的吗？

在GitHub仓库中，进入 Settings → Secrets and variables → Actions后，Environment secrets 还是 Repository secrets

# 2 Environment secrets 还是 Repository secrets

问：在GitHub仓库中，进入 Settings → Secrets and variables → Actions后，Environment secrets 还是 Repository secrets



对于你目前的单一云服务器部署场景，我推荐使用 **Repository secrets**。原因如下：

## 🎯 推荐：Repository secrets

### 为什么选择Repository secrets？

1. **简单直接**：部署到单个云服务器，不需要复杂的环境区分
2. **全局可用**：所有workflow都能访问这些secrets
3. **配置简单**：不需要额外创建environments
4. **符合你的需求**：你只有一个生产服务器，没有开发/测试环境分离

### 具体要添加的Repository secrets：

- `SERVER_HOST` = `49.235.115.43`
- `SERVER_USERNAME` = `root`
- `SERVER_SSH_KEY` = 你的SSH私钥内容
- `DATABASE_PASSWORD` = 数据库密码（从config.yaml中移除硬编码）

## 🔄 Environment secrets的适用场景

如果你**未来**需要区分不同环境，比如：

- 开发服务器 vs 生产服务器
- 测试数据库 vs 生产数据库
- 不同的API密钥用于不同环境

这时候可以使用Environment secrets。你需要：

1. 创建environments（如`production`, `staging`）
2. 为每个environment配置各自的secrets
3. 在workflow中指定environment：



```yaml
jobs:
  deploy:
    environment: production  # 引用production环境
    steps:
      # 可以使用production环境的secrets
```

## 📝 操作步骤总结

### 使用Repository secrets的步骤：

1. 进入仓库 → **Settings → Secrets and variables → Actions**
2. 点击 **New repository secret**
3. 输入Name和Value
4. 重复添加所有需要的secrets

### 在工作流中引用（自动可用）：



```yaml
host: ${{ secrets.SERVER_HOST }}  # 直接引用，无需额外配置
```

## 💡 建议方案

**立即采用**：Repository secrets

- 快速实现自动化部署
- 配置简单，适合当前单一服务器场景

**未来扩展**：如果需要多环境

1. 创建`production` environment
2. 将现有secrets迁移到environment中
3. 更新workflow指定environment

## ⚠️ 安全提醒

无论选择哪种，都要注意：

1. **不要**在代码中硬编码任何敏感信息
2. **定期轮换**SSH密钥和数据库密码
3. **限制访问**：确保只有必要人员能查看/修改secrets
4. **使用强密码**：特别是数据库密码

## 📊 对比总结

| 特性           | Repository secrets | Environment secrets      |
| -------------- | ------------------ | ------------------------ |
| **配置复杂度** | 低                 | 中（需创建environments） |
| **适用场景**   | 单一环境部署       | 多环境（开发/测试/生产） |
| **访问控制**   | 仓库级别           | 环境+仓库级别            |
| **你的情况**   | ✅ 推荐             | 未来可考虑               |

**结论**：对于你现在"GitHub私有仓库 → 单台云服务器"的部署模式，Repository secrets完全够用，是最简单直接的选择。

还有什么关于GitHub Actions配置的问题吗？

SERVER_SSH_KEY = 你的SSH私钥内容 是我本地计算机上生成的id_rsa还是id_rsa.pub？还是服务器上面的id_rsa还是id_rsa.pub？

这是一个关键的安全配置问题！让我详细解释：

# 3 SSH私钥是我本地的id_rsa还是服务器的？

问：SERVER_SSH_KEY = 你的SSH私钥内容 是我本地计算机上生成的id_rsa还是id_rsa.pub？还是服务器上面的id_rsa还是id_rsa.pub？

## 🔐 正确配置：`SERVER_SSH_KEY` = **本地私钥内容**

### SSH认证流程：



```
GitHub Actions (客户端) → SSH连接 → 云服务器 (服务端)
        私钥(id_rsa)                     公钥(id_rsa.pub)
```

### 具体操作步骤：

#### 第一步：生成专用SSH密钥对（推荐）



```bash
# 在本地生成专门用于GitHub Actions的密钥对
ssh-keygen -t rsa -b 4096 -C "github-actions-deploy@data_sim_card_purchase" -f github-actions-deploy-data_sim_card_purchase

# 生成两个文件：
# - github-actions-deploy-data_sim_card_purchase      ← 私钥（给GitHub Actions）
# - github-actions-deploy-data_sim_card_purchase.pub  ← 公钥（给服务器）
```

#### 第二步：添加公钥到服务器



```bash
# 1. 将公钥内容复制到剪贴板
cat github-actions-deploy-data_sim_card_purchase.pub

# 2. SSH登录到你的云服务器
ssh root@49.235.115.43

# 3. 在服务器上添加公钥
echo "粘贴你的公钥内容" >> ~/.ssh/authorized_keys

# 4. 设置正确权限
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh

# 5. 测试连接（本地测试）
ssh -i github-actions-deploy-data_sim_card_purchase root@49.235.115.43
```

#### 第三步：配置GitHub Secrets



```
SERVER_SSH_KEY = github-actions-deploy-data_sim_card_purchase文件的内容
（以 -----BEGIN RSA PRIVATE KEY----- 开头的内容）
```

### 📁 文件对应关系表：

| 文件/位置                                              | 内容类型 | 用途                                  | 示例                                                         |
| ------------------------------------------------------ | -------- | ------------------------------------- | ------------------------------------------------------------ |
| **本地：github-actions-deploy-data_sim_card_purchase** | **私钥** | 添加到GitHub Secrets `SERVER_SSH_KEY` | `-----BEGIN RSA PRIVATE KEY-----...`                         |
| **服务器：~/.ssh/authorized_keys**                     | **公钥** | 允许GitHub Actions连接                | `ssh-rsa AAAAB3NzaC1... github-actions-deploy-data_sim_card_purchase` |

### ⚠️ 重要安全提醒：

1. **不要使用现有的个人密钥**：

   - ❌ 不要用你日常登录的`id_rsa`
   - ✅ 创建专用于GitHub Actions的新密钥对

2. **权限限制**：

   - 考虑创建专用部署用户（非root）
   - 限制该密钥只能执行特定命令

3. **测试密钥**：

   

   ```bash
   # 测试新密钥能否连接服务器
   ssh -i github-actions-deploy-data_sim_card_purchase root@49.235.115.43 echo "连接成功"
   ```

### 🔧 如果你的服务器已有SSH密钥：

如果你已经有可以连接服务器的密钥对：

1. **找到本地私钥**：

   ```bash
   # 通常是 ~/.ssh/id_rsa
   cat ~/.ssh/id_rsa
   ```

2. **确保服务器有对应公钥**：

   

   ```bash
   # 在服务器上检查
   cat ~/.ssh/authorized_keys
   
   # 如果没有，添加本地公钥
   cat ~/.ssh/id_rsa.pub | ssh root@49.235.115.43 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
   ```

3. **将私钥内容复制到`SERVER_SSH_KEY`**

### 📋 总结：该用哪个文件？

| 场景             | 使用哪个文件                                                 | 为什么                           |
| ---------------- | ------------------------------------------------------------ | -------------------------------- |
| **新建专用密钥** | 本地生成的`github-actions-deploy-data_sim_card_purchase`（私钥） | 安全最佳实践，职责分离           |
| **使用现有密钥** | 本地的`~/.ssh/id_rsa`（私钥）                                | 方便，但安全性较低               |
| **绝对不要**     | 服务器上的任何密钥                                           | GitHub Actions无法访问服务器文件 |
| **绝对不要**     | `.pub`公钥文件                                               | 公钥用于验证，私钥用于认证       |

### 🚨 安全等级排序：

1. ✅ **最佳**：创建专用于GitHub Actions的新密钥对
2. ⚠️ **可用**：使用现有的个人密钥（但不推荐）
3. ❌ **危险**：共享密钥、明文存储密码

**建议**：花5分钟生成新的专用密钥对，这是最安全、最规范的做法。

需要我帮你生成具体的命令行步骤，还是对某个部分有疑问？

# 4 使用rsync（增量同步）

## 🔧 高级rsync配置选项

### 1. **仅同步特定文件类型**（如果需要）



```yaml
extra_opts: |
  --include="*.py"
  --include="*.yaml"
  --include="*.json"
  --include="*.md"
  --include="*/"
  --exclude="*"
```

### 2. **带宽限制**（避免影响服务器性能）



```yaml
switches: -avzr --delete --bwlimit=1000  # 限制为1000KB/s
```

### 3. **对比模式**（先检查差异，不实际传输）



```yaml
switches: -avzr --dry-run  # 只显示差异，不实际传输
```

### 4. **排除大文件**



```yaml
extra_opts: |
  --max-size=10M  # 排除大于10MB的文件
  --exclude="*.log"
  --exclude="*.tar.gz"
  --exclude="*.zip"
```

## 🚀 快速开始步骤

### 第一步：准备SSH密钥

```bash
# 生成专用密钥对
ssh-keygen -t rsa -b 4096 -C "github-actions-rsync" -f github-actions-rsync

# 添加公钥到服务器
cat github-actions-rsync.pub | ssh root@49.235.115.43 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```

### 第二步：设置GitHub Secrets

在仓库的 **Settings → Secrets → Actions** 中添加：

- `SERVER_HOST`: `49.235.115.43`
- `SERVER_USERNAME`: `root`
- `SERVER_SSH_KEY`: `github-actions-rsync`文件的内容
- `DATABASE_PASSWORD`: 你的数据库密码

### 第三步：创建工作流文件

1. 创建目录：`.github/workflows/`
2. 创建文件：`deploy-rsync.yml`（使用上面的完整配置）
3. 根据你的需要调整排除规则

### 第四步：测试部署

```bash
# 提交并推送
git add .github/workflows/deploy-rsync.yml
git commit -m "添加github-action自动部署"
git push origin main

# 在GitHub上查看Actions运行情况
```

## 🔍 排除规则说明

你的现有排除规则翻译成rsync格式：

```bash
# 你的find命令排除：
# -not -path "*/.git/*"
# -not -path "*/.venv/*"
# -not -path "*/__pycache__/*"
# -not -path "*/spider/scrape_results_20260313_015013/*"
# -not -path "*Shortcut.lnk*"
# 但包含：-path "*/spider/scrape_results_20260313_040938/data_cards.json"

# 对应的rsync排除：
--exclude=.git          # 排除.git目录
--exclude=.venv         # 排除虚拟环境
--exclude=__pycache__   # 排除Python缓存
--exclude=spider/scrape_results_20260313_015013  # 排除旧爬虫结果
--exclude=*.Shortcut.lnk  # 排除Windows快捷方式
--include=spider/scrape_results_20260313_040938/data_cards.json  # 包含特定文件
--exclude=spider/scrape_results_20260313_040938/*  # 排除其他文件
```

## ⚠️ 常见问题解决

### 1. **rsync权限错误**

```yaml
# 在extra_opts中添加：
extra_opts: |
  --no-perms  # 不保留权限（避免权限问题）
  --chmod=755  # 设置特定权限
```

### 2. **连接超时**



```yaml
# 添加超时参数
switches: -avzr --delete --timeout=30
```

### 3. **服务器端目录不存在**



```yaml
# 在SSH步骤中先创建目录
script: |
  mkdir -p /opt/data_sim_card_purchase
  # ... rsync同步
```

### 4. **排除.git但保留其他点文件**



```yaml
extra_opts: |
  --exclude=/.git  # 只排除根目录的.git
  --include=.*  # 包含其他点文件
  --exclude=.*/  # 但排除点文件目录
```

## 💡 优化建议

1. **分阶段部署**：

   - 第一阶段：只做rsync文件同步
   - 第二阶段：添加依赖安装
   - 第三阶段：添加服务重启

2. **添加回滚机制**：

   

   ```bash
   # 在服务器上备份当前版本
   cp -r /opt/data_sim_card_purchase /opt/data_sim_card_purchase_backup_$(date +%Y%m%d_%H%M%S)
   ```

3. **监控和通知**：

   - 添加Slack/邮件通知
   - 记录部署历史

4. **并行操作**：

   

   ```yaml
   # 可以同时部署到多个服务器
   strategy:
     matrix:
       server: [server1, server2]
   ```

# 5 我的服务器是centos7，runs-on: ubuntu-latest这里是不是要改？

## `runs-on: ubuntu-latest` 需要改吗？

**简短回答：不需要改，保持 `ubuntu-latest` 即可。**

### 为什么不需要改？

| 环境                                  | 作用                     | 示例                                      |
| ------------------------------------- | ------------------------ | ----------------------------------------- |
| **GitHub Actions Runner** (`runs-on`) | 执行工作流步骤的"构建机" | 在Ubuntu上运行git clone、安装uv、打包文件 |
| **目标服务器** (你的CentOS 7)         | 代码最终运行的"生产环境" | 通过SSH接收文件、安装依赖、启动服务       |

**关键点**：Runner是"打包工"，服务器是"运行地"，它们可以是不同的操作系统。

# 移除runner上的依赖安装、部署状态通知

## 移除runner上的依赖安装（可选）

如果你不需要在runner上验证依赖，可以简化：

```yaml
# 可以移除或简化这个步骤
- name: 安装uv和依赖（用于本地验证）
  run: |
    pip install uv  # 只安装uv，不安装项目依赖
    # 移除 uv sync 和 playwright install
```

## 添加部署状态通知

```yaml
- name: 部署状态通知
  if: always()
  run: |
    # 发送到Slack/钉钉/邮件等
    echo "部署完成状态: ${{ job.status }}"
```