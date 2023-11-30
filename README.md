# infra-base

Using `Terragrunt` to provision infra

* how to merge shared tags with specific tags?

## terragrunt

* to create working infra set `avoid_billing` to `false` in `account.hcl` and set to `true` afterwords
* run multiple modules at once (from dir with `account.hcl` to run all modules for account)

```
cd andrewozh
terragrunt run-all plan
```

### todo

* altinity

## helm

* replace with `jsonnet` or `cue`

## iam

### users

* list of users specified in `<account_name>/account.hcl`
* terragrunt module `<account_name>/_global/_global/iam_users/terragrunt.hcl`
* dynamically run terraform module in `_modules/iam/user/module.tf` for every specified user
* example how to import current manually created amdin user

```
cd andrewozh/_global/_global/iam_users
terragrunt init
terragrunt plan
terragrunt import 'module.iam_user["andrew.ozhegov"].aws_iam_user.this[0]' andrew.ozhegov
terragrunt import 'module.iam_user["andrew.ozhegov"].aws_iam_user_login_profile.this[0]' andrew.ozhegov
terragrunt apply
```

### groups

* configuring same as users
* required manual import of already existing group

```
terragrunt import 'module.iam_group["admin"].aws_iam_group.this[0]' admin
```

## vpc

* using `terraform-aws-modules/vpc/aws` because it's awesome
* vpc peering using `cloudposse/vpc-peering`

## eks

* cluster-autoscaler < `Karpetner` < AWS Fargate
* vertical-pod-autoscaler vs `keda` (same ot not?)
* Operator Lifecycle Manager
* external-secrets
* external-dns
* argocd
* terraform operator
* alertnamager

## secrets

* vault

## metrics

* victoria metrics
* prometheus-
* grafana

## logs

* loki
* elasticsearch

## databases

* kafka (managed - Amazon MSK, operator - strimzi)
* postgres
* redis
* mongo
* clickhouse
