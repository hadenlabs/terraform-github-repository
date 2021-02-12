resource "github_repository" "instance" {
  name        = var.name
  description = var.description
  visibility  = var.visibility

  has_issues   = true
  has_wiki     = true
  has_projects = true
}

# Add a deploy key
resource "github_repository_deploy_key" "instance" {
  count      = try(var.key, null) != null ? 1 : 0
  title      = var.name
  repository = github_repository.instance.name
  key        = file(var.key)
  read_only  = var.read_only
}
