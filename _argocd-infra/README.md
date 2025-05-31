# argocd

## TODO

- [x] values order
- [ ] exclude releases from clusters, bu placing `argo.yaml`

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

