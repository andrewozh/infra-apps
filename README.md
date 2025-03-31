# infra-apps

## prerequisits

* deploy `eks-common` using terragrunt in `[infra-base](https://github.com/andrewozh/infra-base)`
* or deploy local homelab using `$ make homelab`
* update-kubeconfig and use appropriate context

## Bootstrap

- [+] argocd chart (better)
- [+] olm + argocd

```bash
make init
```

## Architecture

### [~] common-cluster

- [x] basic helm appchart
- [x] ingress -- nginx
- [x] cert-manager -- local self-signed
- [x] secrets -- vault external-secrets
- [x] observability -- prom grafana alertmanager
- [~] logs -- fluent-bit elasticsearch kibana
  [!] (es & kibana restarts, fluentbit retries warns)
- [~] intercluster monitoring
  * [x] k8s:
      + nodes
      + dp
      + ds -- can't choose pod
      + sts
      ! pv -- kind do not support it
  * [x] elastic stack:
      + es
      ! kibana (broken subchart -- enabling metrics no result)
  * [x] fluentbit
  * [~] prometheus stack: prom, alertmanager, grafana
      + prom
      - grafana -- disabled
      - alertmanager -- disabled
  * [ ] ingress
  * [ ] vault + external-secrets + cert-manager
  * [ ] argocd

### [ ] staging cluster

- [ ] crossplane -- creating non-common eks (managed cloud resources dbs etc)
- [ ] argocd -- add cluster, appsets
- [ ] ingress -- nginx external-dns
- [ ] cert-manager -- vault-pki or letsencrypt
- [ ] observability -- configure prom & alertmanager to common grafana
- [ ] logs -- configure fluent-bit to common elastic
- [ ] secrets -- configure external-secrets to common vault
- [ ] service mesh -- istio
- [ ] autoscaling -- cluster-autoscaling keda
- [ ] databases -- postgres, kafka, redis, mongo, clickhouse
- [ ] tools -- reloader
- [ ] demo-app

## Argocd

- [ ] chart cloud-dc-env
- [ ] universal applicationset
- [ ] add clusters

## Ingress + cert-manager

- [x] nginx 
- [~] TLS via cert-manager (self-signed, letsencrypt, aws)
- [ ] external-dns
- [ ] istio as ingress
- [ ] kong

## Secrets

- [x] vault
- [x] external-secrets
- [ ] monitoring dash

## Monitoring

- [x] prometheus
- [x] grafana
- [~] grafana dashboards
- [ ] alertmanager
- [ ] victoriametrics
- [ ] tempo
- [ ] jaeger

## Loging

- [x] elasicseach
- [x] kibana
- [~] fluent-bit -- lightweight daemonset (pods stdout logs)
- [ ] loki

