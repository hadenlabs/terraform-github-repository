package faker

import (
	"reflect"

	fakerTag "github.com/bxcodec/faker/v3"
)

func Generator() {
	_ = fakerTag.AddProvider("repositoryNameFaker", func(v reflect.Value) (interface{}, error) {
		return Repository().Name(), nil
	})
}
