package utils

import (
	"reflect"
	"testing"
	"github.com/bmizerany/assert"
	"fmt"
)

type forTestStruct struct {
	name   string
	age    int
	values int64
}
var sayTestStruct interface{
	SayName()
	SayAge()
	SayValues()
}

func (f *forTestStruct) SayName()  {
	fmt.Println("Hi, I am %s you can call me on %s\n", f.name)
}

func (f *forTestStruct) SayAge()  {
	fmt.Println("Hi, I am %s you can call me on %s\n", f.age)
}

func (f *forTestStruct) SayValues()  {
	fmt.Println("Hi, I am %s you can call me on %s\n", f.values)
}

func TestPrintStruct(t *testing.T) {
	pS := forTestStruct{name:"my", age:2, values:200}
	iS := forTestStruct{name:"mine", age:8, values:100}
	iS.SayAge()
	pS.SayAge()
	PrintStruct(reflect.TypeOf(pS), reflect.ValueOf(pS), 1)
	assert.Equal(t, nil, nil)
}

func TestPrintArraySlice(t *testing.T) {
	type args struct {
		v  reflect.Value
		pc int
	}
	tests := []struct {
		name string
		args args
	}{
	// TODO: Add test cases.
	}
	for _, tt := range tests {
		PrintArraySlice(tt.args.v, tt.args.pc)
	}
}

func TestPrintMap(t *testing.T) {
	type args struct {
		v  reflect.Value
		pc int
	}
	tests := []struct {
		name string
		args args
	}{
	// TODO: Add test cases.
	}
	for _, tt := range tests {
		PrintMap(tt.args.v, tt.args.pc)
	}
}

func TestPrintVar(t *testing.T) {
	pS := forTestStruct{
		"my", 2, 2000,
	}
	PrintVar(pS, 1)
	assert.Equal(t, nil, nil)
}
