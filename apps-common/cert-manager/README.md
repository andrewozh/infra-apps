# cert-manager

## TODO

- [+] local self-signed
- [ ] letsencrypt
- [ ] cloudflare
- [ ] aws/gcp/azure
- [ ] vault-pki

## [+] self-signed CA for local use

```bash
openssl genrsa -out ca.key 4096
openssl req -new -x509 -sha256 -days 365 -key ca.key -out ca.crt
```

```bash
sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ca.crt
```

```bash
kubectl create secret generic -n vault ca --from-file=tls.crt=ca.crt --from-file=tls.key=ca.key
```
