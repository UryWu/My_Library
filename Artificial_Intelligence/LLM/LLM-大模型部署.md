## 部署

### [5分钟教会你如何本地部署DeepSeek-R1，无需联网，全程干货，没有一句废话。](https://www.bilibili.com/video/BV1tjFVezEK5/)

下载ollma

下载deepseek-r1 1.5B

下载openwebUI



### 最好SGLang高并发高速、或者vllm

### [大模型部署工具对比：SGLang, Ollama, VLLM, LLaMA.cpp](https://stable-learn.com/zh/ai-model-tools-comparison/)



多维度对比一览表

将这几款工具放在一起 “掰手腕”，从性能、易用性、适用场景等多个维度来一场全方位的较量，帮你找到最称手的那个 “兵器”。

| 工具名称    | 性能表现                                                     | 易用性                                                       | 适用场景                                                     | 硬件需求                                  | 模型支持                                     | 部署方式                          | 系统支持              |
| ----------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ----------------------------------------- | -------------------------------------------- | --------------------------------- | --------------------- |
| SGLang v0.4 | 零开销批处理提升1.1倍吞吐量，缓存感知负载均衡提升1.9倍，结构化输出提速10倍 | 需一定技术基础，但提供完整API和示例                          | 企业级推理服务、高并发场景、需要结构化输出的应用             | 推荐A100/H100，支持多GPU部署              | 全面支持主流大模型，特别优化DeepSeek等模型   | Docker、Python包                  | Linux                 |
| Ollama      | 继承 llama.cpp 的高效推理能力，提供便捷的模型管理和运行机制  | 小白友好，提供图形界面安装程序一键运行和命令行，支持 REST API | 个人开发者创意验证、学生辅助学习、日常问答、创意写作等个人轻量级应用场景 | 与 llama.cpp 相同，但提供更简便的资源管理 | 模型库丰富，涵盖 1700 多款，支持一键下载安装 | 独立应用程序、Docker、REST API    | Windows、macOS、Linux |
| VLLM        | 借助 PagedAttention 和 Continuous Batching 技术，多 GPU 环境下性能优异 | 需要一定技术基础，配置相对复杂                               | 大规模在线推理服务、高并发场景                               | 要求 NVIDIA GPU，推荐 A100/H100           | 支持主流 Hugging Face 模型                   | Python包、OpenAI兼容API、Docker   | 仅支持 Linux          |
| LLaMA.cpp   | 多级量化支持，跨平台优化，高效推理                           | 命令行界面直观，提供多语言绑定                               | 边缘设备部署、移动端应用、本地服务                           | CPU/GPU 均可，针对各类硬件优化            | GGUF格式模型，广泛兼容性                     | 命令行工具、API服务器、多语言绑定 | 全平台支持            |

#### 推荐ollama

综合来看，如果您是专业的科研团队，拥有强大的计算资源，追求极致的推理速度，那么 SGLang 无疑是首选，它能像一台超级引擎，助力前沿科研探索；要是您是普通的个人开发者、学生，或是刚踏入 AI 领域的新手，渴望在本地轻松玩转大模型，Ollama 就如同贴心伙伴，随时响应您的创意需求；对于需要搭建大规模在线服务，面对海量用户请求的开发者而言，VLLM 则是坚实后盾，以高效推理确保服务的流畅稳定；而要是您手头硬件有限，只是想在小型设备上浅尝大模型的魅力，或者快速验证一些简单想法，LLaMA.cpp 就是那把开启便捷之门的钥匙，让 AI 触手可及。

总之，在这个 AI 蓬勃发展的时代，根据自身需求精准选择工具，才能在创新之路上一路飞驰，充分挖掘大模型的无限潜力，为生活、工作和学习带来前所未有的便利与突破。



### [为什么都在用ollama而lm studio却更少人使用?](https://www.zhihu.com/question/654357364)

#### [推荐ollama](https://www.zhihu.com/question/654357364/answer/3529724637)



我的体会：

1. ollama用起来和docker一样的感觉，pull模型，run模型，ls看模型，ps看运行。非常顺手丝滑，入手无门槛。

2. 另外，ollama支持很多主流LLM，什么Llama2/3，谷歌的gemma，mistral，国内的qwen，deepseek，llama的中文，微调各种chat，code，够用。而且都是量化好的，随拉随用，4090就跑的起来。尤其是在国内拉模型速度极快，我的环境最高可达15m/s，比起背墙的某h网站，方便很多。

3. 还有一点，ollama是llama.cpp实现模型推理，模型小，速度快。

4. 还有，ollama提供11434端口的web服务，重要的是还兼容openai的端点接口，可以和各种前端配合，比如ollama自己open webui，国产的chatbox，连后端带界面，一套搞定

5. ollama是系统服务形式（也能容器运行），前后端分离（ 严格来说没有前端，只有命令行入口），耦合小，搭配灵活。

很好用，越用越好用，尤其对于linux用户。现在的主要问题是并发多模型不太好，将来会慢慢进的。

lm studio看界面很不错，功能也多。不过和界面耦合，最主要是拉模型太难了。



--2024/10/22更新--

ollama的迭代很快，现在多模型并发的问题已经解决了

编辑于 2024-10-22 10:21

#### [小白用户，硬件有限 灵活轻便ollama 硬件好则lm](https://www.zhihu.com/question/654357364/answer/3592907573)

所以我的结论就是，小白用户，硬件条件有限，要灵活轻便，随时可用就ollama。但建议再搭配比如chatbox客户端或者webUI。本身就有强大的本地硬件资源，且要求在本地硬件条件下能发挥出极致的性能效果，对运行参数有更多的自定义需求，就选择LM STUDIO吧，图形化界面用起来确实更舒适一些，内置的CHAT窗口也很好用，缺点就是LM还不能支持联网搜索，如果未来LM能补齐这个短板就更好。编辑于 2025-02-25 20:03



玄宮雲見
lm studio最简单的使用方法不是vs改代码，也不是tun代理，只需自己随便去什么魔搭社区、hf镜像之类的地方，下载gguf模型文件，然后扔在对应模型文件夹里就行了，只是文件夹的路径有些乱七八糟，路径是"你选定的目录\models\Publisher\模型名\xxx.gguf"。lm studio里没有的模型也可以这样使用lm studio运行。



我就是小号
我反而觉得对于小白来说lm更好用，直接下载安装使用就完事了，ollama部署一堆，还有环境变量，命令行执行，再搭配调用的客户端。这几步就能干死小白。

2025-02-05 · 四川

##### 两个推理框架都是 llama.cpp

胡振宇
至少在现在这两个使用的推理框架都是 llama.cpp ，推理效率上差别不大，ollama胜在足够的简单易用。

2025-03-04 · 湖南



#### ollama 40m/s，几分钟一个模型，lm走hf也慢

赵柯淇

ollama可以跑到40m每秒，几分钟一个模型，lm就算走hf也很慢
2024-08-15 · 甘肃

丙不蒙
有梯子就很简单。我这300兆的网轻松跑满。lm 我觉得更适合小白，只要有梯子下载就能用。唯一的不好就是它是闭源
2025-01-28 · 湖北



eric0095

hugging face镜像站下载gguf就行了，不用翻。ollama一路install，然后run一下就行了，也基本开箱即用了[飙泪笑]
2024-06-14 · 浙江

##### ollama速度快

是叮叮呀

老电脑ollama速度快，1.5b模型能到5个token。lmstudio只能到2个。纯cpu跑的，10年前挖掘机架构的A10-8780，4个核，cpu-z单核140分的垃圾cpu
2025-02-24 · 北京



#### [Ollama多 技术  LM Studio少 小白 硬件要求高](https://www.zhihu.com/question/654357364/answer/78721507169)



Ollama 和 [LM Studio](https://zhida.zhihu.com/search?content_id=708859847&content_type=Answer&match_order=1&q=LM+Studio&zhida_source=entity) 都是用来在本地运行[大型语言模型](https://zhida.zhihu.com/search?content_id=708859847&content_type=Answer&match_order=1&q=大型语言模型&zhida_source=entity)的工具，但它们的特点和用户群体不太一样，这可能是 Ollama 用的人更多，而 LM Studio 用的人少一些的原因。以下是具体分析：

1. **开源与闭源的区别**
   Ollama 是完全开源的，用户可以自由修改和分享它的代码，社区支持也很强。而 LM Studio 是闭源的，用户不能自定义核心功能，主要依赖官方支持。开源的特性让 Ollama 更受开发者和技术爱好者的欢迎。
2. **用户界面和易用性**
   Ollama 主要是[命令行操作](https://zhida.zhihu.com/search?content_id=708859847&content_type=Answer&match_order=1&q=命令行操作&zhida_source=entity)，适合懂技术的用户，但对普通用户可能不太友好。LM Studio 有[图形化界面](https://zhida.zhihu.com/search?content_id=708859847&content_type=Answer&match_order=1&q=图形化界面&zhida_source=entity)，操作更简单，适合初学者。不过，初学者可能对本地运行大型语言模型的需求比较少，而开发者更喜欢灵活的工具。
3. **功能和扩展性**
   Ollama 支持很多[预训练模型](https://zhida.zhihu.com/search?content_id=708859847&content_type=Answer&match_order=1&q=预训练模型&zhida_source=entity)，还能让用户自己[微调模型](https://zhida.zhihu.com/search?content_id=708859847&content_type=Answer&match_order=1&q=微调模型&zhida_source=entity)，适合需要深度定制的开发者。LM Studio 功能更全面，比如模型下载、运行和内置聊天界面，但这些功能对普通用户来说可能用不上，反而显得复杂。
4. **社区和生态支持**
   Ollama 有一个很活跃的[开源社区](https://zhida.zhihu.com/search?content_id=708859847&content_type=Answer&match_order=1&q=开源社区&zhida_source=entity)，新模型发布后很快就能适配。LM Studio 的社区相对较小，用户主要依赖官方支持，社区贡献有限。活跃的社区让 Ollama 能快速迭代，而 LM Studio 的生态支持较弱，可能影响了它的用户增长。
5. **硬件和系统兼容性**
   Ollama 对硬件要求低，支持 macOS、Linux 和 Windows，普通设备也能运行。LM Studio 对硬件要求高，需要支持 AVX2 指令集的处理器，Linux 版本还在测试中。低硬件门槛让 Ollama 更容易普及。
6. **模型支持和资源获取**
   Ollama 支持多种开源模型，用户还能导入自定义模型。LM Studio 主要依赖 [Hugging Face](https://zhida.zhihu.com/search?content_id=708859847&content_type=Answer&match_order=1&q=Hugging+Face&zhida_source=entity) 等平台的模型，但在国内访问 Hugging Face 可能不太方便。Ollama 的模型获取和扩展更便捷。

总的来说，Ollama 因为开源、灵活和社区支持强，更受开发者和技术爱好者欢迎；而 LM Studio 虽然功能多、界面友好，但闭源、硬件要求高和社区支持有限，可能限制了它的用户增长。Ollama 更适合技术用户，LM Studio 更适合初学者。



#### [lm studio闭源 ollama开源](https://www.zhihu.com/question/654357364/answer/78317019120)

需要注意的是，不同于全部代码在github开源、甚至可以自己动手编译的ollama，lm studio至今仍是闭源商业软件（仅一部分非核心代码除外）

截至目前，云侧大模型比（个人设备）端侧性能强大且便宜得多，用户被迫选用端侧大模型几乎就只为了保护隐私

结果lm studio汇集开源模型，却整个闭源软件就显得抽象，谁敢替他担保不会收集个人数据？这个用户群体刚需ollama那样全链路开源得明明白白

编辑于 2025-03-17 11:20



### [Qwen-VL看图说话 2080Ti 11G显存 xinference部署多模态大模型](https://www.bilibili.com/video/BV1UT4m1S7gx/)

小饭护法要转码
2024-02-03 00:39:20

本次用到的地址有：
https://github.com/xorbitsai/inference
https://inference.readthedocs.io/en/latest/getting_started/using_docker_image.html#dockerfile-for-custom-build
需要领域安装包的小伙伴
请在评论区或后台私信up~

小饭护法要转码
视频标题有歧义哈，我用的其实是22g的2080ti，只不过int4量化的qwen-vl占用了不到11g～
2024-02-04 14:49 👍1

### 国产卡的部署工具

lmdeploy fastllm vllm

