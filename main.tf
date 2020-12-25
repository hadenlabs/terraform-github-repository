terraform {
  required_version = ">=0.13.0"
  required_providers {
    github = {
      source  = "hashicorp/github"
      version = ">=2.9.2"
    }

    template = {
      source  = "hashicorp/template"
      version = ">=1.0.0"
    }

    null = {
      source  = "hashicorp/null"
      version = ">=0.1.0"
    }

    local = {
      source  = "hashicorp/local"
      version = ">=1.3.0"
    }

  }
}

provider "github" {}

provider "template" {}

provider "null" {}

provider "local" {}

resource "github_repository" "instance" {
  name        = var.name
  description = var.description
  visibility  = var.visibility

  has_issues   = true
  has_wiki     = true
  has_projects = true
}
