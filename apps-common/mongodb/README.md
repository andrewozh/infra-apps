# mongodb

https://github.com/mongodb/mongodb-kubernetes/tree/master/docs/mongodbcommunity

## TODO

- [+] delpoy mongodb-kubernetes-operator
- [+] create a cluster
- [+] connect to cluster (host, creds)
- [+] create user
- [+] create a database
- [ ] monitoring: note + grafana dashboards
- [ ] _chart integration
- [ ] backup/restore, scaling, upgrading

## Connect

Port-forward service `mongodb-svc` to localhost

```bash
mongosh "mongodb://test2-user:admin123@127.0.0.1:27017/test2"
```

## Databases

There is no database creation, just create user and assign a dbOwner to it

## Create user

```bash
cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: Secret
metadata:
  name: mongo-admin-user
  namespace: mongo
type: Opaque
stringData:
  password: admin123
EOF
```
```

```yaml
apiVersion: mongodbcommunity.mongodb.com/v1
kind: MongoDBCommunity
metadata:
  name: mongodb
spec:
  members: 1
  type: ReplicaSet
  version: "8.0.11"
  security:
    authentication:
      modes:
      - SCRAM
  users:
  - name: admin-user
    db: admin
    passwordSecretRef:
      name: mongo-admin-user
    roles:
    - name: clusterAdmin
      db: admin
    - name: userAdminAnyDatabase
      db: admin
    scramCredentialsSecretName: my-scram
```
```
