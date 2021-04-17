output "instance" {
  description = "show instance module"
  value       = module.main.instance
}

output "repository_name" {
  description = "show name repository"
  value       = module.main.name
}

output "topics" {
  description = "show list topics"
  value       = module.main.topics
}
