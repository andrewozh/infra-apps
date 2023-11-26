data "aws_availability_zones" "available" {}

output "availability_zones_names" {
  value = data.aws_availability_zones.available.names
}
