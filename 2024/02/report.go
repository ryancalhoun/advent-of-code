package main

import (
  "bufio"
  "strings"
  "strconv"
  "slices"
)

type report struct {
  levels []int
  dampener bool
}

func NewReport(bytes []byte) *report {
  line := bufio.NewReader(strings.NewReader(string(bytes)))

  r := report{levels: []int{}, dampener: false}

  for {
    n, e := line.ReadString(' ')

    level, _ := strconv.Atoi(strings.TrimSpace(n))
    r.levels = append(r.levels, level)

    if e != nil {
      break
    }
  }
  return &r
}

func All[T any](ts [] T, pred func(T) bool) bool {
  for _, t := range ts {
    if ! pred(t) {
      return false
    }
  }
  return true
}

func isOneOf[T comparable](values...T) func(T) bool {
  return func(value T) bool {
    return slices.Contains(values, value)
  }
}

func isSafe(levels []int) bool {
  prev := 0
  count := 0
  diffs := [] int{}

  for _, level := range levels {
    if count > 0 {
      diffs = append(diffs, level - prev)
    }

    prev = level
    count += 1
  }

  return All[int](diffs, isOneOf[int](1, 2, 3)) || All[int](diffs, isOneOf[int](-1, -2, -3))
}

func (r *report) applyDampener() {
  r.dampener = true
}

func (r *report) isSafe() bool {
  if isSafe(r.levels) {
    return true
  }
  if r.dampener {
    for i := 0; i < len(r.levels); i++ {
      if isSafe(slices.Concat(r.levels[0:i], r.levels[i+1:])) {
        return true
      }
    }
  }

  return false
}

