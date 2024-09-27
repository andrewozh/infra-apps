# infra-apps

## prerequisits

* deploy `eks-common` using terragrunt in `[infra-base](https://github.com/andrewozh/infra-base)`
* or deploy local homelab using `$ make homelab`
* update-kubeconfig and use appropriate context

## init cluster

```bash
make init
```

# helm appchart

`<cloud>-<acc/dc>-<env>`
global
cloud
acc
env
cloud-acc
cloud-env
acc-env
cloud-acc-env

global.yaml
kind.yaml
main.yaml
common.yaml
kind-main.yaml
kind-common.yaml
main-common.yaml
kind-main-common.yaml

...

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
