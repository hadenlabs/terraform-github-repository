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

module "main" {
  source      = "git://github.com/hadenlabs/terraform-github-repository.git?ref=0.1.0"
  name        = var.repository_name
  description = var.repository_description
  visibility  = "public"
}