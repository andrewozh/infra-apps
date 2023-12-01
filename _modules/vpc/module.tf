module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = "${var.env}-vpc"

  enable_nat_gateway   = var.avoid_billing ? false : true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  cidr            = var.cidr
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  azs             = var.azs

  public_subnet_tags = {
    Name = "${var.env}-vpc-public"
  }

  private_subnet_tags = {
    Name = "${var.env}-vpc-private"
  }

  public_route_table_tags = {
    Name = "${var.env}-vpc-public"
  }

  private_route_table_tags = {
    Name = "${var.env}-vpc-private"
  }

  tags = merge(
    var.tags_all,
    {
      Name = "${var.env}-vpc"
    },
  )
}
