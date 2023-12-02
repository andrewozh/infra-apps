data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = "vpc-${var.env}"

  enable_nat_gateway   = var.avoid_billing ? false : true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  cidr            = var.cidr
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  azs             = data.aws_availability_zones.available.names

  public_subnet_tags = {
    Name = "sn-${var.env}-public"
  }

  private_subnet_tags = {
    Name = "sn-${var.env}-private"
  }

  public_route_table_tags = {
    Name = "rt-${var.env}-public"
  }

  private_route_table_tags = {
    Name = "rt-${var.env}-private"
  }

  tags = merge(
    var.tags_all,
    {
      Name = "vpc-${var.env}"
    },
  )
}
