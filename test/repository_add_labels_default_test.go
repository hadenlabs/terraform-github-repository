package test

import (
	"testing"

	"github.com/hadenlabs/terraform-github-repository/config"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"

	"github.com/hadenlabs/terraform-github-repository/internal/app/external/faker"
	"github.com/hadenlabs/terraform-github-repository/internal/common/log"
)

func TestAddLabelsDefaultSuccess(t *testing.T) {
	t.Parallel()

	conf := config.Must()
	logger := log.Factory(*conf)

	repositoryName := faker.Repository().Name()
	description := faker.Repository().Description()
	visibility := config.VisibilityPrivate
	addLabelsDefault := true
	logger.Debugf(
		"values for test terraform-github-repository is",
		"repository", repositoryName,
	)

	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: "repository-add-labels-default",
		Upgrade:      true,
		Vars: map[string]interface{}{
			"name":               repositoryName,
			"visibility":         visibility,
			"add_labels_default": addLabelsDefault,
			"description":        description,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)
	outputRepository := terraform.Output(t, terraformOptions, "instance")
	outputLabels := terraform.Output(t, terraformOptions, "labels")
	assert.NotEmpty(t, outputRepository, outputRepository)
	assert.NotEmpty(t, outputLabels, outputLabels)
}
