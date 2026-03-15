### 使用uv sync时出现编译器的错误

#### gcc4.8太落后，需要升级

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



#### 清理并设置 C++17

```bash
uv clean
export CXXFLAGS="-std=c++17 -O3"
uv sync
```

- **GCC 11** 是工具（编译器）的版本号。
- **C++11** 是规则（语言标准）的版本号。
- GCC 11 这个工具不仅懂 C++11 的规则，也懂 C++14、C++17、C++20 的规则。

### 使用from .routers import cards相对路径出错



linux上运行命令：

```bash
uv run python backend/main.py
```

报错：

```bash
[root@VM-0-2-centos data_sim_card_purchase]# uv run python backend/main.py 
Traceback (most recent call last):
  File "/opt/data_sim_card_purchase/backend/main.py", line 10, in <module>
    from .routers import cards
ImportError: attempted relative import with no known parent package

```

方法：

在父目录下使用 -m 参数将文件作为模块运行。

```bash
uv run python -m backend.main
```

