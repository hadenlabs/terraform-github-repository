package test

import (
	"strings"
	"testing"

	"github.com/hadenlabs/terraform-github-repository/config"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"

	"github.com/hadenlabs/terraform-github-repository/internal/app/external/faker"
	"github.com/hadenlabs/terraform-github-repository/internal/common/log"
)

func TestRepositoryBasicPublicSuccess(t *testing.T) {
	t.Parallel()

	conf := config.Must()
	logger := log.Factory(*conf)

	repository := faker.Repository().Name()
	description := faker.Repository().Description()
	visibility := config.VisibilityPublic
	logger.Debugf(
		"values for test terraform-github-repository is",
		"repository", repository,
	)

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
