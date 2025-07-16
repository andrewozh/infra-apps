# Monitoring stack

||Self-hosted|SaaS|
|-|-|-|
|**Tool**|[kube-prometheus-stack](#)|[Datadog](#)|
|**Type**|||
|**Deploy**|[helm-chart](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack)||

**kube-prometheus-stack:**

||Engine|Dashboards|Alerts|
|-|-|-|-|
|**Tool**|[Prometheus](prometheus.md)|[Grafana](grafana.md)|[Alert Manager](alert-manager.md)|
|**Type**|kubernetes-operator|||
|**Deploy**|helm-chart|||

## Architecture

- How it works
- Main terms
- cross-cluster monitoring setup

## Monitoring

- what metrics to pay attention on
- alerts

## Patform integration

- how this tool integrated into a platform
- how to use it in a platform
- how to debug
