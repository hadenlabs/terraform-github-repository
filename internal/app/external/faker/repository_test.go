package faker

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestFakeRepositoryName(t *testing.T) {
	assert.Contains(t, names, Repository().Name())
}

func TestFakeRepositoryVisibility(t *testing.T) {
	assert.Contains(t, visibilities, Repository().Visibility())
}

func TestFakeRepositoryDescription(t *testing.T) {
	assert.Contains(t, descriptions, Repository().Description())
}
