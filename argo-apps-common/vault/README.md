# Vault

## TODO

- [ ] TLS
- [ ] HA mode
- [ ] configurable backend (local, aws ssm, etc)

## init vault & temporary save unseal keys and root token

```bash
kubectl exec -n vault -ti vault-0 -- vault operator init > .secret
```

## manually unseal vault

```bash
while read -r line ; do
  KEY=$(echo "$line" | grep Unseal | awk '{print $4}')
  [ ! -z "$KEY" ] && kubectl exec -n vault -ti vault-0 -- vault operator unseal $KEY
done < .secret
```

## add secret with vault token

```yaml
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: vault-token
  namespace: vault
type: Opaque
data:
  token: $(echo -n 'xxx.XXXXXXXXXXXXXXXXXXXXXXXX' | base64)
EOF
```
