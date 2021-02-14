output "instance" {
  description = "output instance repository"
  value       = github_repository.this
}

output "deploy_key" {
  description = "output instance deploy_key"
  value       = github_repository_deploy_key.this
}
