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

  alertmanager:
    enabled: true
    serviceMonitor:
      selfMonitor: true

  defaultRules:
    create: true
    rules:
      etcd: false
      kubeApiserverAvailability: false
      kubeApiserverBurnrate: false
      kubeApiserverHistogram: false
      kubeApiserverSlos: false
      kubeControllerManager: false
      kubeProxy: false
      kubeSchedulerAlerting: false
      kubeSchedulerRecording: false

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

### Basic: create own PrometheusRule, receive an Alert

### Common: 

## :arrows_counterclockwise: Monitoring

## Maintenence

- Backup / Restore
- Scaling
- Upgrade

---

## Articles

* [Prometheus Stack Architecture](prometheus-stack-architecture.md)
