我现在想同步项目到linux服务器上。

### 目标是热部署最好的工具rsync

如果你的目标是 热部署（只更新修改的文件，不影响服务运行），最好的工具其实就是：

rsync

因为它有 **增量同步**，不会重新上传所有文件，非常适合代码部署。



#### 一、最推荐的热部署命令

```bash
rsync -avzP \
--delete \
--exclude '.git' \
--exclude '.venv' \
--exclude '__pycache__' \
--exclude 'spider/scrape_results_*' \
./data_sim_card_purchase/ root@49.235.115.43:/opt/data_sim_card_purchase/
```



参数解释

| 参数        | 作用                 |
| ----------- | -------------------- |
| `-a`        | 保留权限、时间等     |
| `-v`        | 显示详细信息         |
| `-z`        | 压缩传输             |
| `-P`        | 显示进度             |
| `--delete`  | 删除服务器上多余文件 |
| `--exclude` | 排除目录             |
| `--include` | 包含目录             |



**效果**

只同步 **改动文件**，例如：

```bash
sending incremental file list
app.py
utils/db.py
```

速度会非常快。



#### 二、真正的“热部署”标准做法

实际生产环境一般：

```
rsync代码
↓
重启服务
```

例如：

```bash
rsync -avzP --exclude '.venv' ./data_sim_card_purchase/ root@49.235.115.43:/opt/data_sim_card_purchase/ \
&& ssh root@49.235.115.43 "systemctl restart data-sim.service"
```

或

```bash
rsync -avzP --delete \
--exclude='.git' \
--exclude='.venv' \
--exclude='__pycache__' \
./data_sim_card_purchase/ \
root@49.235.115.43:/opt/data_sim_card_purchase/ \
&& ssh root@49.235.115.43 "systemctl restart data_sim"
```



#### 三、Python项目热部署（推荐）

如果你是 **FastAPI / Flask / 爬虫 API**：

可以：

```
rsync 同步代码
↓
reload 进程
```

例如：

```bash
rsync -avzP --exclude '.venv' ./data_sim_card_purchase/ root@49.235.115.43:/opt/data_sim_card_purchase/ \
&& ssh root@49.235.115.43 "pkill -f uvicorn"
```



#### 四、真正专业的部署方案（行业常见）

三种：

| 方案   | 使用场景          |
| ------ | ----------------- |
| rsync  | 小项目 / 个人项目 |
| CI/CD  | 团队开发          |
| Docker | 微服务            |



### 方案 1：用 cwRsync（纯 Windows 可执行文件）

#### 安装 MSYS2：

https://www.msys2.org/

------

#### 安装 rsync

打开 MSYS2 终端MSYS.lnk

在 MSYS2 终端：

```bash
pacman -Sy rsync
```

-Sy是来更新依赖后安装rsync，-S只安装。

安装完成。

#### 下载 cwRsync

官网： https://www.itefix.net/cwrsync

安装后，把 rsync.exe 加入 系统 PATH

我加入系统PATH的路径：`G:\softwares\cwrsync_6.4.7_x64_free\bin`

Windows CMD / Git Bash 就可以直接用：

```bash
rsync -avz ...
```

### bugs

#### bug1 error: failed retrieving file 'libxxx':

##### **description:**

When execute code:

```
pacman -S rsync
```



Exception output:

```bash
UryWu@MacBookPro MSYS ~
$ pacman -S rsync
resolving dependencies...
looking for conflicting packages...

Packages (2) libxxhash-0.8.0-1  rsync-3.2.3-1

Total Download Size:   0.36 MiB
Total Installed Size:  0.68 MiB

:: Proceed with installation? [Y/n] y
:: Retrieving packages...
 libxxhash-0.8.0-1-x86_64.pkg.tar.zst failed to download
 rsync-3.2.3-1-x86_64.pkg.tar.zst failed to download
 Total (2/2)           368.4 KiB  6.69 KiB/s 00:55 [#####################] 100%
error: failed retrieving file 'rsync-3.2.3-1-x86_64.pkg.tar.zst' from mirror.msys2.org : The requested URL returned error: 404
error: failed retrieving file 'libxxhash-0.8.0-1-x86_64.pkg.tar.zst' from mirror.msys2.org : The requested URL returned error: 404
error: failed retrieving file 'libxxhash-0.8.0-1-x86_64.pkg.tar.zst' from repo.msys2.org : The requested URL returned error: 404
error: failed retrieving file 'rsync-3.2.3-1-x86_64.pkg.tar.zst' from repo.msys2.org : The requested URL returned error: 404
error: failed retrieving file 'libxxhash-0.8.0-1-x86_64.pkg.tar.zst' from mirror.yandex.ru : The requested URL returned error: 404
error: failed retrieving file 'rsync-3.2.3-1-x86_64.pkg.tar.zst' from mirror.yandex.ru : The requested URL returned error: 404
error: failed retrieving file 'libxxhash-0.8.0-1-x86_64.pkg.tar.zst' from download.nus.edu.sg : SSL certificate problem: certificate has expired
error: failed retrieving file 'rsync-3.2.3-1-x86_64.pkg.tar.zst' from download.nus.edu.sg : SSL certificate problem: certificate has expired
error: failed retrieving file 'libxxhash-0.8.0-1-x86_64.pkg.tar.zst' from ftp.acc.umu.se : The requested URL returned error: 404
error: failed retrieving file 'rsync-3.2.3-1-x86_64.pkg.tar.zst' from ftp.acc.umu.se : The requested URL returned error: 404
error: failed retrieving file 'rsync-3.2.3-1-x86_64.pkg.tar.zst' from ftp.nluug.nl : The requested URL returned error: 404
error: failed retrieving file 'libxxhash-0.8.0-1-x86_64.pkg.tar.zst' from ftp.nluug.nl : The requested URL returned error: 404
error: failed retrieving file 'libxxhash-0.8.0-1-x86_64.pkg.tar.zst' from ftp.osuosl.org : The requested URL returned error: 404
error: failed retrieving file 'rsync-3.2.3-1-x86_64.pkg.tar.zst' from ftp.osuosl.org : The requested URL returned error: 404
error: failed retrieving file 'libxxhash-0.8.0-1-x86_64.pkg.tar.zst' from mirror.clarkson.edu : The requested URL returned error: 404
error: failed retrieving file 'rsync-3.2.3-1-x86_64.pkg.tar.zst' from mirror.clarkson.edu : The requested URL returned error: 404
error: failed retrieving file 'libxxhash-0.8.0-1-x86_64.pkg.tar.zst' from mirror.internet.asn.au : The requested URL returned error: 404
error: failed retrieving file 'rsync-3.2.3-1-x86_64.pkg.tar.zst' from mirror.internet.asn.au : The requested URL returned error: 404
error: failed retrieving file 'libxxhash-0.8.0-1-x86_64.pkg.tar.zst' from mirror.selfnet.de : The requested URL returned error: 404
error: failed retrieving file 'rsync-3.2.3-1-x86_64.pkg.tar.zst' from mirror.selfnet.de : The requested URL returned error: 404
error: failed retrieving file 'rsync-3.2.3-1-x86_64.pkg.tar.zst' from mirror.ufro.cl : The requested URL returned error: 404
error: failed retrieving file 'libxxhash-0.8.0-1-x86_64.pkg.tar.zst' from mirror.ufro.cl : The requested URL returned error: 404
error: failed retrieving file 'rsync-3.2.3-1-x86_64.pkg.tar.zst' from mirrors.dotsrc.org : The requested URL returned error: 404
error: failed retrieving file 'libxxhash-0.8.0-1-x86_64.pkg.tar.zst' from mirrors.dotsrc.org : The requested URL returned error: 404
error: failed retrieving file 'libxxhash-0.8.0-1-x86_64.pkg.tar.zst' from mirrors.tuna.tsinghua.edu.cn : The requested URL returned error: 404
error: failed retrieving file 'rsync-3.2.3-1-x86_64.pkg.tar.zst' from mirrors.tuna.tsinghua.edu.cn : The requested URL returned error: 404
error: failed retrieving file 'libxxhash-0.8.0-1-x86_64.pkg.tar.zst' from mirrors.ustc.edu.cn : The requested URL returned error: 404
error: failed retrieving file 'rsync-3.2.3-1-x86_64.pkg.tar.zst' from mirrors.ustc.edu.cn : The requested URL returned error: 404
error: failed retrieving file 'libxxhash-0.8.0-1-x86_64.pkg.tar.zst' from sourceforge.net : Maximum file size exceeded
error: failed retrieving file 'rsync-3.2.3-1-x86_64.pkg.tar.zst' from sourceforge.net : The requested URL returned error: 404
error: failed retrieving file 'libxxhash-0.8.0-1-x86_64.pkg.tar.zst' from fastmirror.pp.ua : OpenSSL SSL_connect: SSL_ERROR_SYSCALL in connection to fastmirror.pp.ua:443
error: failed retrieving file 'rsync-3.2.3-1-x86_64.pkg.tar.zst' from fastmirror.pp.ua : OpenSSL SSL_connect: SSL_ERROR_SYSCALL in connection to fastmirror.pp.ua:443
error: failed retrieving file 'libxxhash-0.8.0-1-x86_64.pkg.tar.zst' from ftp.cc.uoc.gr : The requested URL returned error: 404
error: failed retrieving file 'rsync-3.2.3-1-x86_64.pkg.tar.zst' from ftp.cc.uoc.gr : The requested URL returned error: 404
error: failed retrieving file 'libxxhash-0.8.0-1-x86_64.pkg.tar.zst' from mirror.jmu.edu : The requested URL returned error: 404
error: failed retrieving file 'rsync-3.2.3-1-x86_64.pkg.tar.zst' from mirror.jmu.edu : The requested URL returned error: 404
error: failed retrieving file 'libxxhash-0.8.0-1-x86_64.pkg.tar.zst' from mirrors.piconets.webwerks.in : SSL certificate problem: certificate has expired
error: failed retrieving file 'rsync-3.2.3-1-x86_64.pkg.tar.zst' from mirrors.piconets.webwerks.in : SSL certificate problem: certificate has expired
error: failed retrieving file 'libxxhash-0.8.0-1-x86_64.pkg.tar.zst' from quantum-mirror.hu : OpenSSL SSL_connect: SSL_ERROR_SYSCALL in connection to quantum-mirror.hu:443
error: failed retrieving file 'rsync-3.2.3-1-x86_64.pkg.tar.zst' from quantum-mirror.hu : OpenSSL SSL_connect: SSL_ERROR_SYSCALL in connection to quantum-mirror.hu:443
error: failed retrieving file 'libxxhash-0.8.0-1-x86_64.pkg.tar.zst' from www2.futureware.at : The requested URL returned error: 404
error: failed retrieving file 'rsync-3.2.3-1-x86_64.pkg.tar.zst' from www2.futureware.at : The requested URL returned error: 404
error: failed retrieving file 'rsync-3.2.3-1-x86_64.pkg.tar.zst' from mirrors.sjtug.sjtu.edu.cn : The requested URL returned error: 404
error: failed retrieving file 'libxxhash-0.8.0-1-x86_64.pkg.tar.zst' from mirrors.sjtug.sjtu.edu.cn : The requested URL returned error: 404
error: failed retrieving file 'rsync-3.2.3-1-x86_64.pkg.tar.zst' from mirrors.bit.edu.cn : Operation timed out after 10001 milliseconds with 0 out of 0 bytes received
error: failed retrieving file 'libxxhash-0.8.0-1-x86_64.pkg.tar.zst' from mirrors.bit.edu.cn : Operation timed out after 10000 milliseconds with 0 out of 0 bytes received
error: failed retrieving file 'rsync-3.2.3-1-x86_64.pkg.tar.zst' from repo.casualgamer.ca : OpenSSL SSL_connect: SSL_ERROR_SYSCALL in connection to repo.casualgamer.ca:443
error: failed retrieving file 'libxxhash-0.8.0-1-x86_64.pkg.tar.zst' from repo.casualgamer.ca : OpenSSL SSL_connect: SSL_ERROR_SYSCALL in connection to repo.casualgamer.ca:443
warning: failed to retrieve some files
error: failed to commit transaction (download library error)
Errors occurred, no packages were upgraded.
```



##### **solution:**

让 pacman 下载最新的软件包列表，并确保安全密钥是最新的：

```bash
pacman -Sy msys2-keyring
```

- **`-Sy`**：这两个参数告诉 `pacman` **S**ynchronize（同步）软件包数据库，并重新**y**刷新（refresh）它们。这会更新你本地的可用软件包和版本列表。
- **`msys2-keyring`**：这是一个关键软件包，包含当前维护者的签名密钥。先更新它可以防止后续主升级过程中出现“无效或损坏的软件包（PGP签名）”错误。



运行完整的系统升级。这会计算并下载所有必要的更新，其中应该就包括了正确版本的 rsync 和 libxxhash。

```bash
pacman -Syu
```

- **`-Su`**：这会升级所有可以**u**pgrade（升级）的软件包。
- **`-Syu`**：这是标准的 MSYS2 更新命令，同时完成了刷新数据库和升级系统的工作。

在这个过程中，`pacman` 可能会提示你某些核心系统组件（如 MSYS2 运行时本身）已更新。如果它提示你关闭终端，请照做，然后打开一个新的 MSYS2 窗口，再次运行 `pacman -Su` 来完成剩余的升级。



**为什么会出现这个问题？（背景信息，可选读）**

这是像 MSYS2 这样的滚动更新的发行版常见的问题。你尝试安装的软件包版本（比如 rsync 的 `3.2.3-1`）是比较旧的。当你运行 `pacman -S rsync` 时，本地的包数据库仍然指向这些已被新版本取代并从镜像服务器上移除的旧文件。

#### bug2 'clangarm64' does not exist:

##### **description:**



When execute code:

```bash
pacman -S rsync
```



Exception output:

```bash
warning: database file for 'clangarm64' does not exist (use '-Sy' to download)
error: failed to prepare transaction (could not find database)
```

##### **solution:**

运行：

```bash
pacman -Sy rsync
```

来更新依赖后安装rsync。



#### bug3 两端版本不匹配[Receiver=3.1.2] [sender=3.4.1]:

##### **description:**



When execute code:

执行脚本的时候：`G:\Projects\projects_ai\data_sim_card_purchase\sync_to_cloud_server.bat`



Exception output:

```
rsync: connection unexpectedly closed (0 bytes received so far) [Receiver]
rsync error: error in rsync protocol data stream (code 12) at io.c(226) [Receiver=3.1.2]
rsync: connection unexpectedly closed (0 bytes received so far) [sender]
rsync error: error in rsync protocol data stream (code 12) at io.c(232) [sender=3.4.1]
```



##### **solution:**

本地：rsync  version 3.4.1  protocol version 32

远端：rsync  version 3.1.2  protocol version 31

就是版本差异大导致的同步失败。

在 CentOS 7 上升级 rsync 到最新版本

###### 1.安装编译依赖

```bash
# 安装编译工具和必要依赖
yum install -y gcc make autoconf wget

# 安装可选依赖（以启用全部功能）
yum install -y openssl-devel xxhash-devel lz4-devel zstd-devel
```

**注意**：CentOS 7 默认仓库可能没有 xxhash-devel、lz4-devel、zstd-devel，如果没有找到这些包，可以在后续编译时通过配置参数禁用相应功能。



###### 2.下载最新 rsync 源码

```bash
# 下载最新稳定版（当前最新为 3.4.1）
cd /usr/local/src
wget https://download.samba.org/pub/rsync/rsync-3.4.1.tar.gz
tar -xzf rsync-3.4.1.tar.gz
cd rsync-3.4.1
```



###### 3.配置、编译和安装

```bash
# 如果缺少某些依赖库，可以禁用相应功能
./configure --prefix=/usr/local --disable-xxhash --disable-zstd --disable-lz4

# 如果所有依赖都已安装，直接配置，事实证明还是得禁用，应执行上面的
./configure --prefix=/usr/local

# 编译（使用多核加速）
make -j$(nproc)

# 安装
make install
```



###### 4.验证安装并设置优先级

```bash
# 检查新版本
/usr/local/bin/rsync --version

# 备份原rsync并创建软链接
mv /usr/bin/rsync /usr/bin/rsync.bak
ln -s /usr/local/bin/rsync /usr/bin/rsync

# 再次验证
rsync --version
```



#### bug3.1 不管gcc编译报错:

##### **description:**

在编译3.4.1的rsync的时候

When execute code:

```bash
# 编译（使用多核加速）
make -j$(nproc)
```



Exception output:

```
popt/findme.c: 在函数‘findProgramPath’中:
popt/findme.c:30:5: 警告：隐式声明函数‘strlcpy’ [-Wimplicit-function-declaration]
     strlcpy(pathbuf, path, bufsize);
     ^
gcc -std=gnu11 -I. -I. -I./popt -I./zlib -g -O2 -DHAVE_CONFIG_H -Wall -W  -c popt/popt.c -o popt/popt.o
gcc -std=gnu11 -I. -I. -I./popt -I./zlib -g -O2 -DHAVE_CONFIG_H -Wall -W  -c popt/poptconfig.c -o popt/poptconfig.o
gcc -std=gnu11 -I. -I. -I./popt -I./zlib -g -O2 -DHAVE_CONFIG_H -Wall -W  -c popt/popthelp.c -o popt/popthelp.o
popt/poptconfig.c: 在函数‘poptReadDefaultConfig’中:
popt/poptconfig.c:440:17: 警告：未使用的变量‘sb’ [-Wunused-variable]
     struct stat sb;
                 ^
popt/popthelp.c: 在函数‘getArgDescrip’中:
popt/popthelp.c:157:16: 警告：未使用的参数‘translation_domain’ [-Wunused-parameter]
   const char * translation_domain)
                ^
popt/popthelp.c: 在函数‘singleOptionDefaultValue’中:
popt/popthelp.c:209:16: 警告：未使用的参数‘translation_domain’ [-Wunused-parameter]
   const char * translation_domain)
                ^
popt/popt.c: 在函数‘execCommand’中:
popt/popt.c:453:9: 警告：变量‘rc’被设定但未被使用 [-Wunused-but-set-variable]
     int rc;
         ^
popt/popt.c: 在函数‘poptRandomValue’中:
popt/popt.c:917:44: 警告：未使用的参数‘limit’ [-Wunused-parameter]
 static long long poptRandomValue(long long limit)
                                            ^
gcc -std=gnu11 -I. -I. -I./popt -I./zlib -g -O2 -DHAVE_CONFIG_H -Wall -W  -c popt/poptparse.c -o popt/poptparse.o
gcc -std=gnu11 -I. -I. -I./popt -I./zlib -g -O2 -DHAVE_CONFIG_H -Wall -W  -c popt/poptint.c -o popt/poptint.o
gcc -std=gnu11 -I. -I. -I./popt -I./zlib -g -O2 -DHAVE_CONFIG_H -Wall -W  -c flist.c -o flist.o
popt/poptint.c: 在函数‘POPT_fprintf’中:
popt/poptint.c:147:24: 警告：未使用的变量‘ob’ [-Wunused-variable]
     char * b = NULL, * ob = NULL;
                        ^
gcc -std=gnu11 -I./popt -I./zlib -g -O2 -DHAVE_CONFIG_H -Wall -W  -o rsync flist.o rsync.o generator.o receiver.o cleanup.o sender.o exclude.o util1.o util2.o main.o checksum.o match.o syscall.o log.o backup.o delete.o options.o io.o compat.o hlink.o token.o uidlist.o socket.o hashtable.o usage.o fileio.o batch.o clientname.o chmod.o acls.o xattrs.o progress.o pipe.o    params.o loadparm.o clientserver.o access.o connection.o authenticate.o lib/wildmatch.o lib/compat.o lib/snprintf.o lib/mdfour.o lib/md5.o lib/permstring.o lib/pool_alloc.o lib/sysacls.o lib/sysxattrs.o  zlib/deflate.o zlib/inffast.o zlib/inflate.o zlib/inftrees.o zlib/trees.o zlib/zutil.o zlib/adler32.o zlib/compress.o zlib/crc32.o popt/findme.o  popt/popt.o  popt/poptconfig.o popt/popthelp.o popt/poptparse.o popt/poptint.o -lcrypto 
```



##### **solution:**

1. **继续安装并使用（警告不影响使用）**

这些只是警告，不会阻止编译完成。继续执行：

```bash
make install
```



#### bug4 [Receiver=3.4.1] [sender=3.4.1]:

##### **description:**



When execute code:

执行脚本的时候：`G:\Projects\projects_ai\data_sim_card_purchase\sync_to_cloud_server.bat`

升级了远端之后还是报错。

Exception output:

```
G:\Projects\projects_ai\data_sim_card_purchase>rsync -avzP --exclude '.git' --exclude '.venv' --exclude '__pycache__' --exclude 'spider/scrape_results_20260313_015013' --include 'spider/scrape_results_20260313_040938/data_cards.json' --exclude 'spider/scrape_results_20260313_040938/*' ./ root@49.235.115.43:/opt/data_sim_card_purchase
rsync: connection unexpectedly closed (0 bytes received so far) [Receiver]
rsync error: error in rsync protocol data stream (code 12) at io.c(232) [Receiver=3.4.1]
rsync: connection unexpectedly closed (0 bytes received so far) [sender]
rsync error: error in rsync protocol data stream (code 12) at io.c(232) [sender=3.4.1]
```



##### **solution:**

