output "instance" {
  description = "output instance repository"
  value       = github_repository.instance
}

output "deploy_key" {
  description = "output instance deploy_key"
  value       = github_repository_deploy_key.instance
}
