---
sidebar_position: 2
---

import ProgressBar from '@site/src/components/ProgressBar';

# Roadmap

## Tools requirements

1. deployed
2. basic usage
3. monitoring: dashboard
4. common usage
5. architecture
6. monitoring: understand metrics
7. maintenance: backup/restore
8. saas
9. maintenance: scaling/upgrade
10. monitoring: alerts
11. advanced usage
12. platform integration
13. maintenance: configure for low resources

---

## 0.1.0 self-hosted kubernetes cluster

**Infra requirements:**

- [x] localhosted cluster kind
- [x] kubernetes monitoring: node, dp, ds, sts, pv- (kind do not support)

**Platform & App-library requirements:**

- [x] common applicationset
- [x] basic helm appchart (cloud-dc-env)

**Tools requirements:**

1. deployed
2. basic usage
3. monitoring: (basic dashboard)

**Progress tools:**

- [x] **logging:** elasticsearch, kibana, fluent-bit
- [x] **metrics:** prometheus, grafana, alertmanager
- [ ] tracing
- [ ] :arrows_counterclockwise: postgresql: cloudnative-pg
    <ProgressBar steps={[
      { label: 'deploy', status: 'done' },
      { label: 'docs', status: 'done' },
      { label: 'monitoring', status: 'not-started' }
    ]}/>
- [ ] :arrows_counterclockwise: kafka: strimzi
- [ ] redis
- [ ] :arrows_counterclockwise: mongodb: community-operator
- [ ] clickhouse: altinity
- [ ] :arrows_counterclockwise: ingress: nginx
- [ ] service mesh: istio
- [ ] :arrows_counterclockwise: certificates: cert-manager
- [ ] :arrows_counterclockwise: secret storage: vault + external-secrets
- [ ] :arrows_counterclockwise: crossplane

## 0.2.0 self-hosted multi-cluster setup

**Infra requirements:**

- [ ] talos linux local multicluster setup

**Platform & App-library requirements:**

- [ ] argocd -- add cluster, appsets
- [ ] investigate argo teams and projects

**Tools requirements:**

4. common usage
5. architecture
6. monitoring: how to monitor
7. maintenance: backup/restore

**Progress tools:**

- [ ] cert-manager: vault-pki or letsencrypt
- [ ] observability: configure prom & alertmanager to common grafana
- [ ] ingress: nginx external-dns
- [ ] logs: configure fluent-bit to common elastic
- [ ] secrets: configure external-secrets to common vault
- [ ] service mesh: istio
- [ ] autoscaling: keda
- [ ] tools: reloader
- [ ] demo-app

## 0.3.0 common eks cluster

**Infra requirements:**

- [ ] aws eks: terrafrom, addons

**Tools requirements:**

8. saas
9. maintenance: scaling/upgrade
10. monitoring: alerts

## 0.4.0 staging eks cluster

**Infra requirements:**

- [ ] cluster-autoscaling: karpenter
- [ ] crossplane: eks provisioning

**Tools requirements:**

11. advanced usage

## 1.0.0 platform app-library

**Infra requirements:**

**Tools requirements:**

12. platform integration

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

## Ideas

- [ ] devcontainers
- [ ] investigate `KCL` for app-library
- [ ] kong as GatewayAPI
- [ ] loki
- [ ] victoriametrics
- [ ] tempo
- [ ] jaeger

---

## CI/CD

- [ ] private container registry
- [ ] a lib that can be reused by any cicd system: dagger
- [ ] jenkins / github actions / argo workflows

## Organization

- [ ] github org
- [ ] google org (sso: grafana, kibana)
- [ ] atlassian stack
