package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"

	"github.com/hadenlabs/terraform-github-repository/internal/app/external/faker"
)

func TestGitflowWithTemplatesSuccess(t *testing.T) {
	t.Parallel()

	name := faker.Repository().Name()
	description := faker.Repository().Description()
	visibility := faker.Repository().Visibility()
	isGitFlow := false
	settings := map[string]interface{}{
		"auto_init": true,
		"template": map[string]string{
			"owner":      "hadenlabs",
			"repository": "terraform-module-template",
		},
	}

	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: "repository-gitflow-with-templates",
		Upgrade:      true,
		Vars: map[string]interface{}{
			"description": description,
			"is_git_flow": isGitFlow,
			"name":        name,
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
