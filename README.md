# infra-base

Using `Terragrunt` to provision infra

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
