package main

import (
	"fmt"
  "os"
	"slices"
)

func dist(a, b int) int {
	if a < b {
		return b - a
	}
	return a - b
}

func totalDifference(one, two []int) int {
	slices.Sort(one)
	slices.Sort(two)

	sum := 0
	for i := range len(one) {
		sum += dist(one[i], two[i])
	}

	return sum
}

func similarity(one, two []int) int {
	count := make(map[int]int)
	for _, v := range two {
		count[v] += 1
	}

	sum := 0
	for _, v := range one {
		c, ok := count[v]
		if ok {
			sum += v * c
		}
	}

	return sum
}

func main() {

	var one []int
	var two []int

	for {
		var a, b int
		n, err := fmt.Scanln(&a, &b)
		if n != 2 || err != nil {
			break
		}

		one = append(one, a)
		two = append(two, b)
	}

  if os.Getenv("PART") == "1" {
    fmt.Println(totalDifference(one, two))
  } else {
    fmt.Println(similarity(one, two))
  }
}
