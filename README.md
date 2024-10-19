# infra-apps

## TODO

- [~] helm appchart
- [~] secrets -- vault external-secrets
- [~] observability -- prom vm grafana tempo jaeger alertmanager
- [ ] logs -- fluent elk loki
- [~] ingress -- nginx kong external-dns
- [ ] cert-manager
- [ ] service mesh -- istio
- [ ] autoscaling -- cluster-autoscaling keda
- [ ] databases -- postgres, kafka, redis, mongo, clickhouse
- [ ] crossplane -- creating non-common eks (managed cloud resources dbs etc)
- [ ] tools -- reloader
- [ ] demo-app

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

## Monitoring

- prometheus
- grafana
- alertmanager

## Loging

- fluent-bit -- lightweight daemonset (pods stdout logs)
- elasicseach
- kibana

