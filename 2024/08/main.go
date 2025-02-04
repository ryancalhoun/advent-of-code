package main

import (
  "bufio"
  "fmt"
  "os"
)

func main() {
  city := NewCity()

  in := bufio.NewReader(os.Stdin)
  y := 0
  for {
    line, _, err := in.ReadLine()
    if err != nil {
      break
    }

    for x, ch := range line {
      city.Set(x, y, ch)
    }
    y++
  }

  if os.Getenv("PART") == "2" {
    city.ResonantHarmonics()
  }

  fmt.Println(city.CountAntinodes())
}
