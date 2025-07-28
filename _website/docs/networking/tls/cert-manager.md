# cert-manager


||Self-hosted|SaaS|
|-|-|-|
|**Name**|[cert-manager](https://cert-manager.io)||
|**Type**|kubernetes-operator||
|**Deploy**|helm-chart||
|**Backup**|manual||
|**Scaling**|||
|**CLI**|[cmctl](https://cert-manager.io/docs/reference/cmctl/)||
|**UI**|||

## TODO

- [+] local self-signed
- [ ] letsencrypt
- [ ] cloudflare
- [ ] aws/gcp/azure
- [ ] vault-pki

## Architectire

* creates TLS certificates for workloads in your Kubernetes or OpenShift cluster and renews the certificates before they expire.
* can obtain certificates from a variety of certificate authorities, including: Let's Encrypt, HashiCorp Vault, Venafi and private PKI.
* private key and certificate are stored in a Kubernetes Secret which is mounted by an application Pod or used by an Ingress controller
* With csi-driver, csi-driver-spiffe, or istio-csr , the private key is generated on-demand, before the application starts up; the private key never leaves the node and it is not stored in a Kubernetes Secret.

## Usecases

### Basic: TLS for local ingress-nginx (self-signed CA)

self-signe CA cert for local use

```bash
openssl genrsa -out ca.key 4096
openssl req -new -x509 -sha256 -days 365 -key ca.key -out ca.crt
sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ca.crt
kubectl create secret generic -n vault ca --from-file=tls.crt=ca.crt --from-file=tls.key=ca.key
```

create a `ClusterIssuer` for self-signed CA

```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: cluster-issuer-nginx
spec:
  ca:
    secretName: ca
```

create a `Certificate` for `ingress-nginx`

```yaml
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: demo-cert
spec:
  secretName: demo-tls-secret
  issuerRef:
    name: cluster-issuer-nginx
    kind: ClusterIssuer
  dnsNames:
    - demo.home.lab
```

use secret created by `Certificate` in `Ingress` resource definition:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: demo
spec:
  # . . .
  tls:
  - hosts:
    - demo.home.lab
    secretName: demo-tls-secret
```

### Common: TLS for exposed ingress-nginx (Let's Encrypt)

### Advanced: secure Istio service mesh

## Monitoring

what metrics to pay attention on
alerts

## Maintenence

- Install / Deploy
- Backup / Restore

  https://cert-manager.io/v1.1-docs/tutorials/backup/

- Scaling
- Upgrade

## Patform integration

how this tool integrated into a platform
how to use it in a platform
how to debug

---

## Articles

* [Example article link](#)
