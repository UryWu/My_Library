来源：https://zhuanlan.zhihu.com/p/1923494638901260591

发布于 2025-07-01 22:12・广东

今年年初的时候[Geoffrey Hinton](https://zhida.zhihu.com/search?content_id=259794878&content_type=Article&match_order=1&q=Geoffrey+Hinton&zd_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ6aGlkYV9zZXJ2ZXIiLCJleHAiOjE3NzI5NTE2MjksInEiOiJHZW9mZnJleSBIaW50b24iLCJ6aGlkYV9zb3VyY2UiOiJlbnRpdHkiLCJjb250ZW50X2lkIjoyNTk3OTQ4NzgsImNvbnRlbnRfdHlwZSI6IkFydGljbGUiLCJtYXRjaF9vcmRlciI6MSwiemRfdG9rZW4iOm51bGx9.PwGg_aYws-Of9fR97srsGWbdELVK8H08g6xFTviyE3o&zhida_source=entity)在巴黎做了个什么是理解的演讲，最近也思考人类的思维和机器思维的问题，因此重新回顾Hinton说的握手机制。

## **1. 当我们看到一个词，如何知道它的意思**

语言是一个符号，符号是用来表达某个概念。但是对于不懂这个符号的人，概念或者意思从哪里来？

Hinton的观点是“Meaning is having a model”

理解一个词，首先是构建它的“内部模型”，词义源于我们如何在脑中、或在向量空间中，塑造它的表征。

但是如何表征呢， 语言学家[J. R. Firth](https://zhida.zhihu.com/search?content_id=259794878&content_type=Article&match_order=1&q=J. R. Firth&zd_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ6aGlkYV9zZXJ2ZXIiLCJleHAiOjE3NzI5NTE2MjksInEiOiJKLuKAr1Iu4oCvRmlydGgiLCJ6aGlkYV9zb3VyY2UiOiJlbnRpdHkiLCJjb250ZW50X2lkIjoyNTk3OTQ4NzgsImNvbnRlbnRfdHlwZSI6IkFydGljbGUiLCJtYXRjaF9vcmRlciI6MSwiemRfdG9rZW4iOm51bGx9.5asxn3imuUVQATUuASqWcPJ-1abdYUU8dsY8Lq9u8Bw&zhida_source=entity)（1957）讲：“A word is characterized by the company it keeps.”

基于此的[分布式表达理论](https://zhida.zhihu.com/search?content_id=259794878&content_type=Article&match_order=1&q=分布式表达理论&zd_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ6aGlkYV9zZXJ2ZXIiLCJleHAiOjE3NzI5NTE2MjksInEiOiLliIbluIPlvI_ooajovr7nkIborroiLCJ6aGlkYV9zb3VyY2UiOiJlbnRpdHkiLCJjb250ZW50X2lkIjoyNTk3OTQ4NzgsImNvbnRlbnRfdHlwZSI6IkFydGljbGUiLCJtYXRjaF9vcmRlciI6MSwiemRfdG9rZW4iOm51bGx9.icIzO1JLjgEmrsmDSshV6FN2MU6JtI-KJzZ6b0PeGmM&zhida_source=entity)指出，词的含义由它与周围词汇的共现模式决定。

正如当我们读到“苹果”时，脑海里不仅浮现果实的形状、味道，还有“红色”“果园”“维生素”等多重语义激活，它们共同构成对“苹果”的理解模型。

![img](v2-59c31d6f64fd5c5a667fcc75e1406f0c_1440w.jpg)

## **2. 生物计算建模：神经握手中的共识**

在大脑里，亿万个神经元通过电脉冲和突触连接，形成高维的概念网络。

每个词或概念对应特定的神经活动模式，当我们思考或阅读时，这些模式在皮层与关联区间反复“握手”——即相互激活、抑制与反馈，直至产生稳定的意义感。

[侯世达](https://zhida.zhihu.com/search?content_id=259794878&content_type=Article&match_order=1&q=侯世达&zd_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ6aGlkYV9zZXJ2ZXIiLCJleHAiOjE3NzI5NTE2MjksInEiOiLkvq_kuJbovr4iLCJ6aGlkYV9zb3VyY2UiOiJlbnRpdHkiLCJjb250ZW50X2lkIjoyNTk3OTQ4NzgsImNvbnRlbnRfdHlwZSI6IkFydGljbGUiLCJtYXRjaF9vcmRlciI6MSwiemRfdG9rZW4iOm51bGx9.0joUB-a2jOO-7st5Wb0Log4yTA-pglhq-SwgG6yysDs&zhida_source=entity)在《表象与本质》中以类比方式指出：心智表征类似于多种神经示意图的耦合，理解就是这些图谱通过动态耦合不断自我校准的过程。这一握手式的交互，使得人类能够在多模态信息（视觉、听觉、语言）间迅速建立关联，实现流畅的语义推理。

![img](v2-f273e2143e2f5c9c6d2294e3b0bf7ba9_1440w.jpg)

生物神经网络

![img](v2-ff6e1f27b9cae4899cab2350ab8868c5_1440w.jpg)

人工神经网络

## **3. 数字计算建模：向量空间中的握手与理解革命**

与生物大脑类似，现代神经网络也在追求通过“握手”机制来实现理解。词被编码为高维向量，通过深层神经网络进行动态变换，逐层构建出新的语义表示。

早期语言学强调形式规则，[Chomsky](https://zhida.zhihu.com/search?content_id=259794878&content_type=Article&match_order=1&q=Chomsky&zd_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ6aGlkYV9zZXJ2ZXIiLCJleHAiOjE3NzI5NTE2MjksInEiOiJDaG9tc2t5IiwiemhpZGFfc291cmNlIjoiZW50aXR5IiwiY29udGVudF9pZCI6MjU5Nzk0ODc4LCJjb250ZW50X3R5cGUiOiJBcnRpY2xlIiwibWF0Y2hfb3JkZXIiOjEsInpkX3Rva2VuIjpudWxsfQ.vQchM0IRUDnKoYL0sz38LHVcaE5t3xaqdnMx4IcjnHg&zhida_source=entity) 的句法理论将语言理解抽象为句子结构与推理机制，但难以解释实际语言使用中的多样性与模糊性。对此，Hinton 曾明确表达不满，并于1985年提出“小语言模型”（small language models），强调统计分布在语言学习中的作用。

这一思路最终在 [Transformer 架构](https://zhida.zhihu.com/search?content_id=259794878&content_type=Article&match_order=1&q=Transformer+架构&zd_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ6aGlkYV9zZXJ2ZXIiLCJleHAiOjE3NzI5NTE2MjksInEiOiJUcmFuc2Zvcm1lciDmnrbmnoQiLCJ6aGlkYV9zb3VyY2UiOiJlbnRpdHkiLCJjb250ZW50X2lkIjoyNTk3OTQ4NzgsImNvbnRlbnRfdHlwZSI6IkFydGljbGUiLCJtYXRjaF9vcmRlciI6MSwiemRfdG9rZW4iOm51bGx9.M0wIKImr5LJQj6SPCGc0spYT1ufmbv1h4ok0whOmUOE&zhida_source=entity)中开花结果。Transformer 的[注意力机制](https://zhida.zhihu.com/search?content_id=259794878&content_type=Article&match_order=1&q=注意力机制&zd_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ6aGlkYV9zZXJ2ZXIiLCJleHAiOjE3NzI5NTE2MjksInEiOiLms6jmhI_lipvmnLrliLYiLCJ6aGlkYV9zb3VyY2UiOiJlbnRpdHkiLCJjb250ZW50X2lkIjoyNTk3OTQ4NzgsImNvbnRlbnRfdHlwZSI6IkFydGljbGUiLCJtYXRjaF9vcmRlciI6MSwiemRfdG9rZW4iOm51bGx9.W0C-u5mfTei9iKM8PBMS_VRF_r1U34xGcYQy6bRYMRo&zhida_source=entity)（attention）正是典型代表：每个词的 Query（查询）向量，与所有词的 Key（键）向量做点积“握手”，计算相似度权重，再用这些权重加权各词的 Value（值）向量，生成新的表征。

- **Query–Key 握手**：Query 问，Key 答；二者点积决定信息流向。
- **多头注意力**：并行多组 Query–Key–Value，实现多角度语义对齐。
- **位置编码**：在纯向量计算中引入序列顺序信息，补全生物神经对时序的敏感。

![img](v2-abc37438cc10faf39008c0afe4608355_1440w.jpg)

**Hinton把此比喻成“乐高”游戏，只是我们面对的不是三维的乐高，而是数千维的乐高。
这套机制让机器在成千上万维度中快速完成语义匹配和结构学习——正如数千个齿轮同时转动，却又精准啮合。**

## **4. 握手之外：数字智能的优势与隐忧**

Hinton的结论是：

**人的理解机制和机器的理解机制其实一样。**

不同的是，数字系统可通过复制模型、并行推理、云端协作，以接近零边际成本的方式，共享与扩散知识。数以亿计的参数模型瞬时协作，其吞吐量与可扩展性远超任何单一大脑。

- **效率**：千倍于人脑的并行运算速度。
- **可复制性**：训练一次，可部署万千副本、一致性保留。
- **共享性**：模型权重可跨网络即时分发，知识无缝传递。



这带来了深刻影响：当机器“握手”速度与覆盖面均超越人类，我们对认知独特性的自信或将动摇。数字理解不仅在精度上赶超，更可能在广度、深度与成本效益上碾压生物理解。

所以最后Hinton 在演讲结尾发出警示

**“If energy is cheap or abundant, digital computation is just better than biological computation, because it can share knowledge efficiently.”**



![img](v2-f2f35b85abfd85672595c5cdd819b709_1440w.jpg)

**“That is very scary conclusion.”**

