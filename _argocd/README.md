# argocd chart

## TODO

- [~] fix issue with no crd for templates
- [ ] values order

## [~] bootstrap

```bash
kubectl create ns argocd
helmfile apply
```

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

