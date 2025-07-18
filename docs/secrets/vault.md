# Vault

|**Distro**|[Hashicorp Vault](https://developer.hashicorp.com/vault)|
|-|-|
|**Type**|kubernetes stateful app|
|**Deploy**|[helm-chart](https://developer.hashicorp.com/vault/docs/deploy/kubernetes/helm)|
|**Docs**|[link](https://developer.hashicorp.com/vault/docs)|
|**Backup**||
|**Scaling**||
|**CLI**||
|**UI**|web|

## TODO

- [ ] TLS
- [ ] HA mode
- [ ] configurable backend (local, aws ssm, etc)
- [ ] auto unseal

## Setup

Basic manual

- init vault & temporary save unseal keys and root token

```bash
kubectl exec -n vault -t vault-0 -- vault operator init > .secret
```

- manually unseal vault

```bash
while read -r line ; do
  KEY=$(echo "$line" | grep Unseal | awk '{print $4}')
  [ ! -z "$KEY" ] && kubectl exec -n vault -t vault-0 -- vault operator unseal $KEY
done < .secret
```

- add secret with vault token

```yaml
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: vault-token
  namespace: vault
type: Opaque
data:
  token: $(cat .secret | base64)
EOF
```

## Usecases

### Basic:
### Common:

## Maintenence

- Backup / Restore
- Scaling
- Upgrade

---

## Articles
