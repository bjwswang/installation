# 私有化部署安装包

****安装包工作目录 ~/kubeagi****

## Linux工具

| 工具 | 用途 | 下载位置 |
| --- | --- | --- |
| kind | 管理kind集群 | <https://kind.sigs.k8s.io/docs/user/quick-start/#installing-with-go-install> |
| kubectl | 管理K8s集群 | <https://kubernetes.io/docs/tasks/tools/#kubectl> |
| helm | 管理集群组件 | <https://helm.sh/docs/intro/install/> |

## Helm Charts

1. 下载kubebb

```bash
git clone https://github.com/kubebb/components.git
```

2. 下载kubeagi代码

```bash
git clone https://github.com/kubeagi/arcadia ~/kubeagi/
```

3. 下载 gpt-operator

```shell
git clone https://github.com/NVIDIA/gpu-operator.git 
cd gpu-operator & git checkout release-23.9
```

## 镜像列表

****如使用kind部署集群，则需执行 kind load docker-image xxx ****

### 基础镜像

| 镜像ID | 镜像Tag | 用途 | 功能模块 |
| --- | --- | --- | --- |
| kindest/node | v1.24.15 | 用于部署kind集群 | k8s集群 |

### KubeBB

| 镜像ID | 镜像Tag | 用途 | 功能模块 |
| --- | --- | --- | --- |
| kubebb/ingress-nginx-controller | v1.3.0 | Ingress 控制器 | cluster-component |
| kubebb/cert-manager-controller | v1.8.0 | cert-manager | cert-manager |
| kubebb/cert-manager-cainjector | v1.8.0 | cert-manager | cert-manager |
| kubebb/cert-manager-webhook | v1.8.0 | cert-manager | cert-manager |
| kubebb/iam-provider | v0.2.0-20240128 | IAM-Provider | IAM |
| kubebb/iam-controller | v0.2.0-20240128 | IAM-Provider | IAM |
| kubebb/oidc-server | v0.2.0 | OIDC | OIDC |
| kubebb/bff-server | v0.2.0-20231204 | bff层服务 | BFF-SERVER |
| kubebb/redis | 5.0.1-alpine3.8 | Session管理 | BFF-SERVER |
| kubebb/resource-viewer | v0.2.0 | 租户view | Tenant/ns/user view |
| kubebb/capsule-ce | v0.1.2-20221122 | 租户管理 | Tenant Management |
| kubebb/kube-oidc-proxy-ce | v0.3.0-20221008 | OIDC Proxy | oidc proxy |

### KubeAGI

| 镜像ID | 镜像Tag | 用途 | 功能模块 |
| --- | --- | --- | --- |
| kindest/node | v1.24.15 | 用于部署kind集群 | k8s集群 |
| kubeagi/arcadia | <https://hub.docker.com/layers/kubeagi/arcadia/v0.1.0-20240223-9d171ff/images/sha256-8aacfa20c7ed1ddd5586ed0dc19753738099c4ae3f4453b3fe410139210a0fb6?context=explore> | kubeagi的operator控制器 | kuebagi |
| kubeagi/data-processing | <https://hub.docker.com/layers/kubeagi/data-processing/v0.1.0-20240223-9d171ff/images/sha256-6d96311c85ae15dd98f97384e92f70274f0017d5e9a5bd5549fd1bfa44796896?context=explore> | 用于数据处理 | kuebagi |
| kubeagi/arcadia-eval | <https://hub.docker.com/layers/kubeagi/arcadia-eval/v0.1.0-20240223-49a6eba/images/sha256-3d750796ecdbc8683299748ac3182c92ad8d7007165ee6d927ebe2f49bf268e8?context=explore> | kubeagi智能体评估镜像 | kuebagi |
| kubeagi/ops-console | <https://hub.docker.com/layers/kubeagi/ops-console/v0.1.0-20240223-13da06a/images/sha256-bba8e3439af3653c232a56d1e93ac9eeef33267b2667ea60bc7b99e4cb7f6874?context=explore> | kubeag控制台前端镜像 | kuebagi |
| kubeagi/agent-portal | <https://hub.docker.com/layers/kubeagi/agent-portal/v0.1.0-20240223-cc94612/images/sha256-152a315b613090174656c7fc464934f95515761bcadd0396e39d63f1047ff7bd?context=explore> | Agent前端对话 | kuebagi |
| kubeagi/streamlit | <https://hub.docker.com/layers/kubeagi/streamlit/v1.29.0/images/sha256-fb0be5667ce6d7d89bcd192696e675dd195214bfa0fc3d5c8e561d4ca18b005e?context=explore> | 基于streamlit提供的基础应用 | kuebagi |
| kubeagi/arcadia-fastchat | <https://hub.docker.com/layers/kubeagi/arcadia-fastchat/v0.2.0/images/sha256-f110bba1fc4c5c81436672888a699feff7c2dbd8df4c84cdf43849133d85b009?context=explore> | 模型服务的API服务镜像 | kuebagi |
| kubeagi/postgresql | <https://hub.docker.com/layers/kubeagi/postgresql/16.1.0-debian-11-r18-pgvector-v0.5.1/images/sha256-8d47dc56e6ed1f7fad8e40e557dc4a89340c0952fea6b7eab491664eeec6b862?context=explore> | postgresql启用pgvector后的镜像 | kuebagi |
| kubeagi/arcadia-fastchat-worker
 | <https://hub.docker.com/layers/kubeagi/arcadia-fastchat-worker/v0.2.0/images/sha256-304122e32ada43da81f989ef01a3caa00e87aab723e57f61d78443a539826251?context=explore> | 模型服务工作节点镜像 | kuebagi |
| kubeagi/arcadia-fastchat-worker | <https://hub.docker.com/layers/kubeagi/arcadia-fastchat-worker/vllm-v0.2.0/images/sha256-b9c40cb6dcb2a5f1dc691750b53b3545625f7eba8ed5607154024cbe39a35c97?context=explore> | 模型服务工作节点镜像- 启用vllm推理加速 | kuebagi |
| kubeagi/minio-mc | <https://hub.docker.com/layers/kubeagi/minio-mc/RELEASE.2023-01-28T20-29-38Z/images/sha256-729b3d128487fd83b4788aae24672a812836f7c4aa8687c40045fe72bee64d98?context=explore> | 模型服务初始化镜像 | kuebagi |
| kubeagi/minio | <https://hub.docker.com/layers/kubeagi/minio/RELEASE.2023-02-10T18-48-39Z/images/sha256-ed0b0c56f1eae754e43d59955bad21826ed98d6534844560ec4fcbb9ef2e3a58?context=explore> | Minio服务镜像 | 对象存储 |
| kubeagi/ray-ml | <https://hub.docker.com/layers/kubeagi/ray-ml/2.9.0-py39-vllm/images/sha256-5ed214052ecd0de16bdc6868c55d50bc5559f23c6727ef7dfc0e2db77d2e5570?context=explore> | ray集群节点镜像 | ray分布式推理 |
| kubeagi/ray-operator | <https://hub.docker.com/layers/kubeagi/ray-operator/v1.0.0/images/sha256-4e6ac8a3a2c482d6c841cca72e88bad0e2ae8da6b1dfbe7ebabf8082be70d8e7?context=explore> | 模型Ray分部署推理operator控制器 | ray分布式推理 |

### Nvidia GPU Operator

`对应Chart版本: v23.9.1`

| 镜像ID | 镜像Tag | 备注 |
| --- | --- | --- |
| nvcr.io/nvidia/gpu-feature-discovery | v0.8.2-ubi8 | 镜像仓库: nvcr.io |
| nvcr.io/nvidia/k8s/container-toolkit | v1.14.3-ubuntu20.04 | 镜像仓库: nvcr.io |
| nvcr.io/nvidia/k8s/dcgm-exporter | 3.3.0-3.2.0-ubuntu22.04 | 镜像仓库: nvcr.io |
| nvcr.io/nvidia/k8s-device-plugin | v0.14.3-ubi8 | 镜像仓库: nvcr.io |
| nvcr.io/nvidia/driver | 535.129.03-ubuntu22.04 | 镜像仓库: nvcr.io |
| nvcr.io/nvidia/cloud-native/k8s-driver-manager | v0.6.5 | 镜像仓库: nvcr.io |
| nvcr.io/nvidia/cloud-native/k8s-mig-manager | v0.5.5-ubuntu20.04 | 镜像仓库: nvcr.io |
| <http://nvcr.io/nvidia/cloud-native/gpu-operator-validator> | v23.9.1 | 镜像仓库: nvcr.io |
| <http://nvcr.io/nvidia/gpu-operator> | v23.9.1 | 镜像仓库: nvcr.io |
| nvcr.io/nvidia/node-feature-discovery | v0.14.2 | 镜像仓库: nvcr.io |

## 模型列表

**工作目录: ~/kubeagi/models/**

| 模型名称 | 介绍 | 下载方式（摩搭） |
| --- | --- | --- |
| bge-large-zh-v1.5 | 中文Embedding模型 | git clone <https://www.modelscope.cn/AI-ModelScope/bge-large-zh-v1.5.git> |
| qwen-7b-chat | 通义千问7B模型 | git clone <https://www.modelscope.cn/qwen/Qwen-7B-Chat.git> |
