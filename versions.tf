terraform {
  required_version = ">= 0.13"

  required_providers {
    github = {
      source  = "integrations/github"
      version = ">=4.3.0"
    }

    local = {
      source  = "hashicorp/local"
      version = ">=1.3.0"
    }

  }
}