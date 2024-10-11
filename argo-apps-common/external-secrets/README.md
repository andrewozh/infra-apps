# external-secrets

Reuirements:
- Vault

## TODO

- [x] use ExternalSecret to get secret from vault
- [ ] automate generating secrets
- [~] PushSecret

## example ExternalSecret

```bash
cat <<EOF | kubectl apply -f -
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: test
  namespace: default
spec:
  refreshInterval: 10m
  secretStoreRef:
    name: vault
    kind: ClusterSecretStore
  target:
    name: test
    creationPolicy: Owner
  dataFrom:
  - extract:
      key: "/test"
EOF
```

## exmple PushSecret

```bash
# cat <<EOF | kubectl apply -f -
apiVersion: external-secrets.io/v1alpha1
kind: PushSecret
metadata:
  name: pushsecret-example # Customisable
  namespace: default # Same of the SecretStores
spec:
  updatePolicy: Replace # Policy to overwrite existing secrets in the provider on sync
  deletionPolicy: Delete # the provider' secret will be deleted if the PushSecret is deleted
  refreshInterval: 10m # Refresh interval for which push secret will reconcile
  secretStoreRefs: # A list of secret stores to push secrets to
    - name: vault
      kind: ClusterSecretStore
  selector:
    secret:
      name: test # Source Kubernetes secret to be pushed
  template:
    metadata:
      annotations: { }
      labels: { }
    data:
      best-pokemon: "{{ .best-pokemon | toString | upper }} is the really best!"
    # Uses an existing template from configmap
    # Secret is fetched, merged and templated within the referenced configMap data
    # It does not update the configmap, it creates a secret with: data["alertmanager.yml"] = ...result...
    templateFrom:
      - configMap:
          name: application-config-tmpl
          items:
            - key: config.yml
  data:
    - conversionStrategy: None # Also supports the ReverseUnicode strategy
      match:
        secretKey: best-pokemon # Source Kubernetes secret key to be pushed
        remoteRef:
          remoteKey: my-first-parameter # Remote reference (where the secret is going to be pushed)
# EOF
```
