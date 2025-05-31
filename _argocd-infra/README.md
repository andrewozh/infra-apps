# argocd

## TODO

- [ ] values order

## Requirements

* operator-sdk
* kubeconfig

## argocd-chart + appset-chart

```bash
make argocd
```


## OLM

```bash
make argocd-olm
```

1. deploy operator lifecycle manager itself

2. use olm to deploy argocd operator

3. use kustomization to
  - create argocd namespace
  - create argocd cluster
  - create `argocd` application

4. then argocd application deploys current `_argocd-infra` chart with:
  - ingress for itself
  - applicationsets
  - etc in templates

## [~] values order

cloud: kind aws gcp acure
account: main us eu
env: common dev stage preprod prod

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

