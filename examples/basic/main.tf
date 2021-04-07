module "main" {
  providers = {
    github = github
  }
  source      = "../"
  name        = var.repository_name
  description = var.repository_description
  visibility  = "public"
}

module "main_with_key" {
  providers = {
    github = github
  }
  source      = "../"
  name        = var.repository_name
  description = var.repository_description
  visibility  = "public"
  deploy_keys = [{
    title     = "user key"
    key       = "/usr/etc/key/user.pub"
    read_only = false
  }]
}
