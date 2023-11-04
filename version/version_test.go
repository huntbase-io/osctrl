package version

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestOsqueryVersion(t *testing.T) {
	assert.Equal(t, "5.9.1", OsqueryVersion)
}

func TestOsctrlVersion(t *testing.T) {
	assert.Equal(t, "0.3.2", OsctrlVersion)
}
