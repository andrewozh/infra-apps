include "root" {
  path = find_in_parent_folders()
}

include "module" {
  path   = "${dirname(find_in_parent_folders())}/_modules/vpc.hcl"
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
  cidr            = "10.0.0.0/16"
  private_subnets = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]
  public_subnets  = ["10.0.96.0/19", "10.0.128.0/19", "10.0.160.0/19"]
  azs             = dependency.data.outputs.availability_zones_names
}
