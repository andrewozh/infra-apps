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

### Basic: create user for fluentbit, configure log shipping, view logs in Kibana

[Fluent-bit](fluentbit.md)

- create secret `role` for fluentbit

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: fluentbit-role
stringData:
  roles.yml: |
    fluentbit:
      cluster:
        - monitor
        - manage_index_templates
        - manage_ilm
      indices:
        - names:
            - "logstash-*"
            - "node-*"
            - "logs-*"
            - "fluentbit-*"
          privileges:
            - create_index
            - create
            - index
            - write
            - manage
            - manage_ilm
```

- create secret `user` for fluentbit

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
  roles: $(echo -n "fluentbit" | base64)
EOF
```

- apply new user and role

```yaml
eck-stack:
  eck-elasticsearch:
    auth:
      fileRealm:
        - secretName: fluentbit-user-secret
      roles:
        - secretName: fluentbit-role
```

- try new user

```bash
root@dev-sandbox:/# curl -k -u fluentbit:fluentbit https://elasticsearch-es-internal-http.logging.svc.cluster.local:9200/_cluster/health
{"cluster_name":"elasticsearch","status":"green","timed_out":false,"number_of_nodes":1,"number_of_data_nodes":1,"active_primary_shards":35,"active_shards":35,"relocating_shards":0,"initializing_shards":0,"unassigned_shards":0,"unassigned_primary_shards":0,"delayed_unassigned_shards":0,"number_of_pending_tasks":0,"number_of_in_flight_fetch":0,"task_max_waiting_in_queue_millis":0,"active_shards_percent_as_number":100.0}
```

- access kibana with admin `elastic` user

```bash
kubectl get secret elasticsearch-es-elastic-user -n logging -o jsonpath='{.data.elastic}' | base64 -d
```

### Common: write data, read data, replication, etc.

## Monitoring

- deploy `prometheus-elasticsearch-exporter` and configure es endpoint

```yaml
prometheus-elasticsearch-exporter:
  es:
    uri: https://fluentbit:fluentbit@elasticsearch-es-http.logging.svc:9200
    sslSkipVerify: true
```

- check metrics

```bash
curl elk-prometheus-elasticsearch-exporter.logging:9108/metrics
```

- create service monitor

```yaml

```

## Maintenence

- Backup / Restore
- Scaling
- Upgrade

---

## Articles

* [Example article link](#)

