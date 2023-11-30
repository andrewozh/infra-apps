terraform {
  source = "${local.base_source_url}?version=5.1.2"
}

locals {
  base_source_url = "tfr:///terraform-aws-modules/vpc/aws"

  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  env = local.environment_vars.locals.environment

  tags_all = merge(
    local.account_vars.locals.tags,
    local.region_vars.locals.tags,
    local.environment_vars.locals.tags
  )
}

inputs = {
  name = "${local.env}-vpc"

  enable_nat_gateway   = false
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = merge(
    local.tags_all,
    {
      Name = "${local.env}-vpc"
    },
  )

  public_subnet_tags = {
    Name = "${local.env}-vpc-public"
  }

  private_subnet_tags = {
    Name = "${local.env}-vpc-private"
  }

  public_route_table_tags = {
    Name = "${local.env}-vpc-public"
  }

  private_route_table_tags = {
    Name = "${local.env}-vpc-private"
  }
}
