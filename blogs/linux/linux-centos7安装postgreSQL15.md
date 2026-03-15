chatgpt

### 1 先安装 PG 官方 repo：

CentOS 7

```bash
sudo yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
```

CentOS 8 / 9

```bash
sudo dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
```

（CentOS8+ 必须）禁用系统自带 PostgreSQL

CentOS 自带旧版本 PostgreSQL，需要关闭，否则会冲突：

```bash
sudo dnf -qy module disable postgresql
```

### 2 查看 repo 文件

```bash
vim /etc/yum.repos.d/pgdg-redhat-all.repo
```

### 3 禁用所有旧版本

编辑 repo 文件 /etc/yum.repos.d/pgdg-redhat-all.repo，修改：

```bash
enabled=0
```



### 4 清理缓存

```bash
sudo yum clean all
sudo yum makecache
```

### 5 安装 PostgreSQL 15

```bash
sudo yum install -y postgresql15-server postgresql15
```

### 6 初始化数据库 & 启动服务

```bash
# 初始化数据库
sudo /usr/pgsql-15/bin/postgresql-15-setup initdb
# 立即启动服务
sudo systemctl start postgresql-15
# 开机自动启动
sudo systemctl enable postgresql-15
```



### 7 检查版本

```bash
psql --version
```

输出: psql (PostgreSQL) 15.x

### 8 重设密码

建表语句失败，密码错误：

```bash
[root@VM-0-2-centos data_sim_card_purchase]# psql -h localhost -U postgres -d data_cards_database -f db/schema.sql
用户 postgres 的口令：
psql: 错误: 连接到"localhost" (::1)上的服务器，端口5432失败：FATAL:  password authentication failed for user "postgres"
```

#### 重设密码：

免密登录本地postgres用户：

```bash
sudo -i -u postgres
```

然后进入数据库：

```bash
psql
```

如果成功会看到：

```bash
postgres=#
```

重新设置 postgres 密码

在 psql 里执行：

```bash
ALTER USER postgres PASSWORD '你的新密码';
```

### 9 创建数据库



创建数据库：

```
CREATE DATABASE data_cards_database;
```

退出：

```bash
\q
```

登录本地postgres账户，进入postgre的shell：

```bash
sudo -i -u postgres
```

非postgres账户的话，输入刚刚设置的密码即可。

导入 schema：

```bash
psql -d data_cards_database -f /opt/data_sim_card_purchase/db/schema.sql
```

或者一行命令登录加创建表：

```bash
sudo -i -u postgres psql -d data_cards_database -f /opt/data_sim_card_purchase/db/schema.sql
```

### 10 psql常用命令

先在终端输入：

```bash
sudo -i -u postgres psql
```

上面这是两个分开的命令组合到一起，直接进入postgre的shell psql。

此时终端开头的提示是postgres=# 

1.查看所有数据库

```sql
\l
```

2.切换到其他数据库

```sql
-- 如果有其他数据库，可以切换
\c database_name

-- 比如切换到data_cards_database数据库
\c data_cards_database
```

此时终端开头的提示符为：data_cards_database=# 



3.查看表信息

```sql
-- 查看表信息
\dt
```


4.查看系统表

```sql
-- 查看系统表（包括所有表）
\dt *

-- 查看所有关系对象
\dtS
```



退出 psql

```sql
\q
```



查看表结构，确认字段名

```sql
-- 先查看表结构，了解有哪些字段
\d data_cards

-- 然后查询特定字段
SELECT 字段名1, 字段名2 FROM data_cards;
```





### **总结**

CentOS 7 上安装 PG 官方包必须：

1. 禁用过期仓库（pgdg12、pgdg13、pgdg14…）
2. 只启用你要安装的版本（pgdg15）
3. 清理缓存，再安装



