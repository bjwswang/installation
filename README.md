# installation

## Versions

| Helm Chart | kubeagi |
| --- | --- |
| arcadia-0.3.30 | v0.2.2 |

## Prerequisites

1. Hardware requirements

| 类型 | 配置 |
| --- | --- |
| CPU | 16核 |
| Memory | 96G |
| GPU | 推荐GPU4090 |
| CUDA运行时 | 12.2 |
| OS | Ubuntu22.04 |
| Disk | 1T |

2. Software requirements

- Docker(^24.0.5)
- Helm(^3.13.1)
- kubectl(^1.28.3)

## Quick start

### 1. Download kubeagi

1. Clone this repo

```shell
git clone https://github.com/bjwswang/installation.git
```

2. Download kubeagi

```shell
bash scripts/download.sh
```

## Private environment installation

1. [Download kubeagi](#1-download-kubeagi)
2. Package kubeagi

```shell
bash scripts/package.sh
```

A tar package `kubeagi.tar` will be generated.

3. Copy the package to the target machines and untar

```shell
tar -xvf kubeagi.tar
```

4. Unpack the kubeagi package

```shell
bash scripts/unpack.sh
````

- mainly to load docker images
