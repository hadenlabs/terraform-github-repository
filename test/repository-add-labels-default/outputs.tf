output "instance" {
  description = "show instance module"
  value       = module.main.instance
}

output "repository_name" {
  description = "show name repository"
  value       = module.main.name
}

output "labels" {
  description = "show labels repository"
  value       = module.main.labels
}
