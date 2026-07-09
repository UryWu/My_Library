# Windows 退出崩溃排查：ctranslate2 TLS 析构异常

> 记录 audio2text 转写脚本在 Python 退出阶段崩溃的完整排查过程，包括工具搭建、dump 分析、根因定位、修复方案。
> 适用场景：基于 faster-whisper / ctranslate2 的 Python 程序，在 Windows 上退出时偶发或必现 `c0000409` 异常。

## 1. 现象

转写任务正常完成，SRT / TXT 都正确写出，但脚本最后一步（退出 Python）触发未处理异常：

```
0x00007FFA89AC286E (ucrtbase.dll) (python.exe 中)处有未经处理的异常: 请求了严重的程序退出。
```

- 转写成功率 100%，崩溃只在退出阶段
- 即使空目录（早退路径 `sys.exit(0)`）也会崩
- 日志中 `=== task end ===` 标记能记到，但下一次 `task start` 没出现，说明进程被 Windows 强杀

## 2. 第一轮尝试（失败）

最初猜测：全局 `model` 变量在 Python 退出时才被销毁，时机太晚。修复方案：

```python
del model
gc.collect()
```

放到 stdout 还原、日志关闭之后。**结果**：部分场景能干净退出，但下一次任务又崩。不稳定。

## 3. 工具准备

### 3.1 Windbg / cdb

Windows 调试工具。如果没装，去 Microsoft Store 装 "WinDBG" 或下载 [Debugging Tools for Windows](https://learn.microsoft.com/en-us/windows-hardware/drivers/debugger/)。

记下 `cdb.exe` 路径，本机是：

```
E:\Windows Kits\10\Debuggers\x64\cdb.exe
```

### 3.2 mcp-windbg（可选）

[svnscha/mcp-windbg](https://github.com/svnscha/mcp-windbg) 把 cdb 封装成 MCP server，可在 Claude Code 里直接调 cdb 命令。本次没用到（直接调 cdb.exe），但装好留给以后用。

#### 3.2.1 安装的包

```bash
uv pip install mcp-windbg
```

| 项 | 值 |
|---|---|
| 包名 / 版本 | `mcp-windbg==0.15.0` |
| 安装位置 | `G:\Projects\projects_ai\audio2text\.venv\Lib\site-packages\mcp_windbg\` |
| 文件清单 | `__init__.py` / `__main__.py`（入口）/ `cdb_session.py`（cdb 进程管理）/ `filter_script.py`（输出过滤）/ `server.py`（MCP 主体）/ `prompts/` / `tests/` |
| 传递依赖 | `mcp`、`pydantic`、`starlette`、`uvicorn`（自动装上） |

> ⚠️ **`uv pip install` ≠ 注册 MCP server**。`uv pip install mcp-windbg` 只是把 Python 包装进 `.venv`，**不会**动 `~/.claude.json`，更不会让 Claude Code 出现 `mcp__mcp-windbg__*` 工具。要让 Claude 能调它，必须再做 3.2.2 那步。

#### 3.2.2 注册为 Claude Code MCP server

注册是**独立动作**：把 server 的启动方式写到 Claude Code 自己的配置里。最干净的方式是 `claude mcp add`：

```bash
claude mcp add mcp-windbg -s user \
  -e _NT_SYMBOL_PATH="SRV*C:\\Symbols*https://msdl.microsoft.com/download/symbols" \
  -- python -m mcp_windbg \
  --cdb-path "E:\\Windows Kits\\10\\Debuggers\\x64\\cdb.exe"
```

> 也可以手动编辑 `~/.claude.json`，往 `mcpServers` 里加一段（效果等价，详见 3.2.3）。本次用的是手动写法。

参数含义：

| 参数 | 作用 |
|---|---|
| `mcp-windbg` | MCP server 名，Claude 里会看到 `mcp__mcp-windbg__*` 工具 |
| `-s user` | 用户级（所有项目共享）。对应 `-s project` / `-s local` |
| `-e KEY=VALUE` | 给 server 进程设环境变量。这里设 `_NT_SYMBOL_PATH` 让 cdb 从微软符号服务器下载符号 |
| `--` | 分隔符，后面是实际启动 server 的命令 |
| `python -m mcp_windbg` | 跑包入口（`__main__.py`） |
| `--cdb-path "..."` | 告诉 mcp_windbg cdb 在哪 |

#### 3.2.3 配置文件位置

命令把配置写到了 `C:\Users\UryWu\.claude.json` 的顶层 `mcpServers` 对象：

```json
{
  "mcpServers": {
    "mcp-windbg": {
      "type": "stdio",
      "command": "python",
      "args": ["-m", "mcp_windbg", "--cdb-path", "E:\\Windows Kits\\10\\Debuggers\\x64\\cdb.exe"],
      "env": {
        "_NT_SYMBOL_PATH": "SRV*C:\\Symbols*https://msdl.microsoft.com/download/symbols"
      }
    }
  }
}
```

> Claude Code 项目级 MCP 配置在 `<项目>/.mcp.json`，用户级在 `~/.claude.json` 的 `mcpServers` 字段。本次用 `-s user` 是用户级。

#### 3.2.4 验证

```bash
$ claude mcp list
mcp-windbg: python -m mcp_windbg --cdb-path ... - ✔ Connected
```

`✔ Connected` 说明 Claude Code 已能成功 spawn 这个 server 进程、通过 health check。

#### 3.2.5 已知隐患

配置里 `command: "python"` 是**裸命令**，依赖 PATH。当前 PATH 中有 3 个 Python：

```
G:\Projects\projects_ai\audio2text\.venv\Scripts\python.exe   ← 当前 shell 优先用这个（已装 mcp_windbg）
C:\Users\UryWu\.local\bin\python.exe                           ← Claude Code 自带
E:\Anaconda3-2019.10-Windows-x86_64\python.exe                 ← Anaconda（没装 mcp_windbg）
```

如果 Claude Code spawn MCP 进程时 PATH 跟当前 shell 不一样，可能找到没装 mcp_windbg 的 Python。**当前能用**（因为 `mcp list` 显示 Connected），**要稳建议改成绝对路径**：

```json
"command": "G:\\Projects\\projects_ai\\audio2text\\.venv\\Scripts\\python.exe"
```

### 3.3 WER 自动生成 dump

Windows Error Reporting 默认会在 `%LOCALAPPDATA%\CrashDumps\` 写 dump：

```
C:\Users\<user>\AppData\Local\CrashDumps\python.exe.<pid>.dmp
C:\Users\<user>\AppData\Local\CrashDumps\python.exe(1).<pid>.dmp
```

（第 2 个是 full dump，第 1 个是 minidump。出现 `(1)` 后缀通常意味着同进程生成了两份。）

如果目录是空的，手动开启 WER local dumps（针对 python.exe）：

```reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps\python.exe" /v DumpType /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps\python.exe" /v DumpFolder /t REG_SZ /d "C:\Users\UryWu\AppData\Local\CrashDumps" /f
```

`DumpType=2` = full dump，`1` = minidump。

### 3.4 直接用 cdb.exe vs 用 mcp-windbg

两种方式**底层是同一个东西**（mcp-windbg 就是 cdb 的 MCP 封装），能力上限一样，区别在用法。

#### 直接用 cdb.exe

| 维度 | 评价 |
|---|---|
| 命令完整度 | ✅ 所有 cdb 命令都能跑（`!analyze` / `~*k` / `.sympath` / `dt` / `dps` 等） |
| 灵活性 | ✅ 可以 `> /tmp/stacks.txt` 重定向、`\| head` 切片、grep 过滤 |
| 批处理 | ✅ `cdb -c "cmd1; cmd2; q"` 一次跑多条 |
| 环境依赖 | ✅ 无 MCP server、无 Python 包、纯 exe |
| 缺点 | ❌ 命令长（要写全 `cdb.exe -z <dump> -c "..."`），容易打错 |

**适合场景**：
- 需要重定向 / 管道 / diff 多份 dump 输出
- 写脚本批量分析
- MCP 工具未注入（当前会话就是这种情况）
- 跑长命令如 `!analyze -v`（输出几百行）

#### 用 mcp-windbg

| 维度 | 评价 |
|---|---|
| 命令完整度 | ✅ 通过 `mcp__mcp-windbg__run_windbg_cmd` 跑任意 cdb 命令，跟直接调等价 |
| 灵活性 | ✅ 持久会话（`open_windbg_dump` 之后 `run_windbg_cmd` 共享上下文，不用每次 `-z`） |
| 自动化 | ✅ Claude 自己决定调什么工具，不用手写 bash |
| 缺点 | ❌ 输出走 MCP 协议，可能被截断 / 过滤 |
| 缺点 | ❌ 会话级注入（启动后才有） |
| 缺点 | ❌ Server 进程是潜在故障点（PATH 错、Python 找不到等） |

**适合场景**：
- 临时分析单个 dump
- 想让 Claude 自己跑、自己解读
- 不用自己写 bash

#### 选哪个

| 任务 | 推荐 |
|---|---|
| 临时看一个 dump，几十行输出 | MCP（省事） |
| 几百行输出要分析 / diff 多份 | 直接 cdb（重定向 + grep） |
| 写分析脚本 / 自动化 | 直接 cdb（脚本可控） |
| 想让 Claude 自动分析 | MCP（Claude 自己调） |
| MCP server 没配 / 配挂了 | 直接 cdb（保底） |

**结论**：能力一样，效率场景不同。**默认走 MCP（新会话里直接有工具）**；**重活**（批量 / 大输出 / diff）**走 cdb.exe + bash 重定向**；**保底永远会 cdb.exe**（无依赖）。

本次 debug 全程用 cdb.exe，原因：
1. 本会话 MCP 工具未注入（`mcp-windbg` server 配好了，但 Claude 工具栏里没出现 windbg 工具，要新开会话才有）
2. 需要对比多份 dump：`!analyze -v` 输出几百行，直接 `> /tmp/stacks.txt` 然后 Read / grep 比走 MCP 干净
3. 需要链式命令：`~20s; .ecxr; k; q` 一次跑完

## 4. Dump 分析

### 4.1 选哪个 .dmp 文件

WER 同时生成两份：

```
python.exe.30516.dmp              ← minidump（~25 MB）
python.exe(1).30516.dmp           ← full dump（~94 MB）
```

- **minidump**：只保留崩溃线程的栈 + 部分内存。够看栈轨迹，但看不全所有线程。
- **full dump**：整个进程内存 + 所有线程栈 + 所有模块。

**多线程崩溃必须用 full dump**。本次崩溃涉及主线程（Thread 0，等 join）和工作线程（Thread 20，跑 TLS 析构），需要同时看两个线程的栈，所以选 `python.exe(1).30516.dmp`。

判断方法：如果 dump 文件大小跟进程峰值内存接近，就是 full dump；如果只有几 MB，是 minidump。

### 4.2 第一次分析：`!analyze -v`

```bash
cd "E:\Windows Kits\10\Debuggers\x64"
./cdb.exe -z "C:\Users\UryWu\AppData\Local\CrashDumps\python.exe(1).30516.dmp" -c "!analyze -v; q"
```

`-c` 后面是命令字符串，分号隔开，`q` 退出 cdb。

输出关键字段：

```
FAILURE_EXCEPTION_CODE:  c0000409    ← STATUS_STACK_BUFFER_OVERRUN（Windows 借此表达 fastfail）
SYMBOL_NAME:             ucrtbase!abort+4e
FAULT_INSTR_CODE:        15ba29cd    ← int 29h = __fastfail 指令编码
BUCKET_ID:               FAIL_FAST_FATAL_APP_EXIT_ucrtbase!abort+4e
FAILURE_FUNCTION_NAME:   abort
```

`int 29h` 是 `__fastfail()` 的指令编码。CRT 在 abort() 路径上调它，异常码 `c0000409` 是 Windows 统一的 fastfail 异常码。

**`!analyze -v` 给出的是栈顶（异常发生处）**，不够。要看完整调用链，下一步。

### 4.3 第二次：所有线程的栈 `~*k`

```bash
./cdb.exe -z "...dmp" -c "~*k; q" > /tmp/stacks.txt
```

- `~*`  = 所有线程
- `k`   = 当前线程的栈
- 整句 = 遍历所有线程，每个打一次栈

输出格式：每个线程开头是 `# <id>  Id: <pid>.<tid>  Suspend: <n>  Teb: <addr>  <state>`，下面是栈帧。

**怎么找到崩溃线程**：

```
# 20  Id: 7734.7130 Suspend: 0 Teb: 000000f6`45d1f000 Unfrozen
```

- 栈顶是 `ucrtbase!abort` / `ucrtbase!terminate` / `_CxxThrowException` → **这个线程就是崩溃线程**
- `Suspend: 0` = 没被挂起（其他线程 `Suspend: 1` 表示调试器加载时挂起的）
- `Unfrozen` = 不是被冻结的线程

本次有 21 个线程，崩溃的是 **Thread 20**。

主线程 Thread 0 栈（卡住的地方）：

```
# 0  Id: 7734.20ac Suspend: 1 Teb: 000000f6`45ced000 Unfrozen
ntdll!NtWaitForSingleObject+0x14
KERNELBASE!WaitForSingleObjectEx+0x8e
msvcp140!_Thrd_join+0x1f                                  ← 等线程 join
ctranslate2!ctranslate2::ThreadPool::~ThreadPool+0xb0    ← ctranslate2 线程池析构
_ext.cp310-win_amd64+...                                 ← Python 扩展入口
python310!PyDict_Pop+0x576
python310!PyType_GenericNew+0x6a0
... Python 帧 ...
python!OPENSSL_Applink+0x380                             ← 脚本入口
```

崩溃线程 Thread 20 栈（异常源头）：

```
# 20  Id: 7734.7130 Suspend: 0 Teb: 000000f6`45d1f000 Unfrozen
ucrtbase!abort+0x4e                                   ← 顶层（异常发生处）
ucrtbase!terminate+0x1f
VCRUNTIME140!__std_terminate+0xa
VCRUNTIME140!_CallSettingFrame+0x20
VCRUNTIME140!__FrameHandler3::FrameUnwindToState+0x112
VCRUNTIME140!__FrameHandler3::FrameUnwindToEmptyState+0x54
VCRUNTIME140!__InternalCxxFrameHandler<__FrameHandler3>+0x10c
VCRUNTIME140!__CxxFrameHandler3+0x71
ntdll!RtlpExecuteHandlerForUnwind+0xf
ntdll!RtlUnwindEx+0x339
ntdll!_C_specific_handler+0xd9
ntdll!RtlpExecuteHandlerForException+0xf
ntdll!RtlDispatchException+0x244
ntdll!RtlRaiseException+0x1d7
KERNELBASE!RaiseException+0x69
VCRUNTIME140!_CxxThrowException+0x90
ctranslate2!ctranslate2::cuda::CudaAsyncAllocator::free+0x1cd   ← ★ 抛异常的源头
ctranslate2!thrust::generic_error_category 的动态 atexit 析构
ctranslate2!ctranslate2::ops::quantize_kernel<__nv_bfloat16>+0xe1110b
ntdll!LdrpCallInitRoutine+0x61
ntdll!LdrpCallTlsInitializers+0x87                      ← ★ TLS 析构阶段
ntdll!LdrShutdownThread+0x153
ntdll!RtlExitUserThread+0x3e
KERNELBASE!FreeLibraryAndExitThread+0x4a
ucrtbase!common_end_thread+0xac
ucrtbase!thread_start+0x49                              ← 线程入口
```

### 4.4 怎么「定位错误在哪」

c / c++ 栈的阅读规则：**栈顶 = 当前正在执行的指令，越往下 = 调用方**。

定位步骤：

1. **找到崩溃线程**：找栈顶是 `ucrtbase!abort` / `terminate` / `RaiseException` 的那个
2. **看 `__CxxThrowException` 上面的非 Windows 帧**：那是真正 `throw` 的位置
3. **找到抛 C++ 异常的位置**：本次是 `ctranslate2!ctranslate2::cuda::CudaAsyncAllocator::free+0x1cd`
4. **看栈底（最早调用方）**：确认触发链是 DLL 卸载 / 线程退出 / 用户代码

**关键帧识别**：

| 看到 | 含义 |
|---|---|
| `ucrtbase!abort` / `ucrtbase!terminate` | CRT 终止路径（不是 segfault） |
| `int 29h` / `__fastfail` | Windows fastfail（CRT 的 abort 会走到这里） |
| `_CxxThrowException` | C++ 异常抛出点（看它上面第一个非 Windows 帧） |
| `RtlUnwindEx` | 栈展开（C++ 异常传播 / SEH） |
| `LdrpCallTlsInitializers` | 线程退出阶段的 TLS / C++ 静态析构 |
| `LdrShutdownThread` | 线程退出，Windows 开始拆 DLL |
| `RaiseException` | 主动抛 SEH 异常（C++ 异常底层走这个） |
| `*!Py*`（python310） | Python 解释器自己的代码 |
| `*!_ext.cp310-win_amd64` | Python C 扩展入口（本项目的 ctranslate2 绑定） |

**本次定位结论**：

- 抛 C++ 异常的函数：`ctranslate2::cuda::CudaAsyncAllocator::free`（`+0x1cd` 是偏移）
- 触发场景：worker 线程退出 → TLS 析构 → thrust 库的静态对象析构 → CudaAsyncAllocator 释放
- 异常原因：CUDA 上下文已被半销毁，`free` 操作失败抛异常

### 4.5 进一步命令（用到再补）

```bash
# 看崩溃线程的寄存器 + 异常上下文
./cdb.exe -z "...dmp" -c "~20s; .ecxr; r; q"

# 看特定线程的栈
./cdb.exe -z "...dmp" -c "~20s; k; q"

# 看模块列表
./cdb.exe -z "...dmp" -c "lm; q"

# 加载符号
.sympath+ srv*c:\symbols*https://msdl.microsoft.com/download/symbols
.reload /f ctranslate2.dll
```

## 5. 根因（dump 证实的部分）

Thread 20 的栈自底向上，直接从符号读到的信息：

1. **`thread_start` / `common_end_thread`**：ucrt 线程入口 / 出口
2. **`FreeLibraryAndExitThread` → `RtlExitUserThread`**：线程退出路径
3. **`LdrShutdownThread` → `LdrpCallTlsInitializers` → `LdrpCallInitRoutine`**：Windows 跑 TLS / C++ 静态析构
4. **ctranslate2 内部某静态对象的析构**（符号名 `ctranslate2::ops::quantize_kernel<__nv_bfloat16>+0xe1110b`，是误命名，实际是动态 atexit 对象的析构）
5. **thrust `generic_error_category` 的析构**
6. **`ctranslate2::cuda::CudaAsyncAllocator::free`**：释放 CUDA 异步分配器，**在这里抛 C++ 异常**
7. **`_CxxThrowException` → `RtlRaiseException` → `RtlUnwindEx`**：异常向上传播，Windows 展开栈
8. **`__CxxFrameHandler3` → `__std_terminate`**：异常在 DLL 边界逃出 C++ 代码，进入 CRT 终止路径
9. **`ucrtbase!terminate` → `abort` → `int 29h`**：CRT 终止 → abort → fastfail

**Thread 0 同时显示**：卡在 `ctranslate2::ThreadPool::~ThreadPool` 等线程 join。这两个线程的状态同时存在说明：

- 主线程触发了 ThreadPool 销毁
- worker 线程开始退出 → TLS 析构阶段崩了
- 主线程永远 join 不到

**结论**：ctranslate2 在 Windows 上的线程退出路径里，`CudaAsyncAllocator::free` 这段代码会抛异常，导致整个清理流程崩掉。这是 ctranslate2 库自身的问题，绕开办法就是**不触发这段清理**。

## 6. 为什么 `del model + gc.collect` 不够

```python
del model      # 触发 WhisperModel.__del__
gc.collect()
```

这会让 CTranslate2 模型提前析构、释放引用、关闭 ThreadPool。但 `ThreadPool::~ThreadPool` 还是要 join 所有 worker 线程，**worker 线程的退出路径仍然会经过 TLS 析构**。把销毁动作提前没用，根本问题是 ctranslate2 自己的线程退出路径里有 bug。

## 7. 修复方案：跳过所有清理

既然 ctranslate2 在 Windows 上的线程清理有 bug，最稳的办法是不让它跑那段清理：

```python
sys.stdout = _original_stdout
_log_file.flush()    # 必须手动 flush，os._exit 不跑 atexit
_log_file.close()    # Python 的 close() 也会 flush，flush + close 是双保险
_original_stdout.flush()
# 不要 del model —— 见 §7.1
os._exit(0)          # 调 ExitProcess，跳过 Python / C 运行时 / 线程 TLS 全部清理
```

`os._exit(0)` 调的是 Windows 的 `ExitProcess`，**完全**绕过：

- Python 解释器关闭（atexit、gc、模块销毁）
- C 运行时清理（`__attribute__((destructor))`、CRT atexit）
- 线程 TLS 析构（这正是崩溃源头）
- `_log_file.__del__`（必须前面手动 flush + close）

**代价**：

- 不会跑 Python `atexit` 注册的函数（本项目没用）
- 不会跑 C 运行时注册的 atexit（同上）
- 日志、stdout 必须 **手动** flush + close，否则丢最后几行

对于这种批处理脚本完全够用。GUI / 服务类程序慎用，会跳过错误处理清理。

### 7.1 第一版修复的盲点：`del model` 反而是触发器

第一次 commit `70883f7` 写的代码：

```python
_log_file.flush()
_log_file.close()
_original_stdout.flush()
del model          # ← 这里的引用计数归零触发 __del__
os._exit(0)        # ← 永远到不了这里
```

dump `python.exe(1).32724.dmp`（08:21）显示栈跟之前**一模一样**：崩溃线程 Thread 20 在 `ctranslate2::cuda::CudaAsyncAllocator::free+0x1cd` 抛异常。

把两个 dump 放一起对比：

| dump | 时间 | Thread 0 栈顶 | Thread 20 栈顶 |
|---|---|---|---|
| `python.exe(1).30516.dmp` | 06:59 | `ThreadPool::~ThreadPool` 等 join | TLS 析构 → `CudaAsyncAllocator::free` |
| `python.exe(1).32724.dmp` | 08:21 | `ThreadPool::~ThreadPool` 等 join | TLS 析构 → `CudaAsyncAllocator::free` |

Thread 0 都在 `ThreadPool::~ThreadPool` 等 join —— 说明**主线程触发了 ThreadPool 销毁**。两种可能触发路径：

- 老 fix：`del model + gc.collect()` 触发 `WhisperModel.__del__` → CTranslate2 模型销毁 → ThreadPool 销毁
- 新 fix：`del model` 触发 `WhisperModel.__del__` → CTranslate2 模型销毁 → ThreadPool 销毁

**两次都是 `del model` 触发的**。`os._exit(0)` 写在它后面，永远跑不到。

**正确写法**：

```python
sys.stdout = _original_stdout
_log_file.flush()
_log_file.close()
_original_stdout.flush()
# 不 del model —— 让 model 跟进程一起被 OS 收回
os._exit(0)
```

`os._exit(0)` 调 Windows 的 `ExitProcess`，粗暴杀进程：

- 不调 Python 解释器关闭（跳过所有 `__del__`）
- 不调 C 运行时 atexit
- 不调 DLL 卸载
- 不跑线程 TLS 析构

model 引用的 CTranslate2 句柄、CUDA context、ThreadPool 跟进程地址空间一起被 OS 回收，**没有任何代码路径会跑到 `CudaAsyncAllocator::free`**，自然不抛异常。

## 8. 替代方案（更"正确"但改动大）

1. **升级 ctranslate2 到 4.x**：需要 CUDA 12 + cuDNN 9，本机 CUDA 11 + cuDNN 8 升不动
2. **改用 onnxruntime 走 ONNX 路径**：faster-whisper 也支持，但要先导出 ONNX 模型
3. **fork ctranslate2 修 CudaAsyncAllocator::free 的异常路径**：成本太高
4. **在 ctranslate2 之前注入 hook 让 worker 线程先 join 再 exit**：DLL 注入级别的 hack
5. **用 `TerminateProcess` 替代 `os._exit`**：比 `os._exit` 更粗暴，连 `ExitProcess` 的 DLL_PROCESS_DETACH 都不跑。但 ctypes 调用麻烦，且 `os._exit` 已经够用。

`os._exit(0)` 不释放 model 是成本最低、风险可控的方案。

## 9. 经验总结

### 9.1 快速诊断流程（5 分钟版）

按顺序执行：

```
1. 确认 WER 有 dump
   ls "$LOCALAPPDATA/CrashDumps/python.exe*.dmp"
   → 选 full dump（带 (1) 后缀或体积大的）

2. 看异常码和初步分析
   cdb.exe -z <dump> -c "!analyze -v; q"
   → 记下：异常码、BUCKET_ID、SYMBOL_NAME

3. 列所有线程栈
   cdb.exe -z <dump> -c "~*k; q" > stacks.txt
   → 找栈顶是 abort/terminate/RaiseException 的线程 = 崩溃线程

4. 找抛异常的源头
   在崩溃线程栈里找 _CxxThrowException
   → 它上面第一个非 Windows 帧就是 throw 的位置

5. 看触发链
   栈底往上读：thread_start → 退出路径 → DLL 卸载 → 静态析构 → 抛异常
   → 确认是用户代码触发的，还是库自身的 bug

6. 决定修复方案
   - 用户代码 bug → 改 Python
   - 库自身的退出/析构 bug → 绕开（os._exit / 换库 / 升级）
```

### 9.2 关键栈帧速查表

| 看到 | 含义 | 接下来看 |
|---|---|---|
| `ucrtbase!abort` + `int 29h` | CRT 调 abort → fastfail（**主动 fatal exit，不是段错误**） | 上面的 `terminate` / `__CxxThrowException` |
| 异常码 `c0000409` | Windows 通用 fastfail 异常码 | 不是段错误，是 abort / unhandled exception |
| `_CxxThrowException` | C++ 异常抛出点 | **它上面第一个非 Windows 帧 = 真正 throw 的代码** |
| `terminate` | C++ 异常逃出所有 catch | 上面的 `RtlUnwindEx` / `__CxxFrameHandler` |
| `RtlUnwindEx` | 栈展开（C++ 异常传播） | 跨 DLL 边界展开 = 异常逃出库了 |
| `LdrpCallTlsInitializers` | **线程退出阶段**，TLS / C++ 静态析构 | 它上面 = 哪个 DLL 的析构函数 |
| `LdrShutdownThread` | 线程退出，Windows 开始拆 DLL | 确认是线程退出场景 |
| `RaiseException` | 主动抛 SEH 异常 | C++ 异常底层走这个 |
| `*!Py*`（python310） | Python 解释器自己的代码 | 不一定是 Python 层的 bug |
| `*!_ext.cp310-win_amd64` | Python C 扩展入口 | 找具体模块名（torch / onnx / ctranslate2） |
| 栈顶是 `python!OPENSSL_Applink` | Python 主入口 | 没问题，是脚本入口 |

### 9.3 调试工具清单

| 工具 | 用途 | 安装 |
|---|---|---|
| **cdb.exe** | 命令行调试器（必装） | WinDBG / Debugging Tools for Windows |
| **windbg.exe** | GUI 调试器（可选） | 同上 |
| **WER LocalDumps** | 自动在崩溃时写 dump | 注册表配置（见 3.3 节） |
| **mcp-windbg** | 把 cdb 接入 Claude Code | 1) `uv pip install mcp-windbg`（装包）<br>2) `claude mcp add mcp-windbg ...`（注册到 `~/.claude.json`）<br>两步缺一不可 |
| **VS + Python native debug** | 调试 Python C 扩展源码 | 复杂，多数情况用不到 |

### 9.4 cdb 常用命令速查

```
!analyze -v          # 自动分析 + 给修复建议（每次第一手用）
~*k                  # 列所有线程 + 栈（多线程崩溃必备）
~Ns                  # 切到线程 N（配合 k 看具体线程）
.ecxr                # 把 last exception 上下文设成当前（看崩溃时刻寄存器 / 局部变量）
r                    # 当前线程的寄存器
k                    # 当前线程的栈（默认 20 帧，kL 看完整）
kb / kp / kv         # 三参数 / 全参数 / 局部变量（细节调试用）
!peb                 # 进程环境块（看环境变量、命令行）
!teb                 # 线程环境块
lm                   # 列加载的模块（看 dll 版本）
.sympath             # 看符号路径
.sympath+ "..."      # 加符号路径
.reload /f xxx.dll   # 强制重载符号
```

### 9.5 调试类似问题的检查清单

- [ ] WER dump 路径有 .dmp 吗？没有就开 LocalDumps
- [ ] 选 **full dump**（带 `(1)` 后缀 / 体积大的）
- [ ] `!analyze -v` 看 BUCKET_ID、SYMBOL_NAME、异常码
- [ ] `~*k` 列所有线程栈，找**真正崩溃**的线程（不是主线程）
- [ ] 看崩溃线程栈底是 `thread_start` 还是 `_threadstartex` → 是不是线程退出阶段
- [ ] 如果是线程退出阶段，看 `LdrpCallTlsInitializers` 上面的 DLL → 哪个库的静态析构
- [ ] 找 `_CxxThrowException` 上面的非 Windows 帧 → 真正 throw 的函数
- [ ] 库名指向哪个 C 扩展 → 找对应版本（ctranslate2 / onnxruntime / torch）
- [ ] 评估升级 / 绕过 / 修源码 三种方案的成本
- [ ] 修复时记得考虑所有早退路径（`sys.exit(0)` 也会触发同样问题）
- [ ] **任何"清理代码"都不能放在 `os._exit(0)` 之前** —— `del` / `gc.collect` / close 等都可能在 refcount 归零瞬间触发 `__del__`，跟 `os._exit` 抢同一个退出窗口。如果要绕开库 bug，必须**完全不调清理**，让 OS 收回进程资源。

### 9.6 `os._exit` 的关键规则

| 规则 | 说明 |
|---|---|
| `os._exit` 是**最后**一条语句 | 它后面不能再有代码（包括 print、close、del） |
| 它**之前**也只能有 IO flush | `flush() + close()` 是合法的，但任何触发 `__del__` / `atexit` 的调用都不行 |
| `del x` 不一定安全 | 如果 `x` 是 C 扩展对象，`del` 触发的 `__del__` 可能调 native 清理 → 同款崩溃 |
| 不要 `gc.collect()` | 跟 `del` 一样，可能触发 `__del__` |
| log 文件必须**显式** `flush() + close()` | Python 解释器关闭时会自动 flush，但我们跳过了解释器关闭 → 不 flush 就丢日志 |

**判定标准**：在 `os._exit(0)` 之前所有代码都得是纯 Python + 纯 IO（flush / close），**不能**有任何引用计数归零的 C 扩展对象。

## 10. 相关链接

- [svnscha/mcp-windbg](https://github.com/svnscha/mcp-windbg) — MCP server 封装
- [Debugging Tools for Windows](https://learn.microsoft.com/en-us/windows-hardware/drivers/debugger/debugger-download-tools)
- [Windows Error Reporting LocalDumps](https://learn.microsoft.com/en-us/windows/win32/wer/collecting-user-mode-dumps)
- [ctranslate2 GitHub](https://github.com/OpenNMT/CTranslate2) — 受影响的 C++ 库
- [faster-whisper GitHub](https://github.com/SYSTRAN/faster-whisper) — Python 封装