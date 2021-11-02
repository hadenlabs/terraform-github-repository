package test

import (
	"testing"

	"github.com/hadenlabs/terraform-github-repository/config"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"

	"github.com/hadenlabs/terraform-github-repository/internal/app/external/faker"
	"github.com/hadenlabs/terraform-github-repository/internal/common/log"
)

func TestBranchProtectionSuccess(t *testing.T) {
	t.Parallel()
	conf := config.Must()
	logger := log.Factory(*conf)

	repository := faker.Repository().Name()
	description := faker.Repository().Description()
	visibility := config.VisibilityPublic
	branchProtection := map[string]interface{}{
		"develop": map[string]interface{}{
			"enforce_admins":  true,
			"allow_deletions": false,
		},
	}

	logger.Debugf(
		"values for test terraform-github-repository is",
		"repository", repository,
	)

	settings := map[string]interface{}{
		"auto_init": true,
	}

	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: "repository-branch-protection",
		Upgrade:      true,
		Vars: map[string]interface{}{
			"name":              repository,
			"description":       description,
			"settings":          settings,
			"visibility":        visibility,
			"branch_protection": branchProtection,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)
	outputRepository := terraform.Output(t, terraformOptions, "instance")
	assert.NotEmpty(t, outputRepository, outputRepository)
}
