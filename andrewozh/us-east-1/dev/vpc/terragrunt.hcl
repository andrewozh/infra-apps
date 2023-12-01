include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${dirname(find_in_parent_folders())}/_modules/vpc"
}

locals {
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  dependency_data = "${dirname(find_in_parent_folders("account.hcl"))}/_global/_global/_data"
}

dependency "data" {
  config_path = local.dependency_data
}

dependencies {
  paths = [
    local.dependency_data
  ]
}

inputs = {
  cidr            = "10.1.0.0/16"
  private_subnets = ["10.1.0.0/19", "10.1.32.0/19", "10.1.64.0/19"]
  public_subnets  = ["10.1.96.0/19", "10.1.128.0/19", "10.1.160.0/19"]

  env             = local.environment_vars.locals.environment
  azs             = dependency.data.outputs.availability_zones_names
  tags_all = merge(
    local.account_vars.locals.tags,
    local.region_vars.locals.tags,
    local.environment_vars.locals.tags
  )
}
