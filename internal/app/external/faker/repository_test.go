package faker

import (
	"testing"

	"strings"

	"github.com/stretchr/testify/assert"
)

func TestFakeRepositoryName(t *testing.T) {
	name := Repository().Name()
	namePrefix := strings.Split(name, "-")[0]
	assert.Contains(t, name, namePrefix, namePrefix)
}

func TestFakeRepositoryVisibility(t *testing.T) {
	assert.Contains(t, visibilities, Repository().Visibility())
}

func TestFakeRepositoryDescription(t *testing.T) {
	assert.Contains(t, descriptions, Repository().Description())
}
