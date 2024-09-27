# argocd

Requirements:

* operator-sdk
* kubeconfig

## steps

```bash
make
```

1. deploy operator lifecycle manager itself

2. use olm to deploy argocd operator

3. use kustomization to
  - create argocd namespace
  - create argocd cluster
  - create `argocd` application

4. then argocd application deploys current `_argocd` chart with:
  - ingress for itself
  - applicationsets
  - etc in templates
