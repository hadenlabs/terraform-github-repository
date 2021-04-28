# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables.
# ---------------------------------------------------------------------------------------------------------------------

# GITHUB_ORGANIZATION
# GITHUB_TOKEN

# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# These variables must be set when using this module.
# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL VARIABLES
# These variables have defaults, but may be overridden.
# ---------------------------------------------------------------------------------------------------------------------

variable "visibility" {
  type        = string
  description = "type of visibility."
}

variable "name" {
  type        = string
  description = "The name of the repository."
}

variable "description" {
  type        = string
  description = "description of repository."
}

variable "settings" {
  type        = any
  description = "settings for github repository."
}

variable "is_git_flow" {
  type        = bool
  description = "Git Flow - Github Flow"
  default     = false
}

variable "add_labels_default" {
  type        = bool
  description = "add labels default"
  default     = false
}
