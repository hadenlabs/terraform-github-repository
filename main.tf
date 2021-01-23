resource "github_repository" "instance" {
  name        = var.name
  description = var.description
  visibility  = var.visibility

  has_issues   = true
  has_wiki     = true
  has_projects = true
}
