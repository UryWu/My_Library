### 简洁有效参考博客

下面都是ai生成的，直接参考教程：[Centos7上从源码编译安装Python 3.12](https://zhuanlan.zhihu.com/p/719744600)，减少出错可能。

### 下载并安装 OpenSSL 3.x

```bash
cd /usr/local/src
sudo wget https://www.openssl.org/source/openssl-3.1.2.tar.gz
sudo tar xzf openssl-3.1.2.tar.gz
cd openssl-3.1.2

# sudo ./config --prefix=/usr/local/openssl --  openssldir=/usr/local/openssl

```



安装到 `/usr/local/ssl` 覆盖系统自带 OpenSSL

```bash
sudo ./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib

sudo make -j$(nproc)
sudo make install
```

- sudo make -j$(nproc)是编译链接，nproc使用所有cpu核

- sudo make install是安装

#### 升级openssl

```bash
echo "/usr/local/ssl/lib64" > /etc/ld.so.conf.d/openssl.conf
```

- 将路径 /usr/local/ssl/lib64 写入一个新的配置文件

- 这告诉动态链接器/加载器在哪里可以找到OpenSSL共享库



```bash
ldconfig
```

- 更新共享库缓存

- 在配置的目录中创建/更新最新共享库的必要的符号链接



```bash
\cp -f /usr/local/ssl/bin/openssl /usr/bin/openssl
```

- 强制复制（`-f`）OpenSSL二进制文件从自定义安装目录到 `/usr/bin/`
- `cp` 前的反斜杠（`\`）绕过可能为 `cp` 定义的任何别名
- 这用自定义版本的OpenSSL替换系统的默认OpenSSL



```bash
ldconfig -v
```

- 再次更新共享库缓存，这次以详细模式（`-v`）显示正在处理的目录和创建的链接



```bash
cd
```

- 切换到用户的主目录
- 不带参数时，`cd` 命令默认回到当前用户的家目录

这版本够新，Python 3.12 能正常编译 `_ssl`



#### 测试安装成功

```bash
/usr/local/openssl/bin/openssl version
```

输出：

```bash
OpenSSL 3.1.2 1 Aug 2023 (Library: OpenSSL 3.1.2 1 Aug 2023)
```



确认 OpenSSL 3 安装成功

```
/usr/bin/openssl version
```

输出：

```bash
OpenSSL 3.1.2 1 Aug 2023 (Library: OpenSSL 3.1.2 1 Aug 2023)
```

### 从源码编译安装Python3.12.13

#### 安装编译python所需要的依赖

```bash
sudo yum groupinstall -y "Development Tools"

sudo yum install -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel libffi-devel
```

#### 下载、解压、配置、编译、安装、Python3.12.13

```bash
export LD_LIBRARY_PATH=/usr/local/ssl/li64
export LDFLAGS="-L/usr/local/ssl/lib64"
export CPPFLAGS="-I/usr/local/ssl/include"

```

这个启用gcc11的命令非常重要，如果无法执行，后面编译python3.12.13的时候会失败，因为centOS7里面的gcc是4.0，非常落后。

```bash
scl enable devtoolset-11 bash
```



#### 然后安装 GCC 11

因为 **CentOS 7 已经 EOL**，官方 `mirrorlist.centos.org` 很多仓库已经迁移到 **CentOS Vault**。

所以我们需要 **换 repo 源**。

------

##### 一步修复 yum 源

执行：

```bash
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*.repo

sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*.repo
```

然后刷新缓存：

```
yum clean all
yum makecache
```

如果成功，你会看到很多 repo 下载 metadata。



##### 安装 **devtoolset-11**：

```bash
yum install -y centos-release-scl-rh
yum install -y devtoolset-11
```

安装完成后：

```bash
ls /opt/rh
```

应该出现：

```bash
devtoolset-11
```

------

##### 启用 GCC 11

```bash
scl enable devtoolset-11 bash
```

检查：

```bash
gcc --version
```

应该显示：

```bash
gcc (GCC) 11.x
```



#### 编译python

```bash
cd

wget https://mirrors.huaweicloud.com/python/3.12.13/Python-3.12.13.tgz

tar xvf Python-3.12.13.tgz

cd Python-3.12.13

sudo ./configure --enable-optimizations --prefix=/usr/local/python3.12 --with-openssl=/usr/local/ssl --with-ensurepip=install --enable-shared

make clean

sudo make -j$(nproc)

sudo make altinstall    
# 使用 make altinstall 避免覆盖系统自带 Python 2.7

echo '/usr/local/python3.12/lib' > /etc/ld.so.conf.d/python-3.12.conf

ldconfig -v

cd
```

#### 使用Python3.12.13

命令***usr/local/python3.12/bin/python3.12\***

```bat
[root@localhost ~]# /usr/local/python3.12/bin/python3.12     
Python 3.12.13 (main, Sep 11 2024, 22:39:47) [GCC 11.2.1 20220127 (Red Hat 11.2.1-9)] on linux     
Type "help", "copyright", "credits" or "license" for more information.     
>>>print("hello python")     
hello python     
>>>
```



#### 添加 PATH

编辑：

```
vim /etc/profile
```

加入：

```
export PATH=/usr/local/python3.12/bin:$PATH
```

刷新：

```
source /etc/profile
```

测试：

```
python3.12 --version
```

------

#### 创建 python3 命令

CentOS7 默认没有 python3：

```
ln -s /usr/local/python3.12/bin/python3.12 /usr/bin/python3
```

报错文件已存在，然后我删掉了原来的python3.6.8符号链接：

```bash
[root@VM-0-2-centos bin]# ln -s /usr/local/python3.12/bin/python3.12 /usr/bin/python3
ln: 无法创建符号链接"/usr/bin/python3": 文件已存在

[root@VM-0-2-centos bin]# python3 -V
Python 3.6.8
[root@VM-0-2-centos bin]# rm python3
rm：是否删除符号链接 "python3"？y
[root@VM-0-2-centos bin]# ln -s /usr/local/python3.12/bin/python3.12 /usr/bin/python3
[root@VM-0-2-centos bin]# python3 -V
Python 3.12.13

```

以后直接：

```
python3
pip3
```



服务器原有的DNS

nameserver 183.60.83.19
nameserver 183.60.82.98