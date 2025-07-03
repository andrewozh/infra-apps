# Crossplane

## Clickhouse Cloud

## Setup terraform provider

```bash
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: clickhouse-cloud-secret
  namespace: crossplane
type: Opaque
data:
  clickhouse_org: $(echo "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" | base64)
  clickhouse_key: $(echo "xxxxxxxxxxxxxxxxxxxx" | base64)
  clickhouse_secret: $(echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" | base64)
EOF
```

## Create service

```yaml
apiVersion: clickhousecloud.crossplane.io/v1alpha1
kind: xService
metadata:
  name: clickhouse
spec:
  name: clickhouse
```
