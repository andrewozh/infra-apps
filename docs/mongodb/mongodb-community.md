# MongoDB Community

|**Distro**|[Mongodb Controllers for Kubernetes](https://github.com/mongodb/mongodb-kubernetes)|
|-|-|
|**Type**|kubernetes-operator|
|**Deploy**|helm-chart|
|**Docs**|[link](https://github.com/mongodb/mongodb-kubernetes/tree/master/docs/mongodbcommunity)|
|**Backup**||
|**Scaling**||
|**CLI**||
|**UI**||

## TODO

- [+] delpoy mongodb-kubernetes-operator
- [+] create a cluster
- [+] connect to cluster (host, creds)
- [+] create user
- [+] create a database
- [ ] monitoring: note + grafana dashboards
- [ ] _chart integration
- [ ] backup/restore, scaling, upgrading

## Deployment

- deployment explained

## Usecases

### Basic: create db, create user, connect, etc.

- Connect

Port-forward service `mongodb-svc` to localhost

```bash
mongosh "mongodb://test2-user:admin123@127.0.0.1:27017/test2"
```

- Databases

There is no database creation, just create user and assign a `dbOwner` role to it (example forward)

- Create user

```bash
cat <<EOF | kubectl apply -f -
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
  - name: test-user
    db: test
    passwordSecretRef:
      name: mongo-admin-user
    roles:
    - name: dbOwner
      db: test
    scramCredentialsSecretName: test-scram
```

### Common: write data, read data, replication, etc.

## Maintenence

- Backup / Restore
- Scaling
- Upgrade

---

## Articles
