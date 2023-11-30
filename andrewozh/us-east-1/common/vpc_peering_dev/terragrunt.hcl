include "root" {
  path = find_in_parent_folders()
}

include "module" {
  path   = "${dirname(find_in_parent_folders())}/_modules/vpc/peering/terragrunt.hcl"
  expose = true
}

locals {
  dependency_vpc_this = "${dirname(find_in_parent_folders("env.hcl"))}/vpc"
  dependency_vpc_dev  = "${dirname(find_in_parent_folders("region.hcl"))}/dev/vpc"
}

dependency "vpc_this" {
  config_path = local.dependency_vpc_this
}

dependency "vpc_peer" {
  config_path = local.dependency_vpc_dev
}

dependencies {
  paths = [
    local.dependency_vpc_this,
    local.dependency_vpc_dev
  ]
}

inputs = {
  requestor_vpc_id = dependency.vpc_this.outputs.vpc_id
  acceptor_vpc_id  = dependency.vpc_peer.outputs.vpc_id
}
