package test

import (
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"

	"github.com/hadenlabs/terraform-github-repository/internal/app/external/faker"
)

func TestRepositoryBasicPublicSuccess(t *testing.T) {
	t.Parallel()

	repository := faker.Repository().Name()
	description := faker.Repository().Description()
	visibility := "public"

	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: "repository-basic-public",
		Upgrade:      true,
		Vars: map[string]interface{}{
			"name":        repository,
			"visibility":  visibility,
			"description": description,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	outputRepositoryName := terraform.Output(t, terraformOptions, "repository_name")
	outputRepository := terraform.OutputMapOfObjects(t, terraformOptions, "instance")
	validateRepositoryName := strings.ReplaceAll(outputRepositoryName, "\"", "")
	assert.Equal(t, repository, validateRepositoryName)
	assert.NotEmpty(t, outputRepository, outputRepository)
}
