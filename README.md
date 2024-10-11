# infra-apps

## TODO

- [~] helm appchart
- [~] secrets -- vault external-secrets
- [ ] observability -- prom vm grafana tempo (any other traces) alerts
- [ ] logs -- fluent elk loki
- [ ] ingress -- nginx kong external-dns
- [ ] autoscaling -- cluster-autoscaling keda
- [ ] databases -- postgres, kafka, redis, mongo, clickhouse
- [ ] crossplane -- creating non-common eks (managed cloud resources dbs etc)
- [ ] tools -- reloader

## prerequisits

* deploy `eks-common` using terragrunt in `[infra-base](https://github.com/andrewozh/infra-base)`
* or deploy local homelab using `$ make homelab`
* update-kubeconfig and use appropriate context

## Architecture (#TODO)

## Bootstrap

- olm
- argocd

```bash
make init
```

## Secrets

- vault
- external-secrets

