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

variable "key" {
  type        = string
  description = "filename pub for repository deploy key."
  default     = null
}

variable "read_only" {
  type        = bool
  description = "enabled read_only or no."
  default     = true
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
