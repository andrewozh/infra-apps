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

- Single-node cluster configuration

use `KafkaNodePool` to create zookeeper-less cluster with KRaft mode enabled

```yaml
apiVersion: kafka.strimzi.io/v1beta2
kind: KafkaNodePool
metadata:
  name: single-node
  labels:
    strimzi.io/cluster: kafka-cluster
spec:
  replicas: 1
  roles:
    - controller
    - broker
  storage:
    type: jbod
    volumes:
      - id: 0
        type: persistent-claim
        size: 2Gi
        deleteClaim: true
        kraftMetadata: shared
```

Kafka cluster configuration, pay attention to:

* `.spec.kafka.listeners` -- defines the listeners for the Kafka cluster, including authentication methods.

* `.spec.kafka.authorization` -- defines the authorization type and super users.

```yaml
apiVersion: kafka.strimzi.io/v1beta2
kind: Kafka
metadata:
  name: kafka-cluster
  annotations:
    strimzi.io/node-pools: enabled
    strimzi.io/kraft: enabled
spec:
  kafka:
    version: 4.0.0
    metadataVersion: 4.0-IV3
    authorization:
      type: simple
      superUsers:
        - admin-kafka-user
    listeners:
      - name: plain # need to stay without auth for proper broker communication
        port: 9092
        type: internal
        tls: false
      - name: internal # add port to main brokers service with scram-sha-512 auth
        port: 9095
        type: internal
        tls: false
        authentication:
          type: scram-sha-512
      - name: tls
        port: 9093
        type: internal
        tls: true
      - name: portforward  # special service configured to be used with port-forward
        port: 9094
        type: nodeport
        tls: false
        authentication:
          type: scram-sha-512
        configuration:
          bootstrap:
            nodePort: 30094
          brokers:
          - broker: 0
            nodePort: 30664
            advertisedHost: localhost
    config:
      offsets.topic.replication.factor: 1
      transaction.state.log.replication.factor: 1
      transaction.state.log.min.isr: 1
      default.replication.factor: 1
      min.insync.replicas: 1
      auto.create.topics.enable: false
      delete.topic.enable: true
  entityOperator:
    topicOperator: {}
    userOperator: {}
```

- Topic

```yaml
apiVersion: kafka.strimzi.io/v1beta1
kind: KafkaTopic
metadata:
  name: dante-topic
  namespace: kafka
  labels:
    strimzi.io/cluster: kafka-cluster
spec:
  partitions: 10
  replicas: 1
```

- Users

admin user list in `Kafka` resource `.spec.kafka.authorization.superUsers`

```yaml
apiVersion: kafka.strimzi.io/v1beta1
kind: KafkaUser
metadata:
  name: admin-kafka-user
  namespace: kafka
  labels:
    strimzi.io/cluster: kafka-cluster
spec:
  authentication:
    type: scram-sha-512
```

user with access to `topic`` and `consumer group`

```yaml
apiVersion: kafka.strimzi.io/v1beta1
kind: KafkaUser
metadata:
  name: dante-kafka-user
  namespace: kafka
  labels:
    strimzi.io/cluster: kafka-cluster
spec:
  authentication:
    type: scram-sha-512
  authorization:
    type: simple
    acls:
    - resource:
        type: topic
        name: dante-topic
      operations:
        - Describe
        - Read
        - Write
      host: "*"
    - resource:
        type: group
        name: dante-group
        patternType: prefix
      operations:
        - Describe
        - Read
      host: "*"
```

- Produce and Consume messages internally

our users need scram-sha-512 auth, so we can use only internal listener with `scram-sha-512` authentication enabled (on 9095 port)

```bash
# create properties files with scram-sha-512 creds
for user in dante-kafka-user admin-kafka-user; do
  cat <<EOF | kubectl exec -i kafka-cluster-single-node-0 -n kafka -c kafka -- sh -c 'cat > /tmp/'${user}'.properties'
security.protocol=SASL_PLAINTEXT
sasl.mechanism=SCRAM-SHA-512
sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="$user" password="$(kubectl get secret $user -n kafka -o jsonpath='{.data.password}' | base64 -d)";
EOF
done

# produce message as dante
./bin/kafka-console-producer.sh \
  --bootstrap-server kafka-cluster-kafka-bootstrap:9095 \
  --producer.config /tmp/dante-kafka-user.properties \
  --topic dante-topic
>Hello

# produce message as admin
./bin/kafka-console-producer.sh \
  --bootstrap-server kafka-cluster-kafka-bootstrap:9095 \
  --producer.config /tmp/admin-kafka-user.properties \
  --topic dante-topic
>world

# consume as admin
./bin/kafka-console-consumer.sh \
  --bootstrap-server kafka-cluster-kafka-bootstrap:9095 \
  --producer.config /tmp/dante-kafka-user.properties \
  --topic dante-topic --from-beginning
Hello
world
^CProcessed a total of 2 messages

# consume as dante
./bin/kafka-console-consumer.sh \
  --bootstrap-server kafka-cluster-kafka-bootstrap:9095 \
  --producer.config /tmp/dante-kafka-user.properties \
  --topic dante-topic --from-beginning
Hello
world
^CProcessed a total of 2 messages
```

- Access Kafka cluster via `port-forward`

port-forwarding listener explained:

```yaml
      - name: portforward  # special service configured to be used with port-forward
        port: 9094
        type: nodeport
        tls: false
        authentication:
          type: scram-sha-512
        configuration:
          bootstrap:
            nodePort: 30094
          brokers:
          - broker: 0
            nodePort: 30664 # each brokers port have to be port-forwarded
            advertisedHost: localhost # because afer port-forwarding we will access it via localhost
```

```bash
kubectl --context kind-homelab port-forward svc/kafka-cluster-single-node-portforward-0 30664:9094 -n kafka
kubectl --context kind-homelab port-forward svc/kafka-cluster-kafka-portforward-bootstrap 9094:9094 -n kafka

kcat -b localhost:9094 \
  -X security.protocol=SASL_PLAINTEXT \
  -X sasl.mechanism=SCRAM-SHA-512 \
  -X sasl.username=dante-kafka-user \
  -X sasl.password=qBD7sXygrJWuAfAZls8Uyr4qo26wPI9k \
  -L
Metadata for all topics (from broker 0: sasl_plaintext://localhost:30664/0):
 1 brokers:
  broker 0 at localhost:30664 (controller)
 1 topics:
  topic "dante-topic" with 10 partitions:
    partition 0, leader 0, replicas: 0, isrs: 0
    partition 1, leader 0, replicas: 0, isrs: 0
    partition 2, leader 0, replicas: 0, isrs: 0
    partition 3, leader 0, replicas: 0, isrs: 0
    partition 4, leader 0, replicas: 0, isrs: 0
    partition 5, leader 0, replicas: 0, isrs: 0
    partition 6, leader 0, replicas: 0, isrs: 0
    partition 7, leader 0, replicas: 0, isrs: 0
    partition 8, leader 0, replicas: 0, isrs: 0
    partition 9, leader 0, replicas: 0, isrs: 0
```

### Common: produce message to topic, consume from topic, consumer group

```bash
$  echo "Hello from kcat" | kcat -b localhost:9094 \
  -X security.protocol=SASL_PLAINTEXT \
  -X sasl.mechanism=SCRAM-SHA-512 \
  -X sasl.username=dante-kafka-user \
  -X sasl.password=qBD7sXygrJWuAfAZls8Uyr4qo26wPI9k \
  -P -t dante-topic

$  kcat -b localhost:9094 \
  -X security.protocol=SASL_PLAINTEXT \
  -X sasl.mechanism=SCRAM-SHA-512 \
  -X sasl.username=dante-kafka-user \
  -X sasl.password=qBD7sXygrJWuAfAZls8Uyr4qo26wPI9k \
  -C -t dante-topic -o beginning
% Reached end of topic dante-topic [0] at offset 0
world
Hello from kcat
% Reached end of topic dante-topic [3] at offset 0
new world1
% Reached end of topic dante-topic [5] at offset 0
% Reached end of topic dante-topic [6] at offset 0
new hello1
Hello
% Reached end of topic dante-topic [9] at offset 0
% Reached end of topic dante-topic [1] at offset 1
% Reached end of topic dante-topic [2] at offset 1
% Reached end of topic dante-topic [4] at offset 1
% Reached end of topic dante-topic [7] at offset 1
% Reached end of topic dante-topic [8] at offset 1
^C
```

### Advanced: replication, etc.

## Maintenence

- Backup / Restore
- Scaling
- Upgrade

---

## Articles

* [Zookeeper vs KRaft](#)

