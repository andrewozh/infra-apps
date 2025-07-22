# Platform

## Cloud

- how to setup terragrunt

## Kubernetes

- picture of cluster arch
- kubernetes bootstrap: local / managed, addons
- how to cluster upgrade

### Local Talos Setup

- run 2 local clusters
- configure ip routing between local clusters
- local dns manager:
  look for new services in cluster and add them to local dns
  also add local services to another cluster dns (cross-cluster dns resolving)

## GitOps

### ArgoCD

- argocd appset schema
- how to setup argocd

- [?] Split applications (charts) and releases
  we have a single directory for apps (charts)
  and we have a separate directory for releases
  each release refers to a chart
  also each release keep current values folder structure for sophisticated overrides

### Helm library

- explanation of helm lib

### Helm carts

#### How to upgrade helm chart

```bash
$  cat apps-common/kube-prometheus-stack/Chart.yaml
apiVersion: v1
appVersion: "1.0"
description: A virtual chart for kube-prometheus-stack
name: prom-stack
version: 0.1.0
dependencies:
  - name: kube-prometheus-stack
    version: "65.1.1"
    repository: https://prometheus-community.github.io/helm-charts
  - name: chart
    version: 0.1.0
    repository: file://../../_chart

# check for a new version of a helm chart
$  helm repo add kube-prometheus-stack https://prometheus-community.github.io/helm-charts
"kube-prometheus-stack" already exists with the same configuration, skipping
$  helm search repo kube-prometheus-stack/kube-prometheus-stack
NAME                                            CHART VERSION   APP VERSION     DESCRIPTION
kube-prometheus-stack/kube-prometheus-stack     72.8.0          v0.82.2         kube-prometheus-stack collects Kubernetes manif...

# update chart version
$ yq eval ' (.dependencies[] | select(.name == "kube-prometheus-stack") .version) = "72.8.0" ' -i  apps-common/kube-prometheus-stack/Chart.yaml

# update chart values.yaml
$ helm show values kube-prometheus-stack/kube-prometheus-stack --version 72.8.0 > apps-common/kube-prometheus-stack/values.yaml

# commit changes
$ git add apps-common/kube-prometheus-stack/*
$ git commit -m "upgrade kube-prometheus-stack chart to 72.8.0"
```
