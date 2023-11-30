include "root" {
  path = find_in_parent_folders()
}

include "module" {
  path   = "${dirname(find_in_parent_folders())}/_modules/vpc/terragrunt.hcl"
  expose = true
}

locals {
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
  azs             = dependency.data.outputs.availability_zones_names
}
