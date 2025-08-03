# external-secrets

|**Distro**|[external-secrets](https://external-secrets.io)|
|-|-|
|**Type**|kubernetes-operator|
|**Deploy**|helm-chart|
|**Docs**|[link](https://external-secrets.io/latest/)|
|**Backup**||
|**Scaling**||
|**CLI**||
|**UI**||

## TODO

- [x] use ExternalSecret to get secret from vault
- [~] PushSecret
- [ ] automate generating secrets

## Setup

### Hashicorp Vault

See [Vault](vault.md) docs for more details.

```yaml
apiVersion: external-secrets.io/v1beta1
kind: ClusterSecretStore
metadata:
  name: vault
spec:
  provider:
    vault:
      server: "http://vault.vault.svc.cluster.local:8200"
      path: "common"
      version: "v2"
      auth:
        tokenSecretRef:
          name: "vault-token"
          namespace: vault
          key: "token"
```

## Usecases

### Basic: get secret, add secret from secret store

- example `ExternalSecret` to read secret from secret store

```yaml
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
```

- example `PushSecret` from k8s to secret store

Usecase: some resource created in k8s store its secret in k8s-secret,
and we use PushSecret to save it in Vault and be accessible outside of k8s

```yaml
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
```

### Common: generate secrets, update secrets, rotate secrets

## Maintenence

- Backup / Restore
- Scaling
- Upgrade

---

## Articles
