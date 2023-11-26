output "module" {
  description = "Module outputs"
  value       = module.iam_group
  sensitive   = true
}
