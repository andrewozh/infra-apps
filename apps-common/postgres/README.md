# postgres

## TODO

- [+] create a cluster
- [+] connect to cluster (host, creds)
- [+] create roles
- [~] create a database
- [ ] monitoring
- [ ] external-secrets integrations (automation of password management)
- [ ] _chart integration

## [+] Connect

```bash
# creds in secret `postgres-cluster-superuser`
export PGPASSWORD=$(kubectl get secret postgres-cluster-superuser -n postgres -o jsonpath='{.data.password}' | base64 -d)
# do port-forward service `postgres-cluster-rw` to localhost
kubectl port-forward svc/postgres-cluster-rw -n portgres 5432:5432
# connect
psql -h localhost -p 5432 -U postgres -d postgres
```

## [+] Create Roles

https://cloudnative-pg.io/documentation/1.26/declarative_role_management/

```bash
cat <<EOF | kubectl apply -f -
apiVersion: v1
data:
  username: $(echo -n "dante" | base64)
  password: $(echo -n "dante" | base64)
kind: Secret
metadata:
  name: psql-role-dante
  namespace: postgres
  labels:
    cnpg.io/reload: "true"
type: kubernetes.io/basic-auth
EOF
```

```yaml
cluster:
  managed:
    roles:
    - name: app
      createdb: true
      login: true
    - name: dante
      ensure: present
      comment: my database-side comment
      login: true
      superuser: false
      createdb: true
      createrole: false
      inherit: false
      replication: false
      bypassrls: false
      connectionLimit: 4
      validUntil: "2053-04-12T15:04:05Z"
      inRoles:
        - pg_monitor
        - pg_signal_backend
      passwordSecret:
        name: psql-role-dante
```

## [~] Create Database

https://cloudnative-pg.io/documentation/1.26/declarative_database_management/#postgresql-database-management

```bash
cat <<EOF | kubectl apply -f -
apiVersion: postgresql.cnpg.io/v1
kind: Database
metadata:
  name: psql-db-postgres-cluster-dante
  namespace: postgres
spec:
  databaseReclaimPolicy: delete
  name: dante
  owner: postgres
  cluster:
    name: postgres-cluster
  schemas:
  - name: public
    owner: dante
  extensions:
  - name: bloom
    ensure: present
EOF
```
