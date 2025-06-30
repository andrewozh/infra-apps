# mongodb

## TODO

- [+] delpoy mongodb-kubernetes-operator
- [~] create a cluster
- [ ] connect to cluster (host, creds)
- [ ] create user
- [ ] create a database
- [ ] monitoring: note + grafana dashboards
- [ ] _chart integration
- [ ] backup/restore, scaling, upgrading

## Admin user secret

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
