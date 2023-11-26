locals {
  environment = "dev"

  tags = {
    Environment  = local.environment
  }
}
