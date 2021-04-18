variable "name" {
  type        = string
  description = "The name of the repository."
}

variable "is_git_flow" {
  type        = bool
  description = "Git Flow - Github Flow"
  default     = false
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
  type        = map(any)
  description = "Configuration block for GitHub Pages"
  validation {
    condition     = can([for field in keys(try(var.pages, {})) : !contains(["branch", "path", "cname"], field)])
    error_message = "ERROR: Key not permitted."
  }
  default = {}
}

variable "default_branch" {
  type        = string
  description = "Name of the Default Branch of the Repository"
  default     = "develop"
}

variable "settings" {
  type        = map(any)
  description = "Create and manage settings."
  default     = {}
  validation {
    condition = can([for field in keys(try(var.settings, {})) : !contains([
      "auto_init", "has_issues", "has_wiki", "has_projects", "homepage_url", "is_template",
      "allow_merge_commit", "allow_squash_merge", "allow_rebase_merge", "delete_branch_on_merge",
    "gitignore_template", "license_template", "archived", "archive_on_destroy", "vulnerability_alerts"], field)])
    error_message = "ERROR: Key not permitted."
  }
}

variable "topics" {
  type        = list(string)
  description = "topics of project."
  default     = []
}

variable "template" {
  type        = map(string)
  description = "Template Repository to use when creating the Repository"
  validation {
    condition     = can([for field in keys(try(var.template, {})) : !contains(["owner", "repository", ], field)])
    error_message = "ERROR: Key not permitted."
  }
  default = {}
}

variable "collaborators" {
  type = list(object({
    username   = string
    permission = string
  }))

  description = "List of Collaborator Objects"
  default     = []
}

variable "files" {
  type = list(object({
    branch              = string
    file                = string
    content             = string
    commit_message      = string
    commit_author       = string
    commit_email        = string
    overwrite_on_create = bool
  }))
  description = "list files for repository"
  default     = []
}

variable "types" {
  type        = list(string)
  description = "types of project."
  default     = []
}

variable "add_labels_default" {
  type        = bool
  description = "add labels default"
  default     = true
}
