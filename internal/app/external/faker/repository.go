package faker

import (
	"math/rand"
	"time"

)

type FakeRepository interface {
	Name() string // => "Name Repository"
	Visibility() string // => "Visibility Repository"
	Description() string // => "Visibility Repository"
}

type fakeRepository struct{}

func Repository() FakeRepository {
	return fakeRepository{}
}

var (
	names = []string{"test-repository", "other-repository"}
	visibilities = []string{"public", "private"}
	descriptions = []string{"description 1", "description 2"}
)

func (n fakeRepository) Name() string {
	rand.Seed(time.Now().UnixNano())
	return names[rand.Intn(len(names))]
}

func (n fakeRepository) Visibility() string {
	rand.Seed(time.Now().UnixNano())
	return visibilities[rand.Intn(len(visibilities))]
}

func (n fakeRepository) Description() string {
	rand.Seed(time.Now().UnixNano())
	return descriptions[rand.Intn(len(descriptions))]
}
