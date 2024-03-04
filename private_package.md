# 私有化部署安装包

****安装包工作目录 ~/kubeagi****

## 工具

| 工具 | 用途 | 下载位置 | 版本要求 |
| --- | --- | --- |
| docker | 容器运行环境 | <https://docs.docker.com/engine/install/> | ^24.0.5 |
| kind | 管理kind集群 | <https://kind.sigs.k8s.io/docs/user/quick-start/#installing-with-go-install> | ^0.20.0 |
| kubectl | 管理K8s集群 | <https://kubernetes.io/docs/tasks/tools/#kubectl> | ^1.28.3 |
| helm | 管理集群组件 | <https://helm.sh/docs/intro/install/> | ^3.13.1 |

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
| kubeagi/arcadia | v0.1.0-20240223-9d171ff | kubeagi的operator控制器 | kuebagi |
| kubeagi/data-processing | v0.1.0-20240223-9d171ff | 用于数据处理 | kuebagi |
| kubeagi/arcadia-eval | v0.1.0-20240223-49a6eba | kubeagi智能体评估镜像 | kuebagi |
| kubeagi/ops-console | v0.1.0-20240223-13da06a | kubeag控制台前端镜像 | kuebagi |
| kubeagi/agent-portal | v0.1.0-20240223-cc94612 | Agent前端对话 | kuebagi |
| kubeagi/streamlit | v1.29.0 | 基于streamlit提供的基础应用 | kuebagi |
| kubeagi/arcadia-fastchat | v0.2.0 | 模型服务的API服务镜像 | kuebagi |
| kubeagi/postgresql | 16.1.0-debian-11-r18-pgvector-v0.5.1 | postgresql启用pgvector后的镜像 | kuebagi |
| kubeagi/arcadia-fastchat-worker | v0.2.0 | 模型服务工作节点镜像 | kuebagi |
| kubeagi/arcadia-fastchat-worker | vllm-v0.2.0 | 模型服务工作节点镜像- 启用vllm推理加速 | kuebagi |
| kubeagi/minio-mc | RELEASE.2023-01-28T20-29-38Z | 模型服务初始化镜像 | kuebagi |
| kubeagi/minio | RELEASE.2023-02-10T18-48-39Z | Minio服务镜像 | 对象存储 |
| kubeagi/ray-ml | 2.9.0-py39-vllm | ray集群节点镜像 | ray分布式推理 |
| kubeagi/ray-operator | v1.0.0 | 模型Ray分部署推理operator控制器 | ray分布式推理 |

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
| nvcr.io/nvidia/cloud-native/gpu-operator-validator | v23.9.1 | 镜像仓库: nvcr.io |
| nvcr.io/nvidia/gpu-operator | v23.9.1 | 镜像仓库: nvcr.io |
| nvcr.io/nvidia/node-feature-discovery | v0.14.2 | 镜像仓库: nvcr.io |

## 模型列表

**工作目录: ~/kubeagi/models/**

| 模型名称 | 介绍 | 下载方式（摩搭） |
| --- | --- | --- |
| bge-large-zh-v1.5 | 中文Embedding模型 | git clone <https://www.modelscope.cn/AI-ModelScope/bge-large-zh-v1.5.git> |
| qwen-7b-chat | 通义千问7B模型 | git clone <https://www.modelscope.cn/qwen/Qwen-7B-Chat.git> |
