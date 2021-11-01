package faker

import (
	"crypto/rand"
	"fmt"

	"math/big"

	"github.com/lithammer/shortuuid/v3"

	"github.com/hadenlabs/terraform-github-repository/internal/errors"
)

type FakeRepository interface {
	Name() string        // => "Name Repository"
	Visibility() string  // => "Visibility Repository"
	Description() string // => "Description Repository"
}

type fakeRepository struct{}

func Repository() FakeRepository {
	return fakeRepository{}
}

var (
	name         = "testing"
	visibilities = []string{"public", "private"}
	descriptions = []string{"description 1", "description 2"}
)

func (n fakeRepository) Name() string {
	nameuuid := fmt.Sprintf("%s-%s", name, shortuuid.New())
	return nameuuid
}

func (n fakeRepository) Visibility() string {
	num, err := rand.Int(rand.Reader, big.NewInt(int64(len(visibilities))))
	if err != nil {
		panic(errors.New(errors.ErrorUnknown, err.Error()))
	}

	return visibilities[num.Int64()]
}

func (n fakeRepository) Description() string {
	num, err := rand.Int(rand.Reader, big.NewInt(int64(len(descriptions))))
	if err != nil {
		panic(errors.New(errors.ErrorUnknown, err.Error()))
	}
	return descriptions[num.Int64()]
}
