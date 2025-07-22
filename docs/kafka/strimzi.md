# Strimzi Kafka Operator

|**Distro**|[Strimzi Kafka Operator](https://github.com/strimzi/strimzi-kafka-operator)|
|-|-|
|**Type**|kubernetes-operator|
|**Deploy**|helm-chart|
|**Docs**|[link](https://strimzi.io/documentation/)|
|**Backup**||
|**Scaling**||
|**CLI**|kafkacat|
|**UI**|[kafka-ui](https://github.com/provectus/kafka-ui) (web)|

## Setup

- deployment explained
- how to setup

**Kafka Bridge** provides a RESTful interface that allows HTTP-based clients to interact with a Kafka cluster.

**Mirror Maker** is a tool for replicating data between Kafka clusters, which can be useful for disaster recovery or data migration.

## Usecases

### Basic: create cluster, create user, create topic, connect

- [?] Connect

port-forward 9092

```bash
kubectl get secret admin-kafka-user -n kafka -o jsonpath='{.data.password}' | base64 -d
BzXay6RkjAbuTqIeCXXHAwNEpWmpHtQC

kcat -b localhost:9092 \
  -t dante-topic \
  -X security.protocol=SASL_PLAINTEXT \
  -X sasl.mechanism=SCRAM-SHA-256 \
  -X sasl.username=admin-kafka-user \
  -X sasl.password='BzXay6RkjAbuTqIeCXXHAwNEpWmpHtQC'
```

### Common: produce message to topic, consume from topic, consumer group

### Advanced: replication, etc.

## Maintenence

- Backup / Restore
- Scaling
- Upgrade

---

## Articles

* [Zookeeper](#)

