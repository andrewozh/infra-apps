# Tools

## Deployment method priorities

1   SaaS
2   k8s operator (olm, self-managed)
3   helm-chart
3.1 official
3.2 community
4.  self-managed

## management

* setup and configuration: no clickops (ability to redeploy from scratch),
* usability: gitops by infra-platform tools (values.yaml)
* monitoring
* maintenance: backup/restore, upgrade, scaling

## crossplane

## keda

## reloader

## sandbox

kubectl run dev-sandbox --image=ubuntu --restart=Always --command -- sleep infinity
