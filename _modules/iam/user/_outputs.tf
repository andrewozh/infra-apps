output "module" {
  description = "Module outputs"
  value       = module.iam_user
  sensitive   = true
}
