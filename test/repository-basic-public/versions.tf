terraform {
  required_version = ">=0.13.0"
  required_providers {

    github = {
      source  = "integrations/github"
      version = ">=4.5.0"
    }

  }
}
