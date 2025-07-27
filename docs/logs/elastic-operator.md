# Elastic Cloud on Kubernetes

|**Distro**|[ECK Operator](https://github.com/elastic/cloud-on-k8s)|
|-|-|
|**Type**|kubernetes-operator|
|**Deploy**|helm-chart|
|**Docs**|[link](https://www.elastic.co/docs/deploy-manage/deploy/cloud-on-k8s)|
|**Backup**||
|**Scaling**||
|**CLI**||
|**UI**|kibana|

## Setup

- deployment explained
- how to setup

## Usecases

### Basic: create db, create user, connect, etc.

```bash
kubectl get secret elasticsearch-es-elastic-user -n logging -o jsonpath='{.data.elastic}' | base64 -d
```

### Common: write data, read data, replication, etc.

## Maintenence

- Backup / Restore
- Scaling
- Upgrade

---

## Articles

* [Example article link](#)

