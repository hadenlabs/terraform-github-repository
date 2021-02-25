variable "name" {
  type        = string
  description = "The name of the repository."
}

variable "description" {
  type        = string
  description = "The description of the repository."
}

variable "visibility" {
  type        = string
  description = "The visibility of the repository private or public."
  default     = "private"
}

variable "deploy_keys" {
  type = list(object({
    title     = string
    key       = string
    read_only = bool
  }))
  description = "The name of repositories."
  default     = []
}

variable "secrets" {
  type        = map(any)
  description = "secrets for repository"
  default     = {}
}

variable "pages" {
  type = map(object({
    branch = string
    path   = string
    cname  = string
  }))
  description = "Configuratin block for GitHub Pages"
  default     = {}
}

variable "default_branch" {
  type        = string
  description = "Name of the Default Branch of the Repository"
  default     = "develop"
}

# github_repository
variable "settings" {
  description = "Create and manage settings."
  type = map(object({
    homepage_url           = string
    has_issues             = bool
    has_projects           = bool
    has_wiki               = bool
    is_template            = bool
    allow_merge_commit     = bool
    allow_squash_merge     = bool
    allow_rebase_merge     = bool
    delete_branch_on_merge = bool
    auto_init              = bool
    gitignore_template     = string
    license_template       = string
    archived               = bool
    archive_on_destroy     = bool
    vulnerability_alerts   = bool
    topics                 = list(string)
  }))
  default = {}
}
