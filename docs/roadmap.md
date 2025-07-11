# Roadmap

## TODO

- [+] use [MkDocs](https://www.mkdocs.org) for docs like https://cloudnative-pg.io/documentation/1.26/
- [+] dedicated `roadmap` page
- [ ] private container registry
- [ ] talos linux local multicluster setup

## Platform

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

- [!] kind
- [ ] argocd -- add cluster, appsets
- [ ] ingress -- nginx external-dns
- [ ] cert-manager -- vault-pki or letsencrypt
- [ ] observability -- configure prom & alertmanager to common grafana
- [ ] logs -- configure fluent-bit to common elastic
- [ ] secrets -- configure external-secrets to common vault
- [ ] service mesh -- istio
- [ ] autoscaling -- cluster-autoscaling keda
- [~] databases
    + postgres -- cloudnative-pg
    + mongo -- mongodb-kubernetes-operator
    ~ kafka -- strimzi
    ~ clickhouse -- cloud, altinity
    ? redis
- [ ] tools -- reloader
- [~] crossplane -- creating non-common eks (managed cloud resources dbs etc)
- [ ] demo-app

## Argocd

- [x] chart cloud-dc-env
- [x] universal applicationset
- [ ] add clusters
- [ ] investigate argo teams and projects

## Ingress + cert-manager

- [x] ingress-nginx
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
- [ ] officieal operator: https://github.com/elastic/cloud-on-k8s
- [ ] loki
