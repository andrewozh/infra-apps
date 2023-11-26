data "aws_caller_identity" "current" {}

output "caller_identity_arn" {
  value = data.aws_caller_identity.current.arn
}
