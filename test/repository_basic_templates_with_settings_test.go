package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestBasicTemplatesWithSettingsSuccess(t *testing.T) {
	t.Parallel()

	visibility := "public"
	repository := "test-repository"
	description := "description"
	settings := map[string]interface{}{
		"auto_init": true,
		"template": map[string]string{
			"owner":      "hadenlabs",
			"repository": "base-template",
		},
	}

	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: "repository-basic-templates-with-settings",
		Upgrade:      true,
		Vars: map[string]interface{}{
			"description": description,
			"name":        repository,
			"settings":    settings,
			"visibility":  visibility,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)
	outputRepository := terraform.Output(t, terraformOptions, "instance")
	assert.NotEmpty(t, outputRepository, outputRepository)
}
