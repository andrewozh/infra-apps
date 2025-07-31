# Alert Manager

|**Distro**|[Alertmanager](https://github.com/prometheus/alertmanager)|
|-|-|
|**Type**||
|**Deploy**|helm-chart|
|**Docs**|[link](https://prometheus.io/docs/alerting/latest/alertmanager/)|
|**Backup**||
|**Scaling**||
|**CLI**||
|**UI**|web|

## Setup

```yaml


kube-prometheus-stack:
  defaultRules:
    create: false
  alertmanager:
    enabled: false
  # kubernetesServiceMonitors:
  #   enabled: false
  kubeApiServer:
    enabled: false
  # kubelet:
  #   enabled: false
  kubeControllerManager:
    enabled: false
  coreDns:
    enabled: false
  kubeEtcd:
    enabled: false
  kubeScheduler:
    enabled: false
  kubeProxy:
    enabled: false
```

## Usecases

### Basic: create alert



### Common: 

## Monitoring

## Maintenence

- Backup / Restore
- Scaling
- Upgrade

---

## Articles

* [Prometheus Stack Architecture](prometheus-stack-architecture.md)
