package test

import (
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestRepositoryBasicPublicSuccess(t *testing.T) {
	t.Parallel()

  const VISIBILITY string = "public"
  const REPOSITORY string = "test-repository"
  const DESCRIPTION string = "description"

	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: "repository-basic-public",
		Upgrade:      true,
		Vars: map[string]interface{}{
			"visibility": VISIBILITY,
			"name": REPOSITORY,
			"description": DESCRIPTION,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	outputRepositoryName := terraform.Output(t, terraformOptions, "repository_name")
	outputRepository := terraform.OutputMapOfObjects(t, terraformOptions, "instance")
  validateRepositoryName := strings.ReplaceAll(outputRepositoryName, "\"", "")
	assert.Equal(t, REPOSITORY, validateRepositoryName)
  assert.NotEmpty(t, outputRepository, outputRepository)
}
