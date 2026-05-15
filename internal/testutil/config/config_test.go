package config

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"

	coreconfig "github.com/hadenlabs/terraform-github-repository/config"
)

func TestConfigLoadEnvSuccess(t *testing.T) {
	conf, err := LoadEnvWithFilename("./mocking/config.env")

	require.NoError(t, err)

	assert.NotNil(t, conf)
	assert.IsType(t, &coreconfig.Config{}, conf)
	assert.Equal(t, "zap", conf.Log.Provider)
}

func TestConfigMustLoadEnvWithPanic(t *testing.T) {
	assert.Panics(t, func() {
		MustLoadEnvWithFilename("./mocking/notfound.env")
	})
}

func TestConfigLoadEnvFailed(t *testing.T) {
	conf, err := LoadEnvWithFilename("./mocking/notfound.env")

	require.Error(t, err)

	assert.Nil(t, conf)
}
