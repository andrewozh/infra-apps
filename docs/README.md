# infra-platform

## TODO

- [ ] use [MkDocs](https://www.mkdocs.org) for docs like cloudnative-pg.io

## Schema

- picture of cluster arch
- explanation of helm lib
- argocd appset schema

---

## Platform

- kubernetes
  bootstrap: local / managed, addons
- how to setup terragrunt
- how to setup argocd
- tools deployment rules:
  1 saas
  2 k8s operator: olm, self-managed
  3 helm-chart: official, community, self-managed
- tool management
    setup and configuration: no clickops (ability to redeploy from scratch),
    usability: gitops by infra-platform tools (values.yaml)
    monitoring
    maintenance: backup/restore, upgrade, scaling
- crossplane

---

## Maintenence

- how to cluster upgrade
...

---

## Networking

ingress, external-dns, cert-manager

---

## Security

vault, external-secrets

---

## Observability

### Logs

fluent-bit, elasticsearch, kibana

### Monitoring

prometheus, grafana, alertmanager

### Tracing

---

## Databases

### postgres

- self-hosted / saas
- how to manage (create db, users, perms etc... +automated management)
- automated backups
- how to backup/restore
- scaling
- upgrading
- how to monitor

### kafka
### redis
### mongo
### clickhouse
