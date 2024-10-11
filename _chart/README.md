# helm appchart

## TODO

- [ ] ingress

## values order

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

