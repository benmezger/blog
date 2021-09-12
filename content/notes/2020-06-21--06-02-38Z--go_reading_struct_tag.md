+++
title = "Go reading struct tag"
author = ["Ben Mezger"]
date = 2020-06-21T03:02:00-03:00
slug = "go_reading_struct_tag"
tags = ["go", "programming"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [Go Programming]({{<relref "2020-05-31--15-31-36Z--go_programming.md#" >}})
    -   [Programming]({{<relref "2020-05-31--15-33-23Z--programming.md#" >}})
    -   [Code snippets]({{<relref "2020-05-31--17-28-55Z--code_snippets.md#" >}})

---

The following code reads a specific `struct` Tag by name.

```go
import (
	"reflect"
	"strings"
	"fmt"
)

type Profile struct {
	Id            int    `validate:"numeric" json:"id"`
	First         string `validate:"required" json:"first"`
	Last          string `validate:"required" json:"last"`
	Birth         string `validate:"required" json:"birth"`
	Sex           string `validate:"required" json:"sex"`
	MaritalStatus string `validate:"required" json:"marital_status"`
	Children      int    `validate:"numeric" json:"children"`
}

func GetStructFieldValidators(data interface{}) map[string][]string {
	v := reflect.ValueOf(data)
	t := reflect.TypeOf(data)

	validators := make(map[string][]string)
	for i := 0; i < v.NumField(); i++ {
		validators[strings.ToLower(v.Type().Field(i).Name)] = []string{t.Field(i).Tag.Get("validate")}
	}
	return validators
}

func main() {
	for k, v := range GetStructFieldValidators(Profile{}){
		fmt.Println(k, v)
	}
}
```

```text
sex [required]
maritalstatus [required]
children [numeric]
id [numeric]
first [required]
last [required]
birth [required]
```