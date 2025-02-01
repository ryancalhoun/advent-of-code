package main

import (
  "strings"
  "strconv"
)

type to_a struct {
  str string
  sep string
}

func ToA(str string, sep string) to_a {
  return to_a{str, sep}
}

func (a *to_a) SplitV(n... *int) {
  s := strings.Split(a.str, a.sep)
  for i, v := range n {
    x, _ := strconv.Atoi(s[i])
    *v = x
  }
}

func (a *to_a) Split() []int {
  s := strings.Split(a.str, a.sep)
  n := make([]int, len(s))
  for i, _ := range n {
    x, _ := strconv.Atoi(s[i])
    n[i] = x
  }
  return n
}
