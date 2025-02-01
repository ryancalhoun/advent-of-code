package main

import (
  "bufio"
  "fmt"
  "os"
)

func main() {
  in := bufio.NewReader(os.Stdin)

  m := NewMap()

  y := 0
  for {
    line, _, err := in.ReadLine()
    if err != nil {
      break
    }

    for x, c := range line {
      m.Set(x, y, c)
    }
    y++
  }

  if os.Getenv("PART") == "1" {
    fmt.Println(m.CountPath())
  } else {
    fmt.Println(m.FindLoops())
  }
}
