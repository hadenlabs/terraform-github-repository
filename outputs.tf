output "instance" {
  description = "output instance repository"
  value       = github_repository.this
}

output "name" {
  description = "output name repository"
  value       = github_repository.this.name
}

output "secrets" {
  description = "output instance github actions secrets"
  value       = github_actions_secret.this
}

output "deploy_key" {
  description = "output instance deploy_key"
  value       = github_repository_deploy_key.this
}

output "files" {
  description = "output instance github files"
  value       = github_repository_file.this
}

output "topics" {
  description = "output topics github repository"
  value       = local.output.topics
}

output "labels" {
  description = "output topics github repository"
  value       = local.output.labels
}
