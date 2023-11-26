locals {
  account_name   = "andrewozh"
  aws_account_id = "066477712859"

  users = [
    {
      name = "andrew.ozhegov"
      groups = ["admin"]
    },
    {
      name = "jane.doe"
      groups = ["dev"]
    }
  ]

  tags = {
    Account      = local.account_name
    Terragrunt   = "true"
  }
}
