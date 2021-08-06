package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"

	"github.com/hadenlabs/terraform-github-repository/internal/app/external/faker"
)

func TestTopicsBasicSuccess(t *testing.T) {
	t.Parallel()

	description := faker.Repository().Description()
	repository := faker.Repository().Name()
	visibility := faker.Repository().Visibility()
	types := []string{"flask"}
	topics := []string{"python"}

	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: "repository-topics-basic",
		Upgrade:      true,
		Vars: map[string]interface{}{
			"visibility":  visibility,
			"name":        repository,
			"description": description,
			"types":       types,
			"topics":      topics,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	outputTopics := terraform.OutputRequired(t, terraformOptions, "topics")
	// Verify we're getting back the outputs we expect
	assert.NotEmpty(t, outputTopics, outputTopics)
}
