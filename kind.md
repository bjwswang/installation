# 环境准备

## 机器配置

| 类型 | 配置 |
| --- | --- |
| CPU | 16核 |
| Memory | 96G |
| GPU | 推荐GPU4090 |
| CUDA运行时 | 12.2 |
| OS | Ubuntu22.04 |

## 环境

- Docker(^24.0.5)
- Helm(^3.13.1)
- kubectl(^1.28.3)

### 1. 准备一个Kubernetes集群

集群安装方式有以下几种:

- [kind](https://kind.sigs.k8s.io/docs/)(^0.20.0)
- [minikube](https://minikube.sigs.k8s.io/)
- [kubeadm](https://kubernetes.io/docs/admin/kubeadm/)

#### 准备一个Kind集群

1. 配置Docker使用nvidia runtime

编辑 `/etc/docker/daemon.json`

```json
{
    "default-runtime": "nvidia",
    "runtimes": {
        "nvidia": {
            "args": [],
            "path": "nvidia-container-runtime"
        }
    }
}
```

重启docker:

```bash
sudo systemctl restart docker
```

2. 配置nvidia容器运行时

编辑 `/etc/nvidia-container-runtime/config.toml` ，设置

`accept-nvidia-visible-devices-as-volume-mounts = true`

3. 创建单节点kind集群

```bash
cd arcadia
make kind
```

安装完成后，运行如下命令:

```bash
docker exec -ti kubeagi-control-plane ln -s /sbin/ldconfig /sbin/ldconfig.real
```

## 2. 安装nvidia gpu operator

```bash
cd arcadia/deploy/charts/gpu-operator
helm install --generate-name \
     -n gpu-operator --create-namespace \
     gpu-operator --set driver.enabled=false .
```
