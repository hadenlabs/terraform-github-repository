package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTopicsBasicSuccess(t *testing.T) {
	t.Parallel()

	visibility := "public"
	repository := "test-repository"
	description := "description"
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
