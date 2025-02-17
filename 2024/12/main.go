package main

import (
  "bufio"
  "fmt"
  "os"
)

func main() {
  in := bufio.NewReader(os.Stdin)

  garden := NewGarden()

  for {
    line, _, err := in.ReadLine()
    if err != nil {
      break
    }

    garden.AddRow(line)
  }

  if os.Getenv("PART") == "2" {
    garden.ApplyDiscount()
  }

  fmt.Println(garden.TotalPrice())
}
