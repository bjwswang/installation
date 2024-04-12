# LLaMA-Factory chart 使用文档

## 部署

使用 chart：

- 修改 `values.yaml`

  ```yaml
  # ingress configurations for component
  ingress:
    # set enable to `true` to enable ingress
    enable: true
    ingressClassName: portal-ingress
    # 修改域名
    ingressDomain: <replaced-ingress-nginx-ip>.nip.io
  
  # volume configurations for llama-factory
  volume:
    # 备注：为容器设定环境变量 USE_MODELSCOPE_HUB=1 后，下列缓存目录可指定为 modelscope 的缓存目录
    # 另注：以其他方式（如 git clone）下载的模型亦可放入该目录下，但在 web UI 界面需手动指定所在目录
    # hfcache is the cache path for huggingface model from host 指定 huggingface 缓存目录
    hfcache: ""
    # data is the data path for llama-factory from host
    data: ""
    # output is the output path for llama-factory from host
    output: ""
  
  # llama-factory configurations
  image: kubeagi/llama-factory:v0.6.1
  imagePullPolicy: IfNotPresent
  resources:
    limits:
      cpu: "4"
      memory: 12Gi
      # 改为 "1" 以调用 GPU 资源
      nvidia.com/gpu: "0"
    requests:
      cpu: "1"
      memory: 1Gi
      nvidia.com/gpu: "0"
  
  ```

- 在 chart 文件目录下，使用 helm 安装至指定 namespace：

  ``` helm install -n YOUR_NAMESPACE lmf . ```

## 流程

### 基于 ChatGLM3-6B 微调流程

参考文献：

- [基于chatglm3-6b模型的lora方法的微调 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/683583816)
- [【微调】CHATGLM2-6B LoRA 微调 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/639581192)
- [LLaMA-Factory微调（sft）ChatGLM3-6B保姆教程_chatglm3-6b llama factory-CSDN博客](https://blog.csdn.net/weixin_40677588/article/details/137139471)
- [快速上手！LLaMa-Factory最新微调实践，轻松实现专属大模型 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/678571079)
- [llama-factory SFT系列教程 (一)，大模型 API 部署与使用-CSDN博客](https://blog.csdn.net/sjxgghg/article/details/137654018)
- [单卡 3 小时训练专属大模型 Agent：基于 LLaMA Factory 实战 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/678989191)
- [打造 LLM 界的 Web UI：24GB 显卡训练百亿大模型 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/645010851)

![img](https://img-blog.csdnimg.cn/direct/5a96fd35422947b988a7e3776c232ae8.png)

1. 指定模型名称（非自动下载，放入hfcache路径的目录需手动指定模型目录）

2. 指定微调方法：

   - all = 全参量：调整整个预训练模型的全部权重，其成果 = 新的完整模型文件
   - freeze = 冻结：只调整预训练模型少数几层的权重，其成果 = 新的完整模型文件
   - lora = LoRA微调：不改变原模型，训练一个”适配器“（adapter）权重，推理时需配合使用。其成果 = 一个适配器 checkpoint

3. 指定训练阶段（一般使用 SFT 监督调优）

4. 指定训练用数据集

   ![img](https://pic3.zhimg.com/80/v2-f797887361f10fee548f2664c29409ae_720w.webp)

5. 指定其他参数

   - 较小的数据集可尝试增加**训练轮数至50~200区间**以提高效果（增加耗时）
   - Ampere 及更新架构的算力卡可使用 bf16 格式以降低内存占用
   - 显存较小的情况下，**batchsize（批处理大小）**建议调低至 1 或 2，否则容易 OOM 
   - 其他参数可以不调
   - 部分参考：

   ![img](https://img-blog.csdnimg.cn/direct/1c571926aa6e457e97f0e893dd24f33a.png)

   - Yi-6B 的参考（A100 40GB）：
   - ![img](https://pic1.zhimg.com/v2-c8bb2b47b3670b6a9f609b7c8f04858c_r.jpg)

6. 预览命令并执行

   ![img](https://img-blog.csdnimg.cn/direct/a5d5b7d2eca648ae9f61f41f2447f2d3.png)![img](https://img-blog.csdnimg.cn/direct/268feeb4dcd2457fb132a88f94dd1dc2.png)

### 模型测试

![img](https://pic3.zhimg.com/v2-3f3bf5741d2b700981c248338a054b9a_r.jpg)

### 导出及部署

>  切换到 **Export** 栏，选择**最大分块大小**为 2GB，填写**导出目录**为 models/yi-agent-6b，点击**开始导出**按钮，将 LoRA 权重合并到模型中，同时保存完整模型文件，保存后的模型可以通过 transformers 等直接加载。

![img](https://pic2.zhimg.com/v2-9b4cb419c72225b93184f44a6ee165c5_r.jpg)

这一步将把 LoRA 权重与原模型合并，输出的也是**完整的模型文件**，可以直接替换原模型文件调用。