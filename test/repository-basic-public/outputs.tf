output "instance" {
  description = "show instance module"
  value       = module.main.instance
}

output "repository_name" {
  description = "show name repository"
  value       = module.main.name
}

output "secrets" {
  description = "instance of the secrets."
  value       = module.main.secrets
}
