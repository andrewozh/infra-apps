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

## Docs

```bash
pyenv activate 3.10.16
pip install mkdocs
mkdocs serve
```
