locals {
  account_name   = "andrewozh"
  aws_account_id = "066477712859"

  tags = {
    Account      = local.account_name
    Terragrunt   = "true"
  }
}
