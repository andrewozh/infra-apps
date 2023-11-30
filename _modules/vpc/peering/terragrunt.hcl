terraform {
  source = "${local.base_source_url}?version=1.0.0"
}

locals {
  base_source_url = "tfr:///cloudposse/vpc-peering/aws"

  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  tags_all = merge(
   local.account_vars.locals.tags,
   local.region_vars.locals.tags,
   local.environment_vars.locals.tags
  )
}

inputs = {
  auto_accept                                  = true
  requestor_allow_remote_vpc_dns_resolution    = true
  acceptor_allow_remote_vpc_dns_resolruntution = true

  tags = local.tags_all
}
