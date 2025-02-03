package main

import (
  "bufio"
  "fmt"
  "os"
)

func main() {
  in := bufio.NewReader(os.Stdin)

  total := 0

  for {
    line, _, err := in.ReadLine()
    if err != nil {
      break
    }

    eq := NewEquation(string(line))

    operators := []func(int, int) int {
      func (x int, y int) int {
        return x + y
      },
      func (x int, y int) int {
        return x * y
      },
    }

    if os.Getenv("PART") == "2" {
      operators = append(operators, func (x int, y int) int {
        z := y
        for z > 0 {
          x *= 10
          z /= 10
        }
        return x + y 
      })
    }

    if eq.Valid(operators) {
      total += eq.Result()
    }
  }

  fmt.Println(total)
}
