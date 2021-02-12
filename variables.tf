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
