# Crossplane Clickhouse Cloud

## TODO

- [ ] add all available settings to XRD
- [ ] automate creation of DB and Users (operator)

## KNOWN ISSUES

- On `Free Tier` with provider veriosn 3.3.3 can't update already created service

  ```
  Error: Error setting service backup configuration

  with module.dev.module.clickhouse.clickhouse_service.service,
  on dev/clickhouse/main.tf line 1, in resource "clickhouse_service" "service":
   1: resource "clickhouse_service" "service" {

  Could not update service backup settings, unexpected error: status: 400,
  body:
  {"requestId":"90ab9fdd-4446-4d44-a9fe-aeecc29af7de","error":"BAD_REQUEST:
  cannot update backup configuration for development tier
  service","status":400}
  ```

  Related GitHub issue: https://github.com/ClickHouse/terraform-provider-clickhouse/issues/167

## Setup terraform provider

```bash
cat <<EOF > .secret_clickhouse
clickhouse_org: $(echo "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" | base64)
clickhouse_key: $(echo "xxxxxxxxxxxxxxxxxxxx" | base64)
clickhouse_secret: $(echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" | base64)
EOF
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: clickhouse-cloud-secret
  namespace: crossplane
type: Opaque
data:
  creds.auto.tfvars: $(cat .secret_clickhouse | base64)
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
