# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE A SECRET FOR ORGANIZATION
# This example will create a secrets for organization github.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ---------------------------------------------------------------------------------------------------------------------
# TEST
# We are creating a secrets with a single secret while specifying only the minimum required variables
# ---------------------------------------------------------------------------------------------------------------------

module "main" {
  source = "../.."

  name        = var.name
  description = var.description
  visibility  = var.visibility
}
