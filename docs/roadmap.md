# Roadmap

## TODO

- [~] improved roadmap
  have list of all tools & technologies
  each platform version:
    infra meets global requirements
    all the tools meet the global requirement
  - [+] list infra global requirements
  - [+] list of platform versions by global requirements
  - [+] list of required technologies
  - [~] fill roadmap

## Ideas

- [ ] devcontainers
- [ ] investigate `KCL` for app-library
- [ ] kong as GatewayAPI
- [ ] loki
- [ ] victoriametrics
- [ ] tempo
- [ ] jaeger

---

## 0.1.0 self-hosted kubernetes cluster

Infra requirements:
- [+] localhosted cluster kind
- [+] kubernetes monitoring: node, dp, ds, sts, pv- (kind do not support)

Platform & App-library requirements:
- [+] common applicationset
- [+] basic helm appchart (cloud-dc-env)

Tools requirements:
- 1. deployed
- 2. basic usage
- 3. architecture
- 4. monitoring

Progress tools:
- [~] logging: elasticsearch, kibana, logstash/fluent-bit
    Description: localhost tls dns
    Status: 1.. ..
    Docs: ~
- [~] metrics: prometheus, grafana, alertmanager
- [ ] tracing
- [~] postgresql: cloudnative-pg
- [~] kafka: strimzi
- [ ] redis
- [~] mongodb: community-operator
- [ ] clickhouse: altinity
- [~] ingress: nginx
    Description: localhost tls dns
    Status: 1 4~ ..
    Docs: -
- [ ] service mesh: istio
- [~] certificates: cert-manager
    Description: local self-signed
    Status: 1 2 3~ ..
    Docs: ~
- [~] secret storage: vault + external-secrets
- [~] crossplane

## 0.2.0 self-hosted multi-cluster setup

Infra requirements:
- [ ] talos linux local multicluster setup

Platform & App-library requirements:
- [ ] argocd -- add cluster, appsets
- [ ] investigate argo teams and projects

Tools requirements:
- common usage
- maintenance: scaling/backup/restore/upgrade

Progress tools:
- [ ] cert-manager -- vault-pki or letsencrypt
- [ ] observability -- configure prom & alertmanager to common grafana
- [ ] ingress -- nginx external-dns
- [ ] logs -- configure fluent-bit to common elastic
- [ ] secrets -- configure external-secrets to common vault
- [ ] service mesh -- istio
- [ ] autoscaling -- keda
- [ ] tools -- reloader
- [ ] demo-app
  probes: startup, liveness, readiness
  databases: psql, kafka, mongo, clickhouse, redis
  logs, metrics, traces
  web-ui

## 0.3.0 common eks cluster

Infra requirements:
- [~] aws eks: terrafrom, addons

Tools requirements:
- saas

## 0.4.0 staging eks cluster

Infra requirements:
- [ ] cluster-autoscaling: karpenter
- [ ] crossplane:
  vpc, subnets, security groups, routes, vpc-peering
  eks, addons

Tools requirements:
- advanced usage

## 1.0.0 platform app-library

Infra requirements:

Tools requirements:
- platform integration

## Docs

- [+] use [MkDocs](https://www.mkdocs.org) for docs like https://cloudnative-pg.io/documentation/1.26/
- [+] dedicated `roadmap` page
- [~] fill docs with existing readmes
- [ ] github actions and reusable workflows markdown documentation generator
- [ ] docs Docusaurus & Github Pages https://www.youtube.com/watch?v=9iVNf0T09dE

---

## Goals

List of most valuable platform components:

* gitops and platform integration
* Crossplane provisioning cloud infra
* Cross-cluster observability, secrets management
* Simple tool maintenance guides (configure, scale, backup/restore, upgrade)

## Plans

- finops
- 3.0.0 organization
- 2.0.0 cicd

---

## CI/CD

- [ ] private container registry
- [ ] a lib that can be reused by any cicd system: dagger
- [ ] jenkins / github actions / argo workflows

## Organization

- [ ] github org
- [ ] google org
- [ ] atlassian stack
