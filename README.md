# infra-apps

## prerequisits

* deploy `eks-common` using terragrunt in `[infra-base](https://github.com/andrewozh/infra-base)`
* or deploy local homelab using `$ make homelab`
* update-kubeconfig and use appropriate context

## init cluster

```bash
make init
```

- [ ] appset common
- [ ] argocd app of appsets
