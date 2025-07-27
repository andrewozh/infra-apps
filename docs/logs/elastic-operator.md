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

- access kibana with admin `elastic` user

```bash
kubectl get secret elasticsearch-es-elastic-user -n logging -o jsonpath='{.data.elastic}' | base64 -d
```

- creating user for `fluent-bit`

```bash
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: fluentbit-user-secret
  namespace: logging
type: kubernetes.io/basic-auth
data:
  username: $(echo -n "fluentbit" | base64)
  password: $(echo -n "fluentbit" | base64)
  roles: $(echo -n "logstash_system,ingest_admin,manage_index_templates,monitoring_user" | base64)
EOF
```

### Common: write data, read data, replication, etc.

## Maintenence

- Backup / Restore
- Scaling
- Upgrade

---

## Articles

* [Example article link](#)

