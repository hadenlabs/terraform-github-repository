package faker

import (
	"crypto/rand"
	"math/big"

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
	names        = []string{"test-repository", "other-repository"}
	visibilities = []string{"public", "private"}
	descriptions = []string{"description 1", "description 2"}
)

func (n fakeRepository) Name() string {
	num, err := rand.Int(rand.Reader, big.NewInt(int64(len(names))))
	if err != nil {
		panic(errors.New(errors.ErrorUnknown, err.Error()))
	}
	return names[num.Int64()]
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
