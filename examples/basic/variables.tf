variable "repository_name" {
  type        = string
  description = "The name of the repository."
}

variable "repository_description" {
  type        = string
  description = "description of repository."
  default     = ""
}

variable "github" {
  description = "vars for github"
  type = object({
    token        = string
    owner = string
  })
}
