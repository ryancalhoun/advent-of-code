package main

import (
  "fmt"
  "os"
)

func main() {
  blinks := 25
  if os.Getenv("PART") == "2" {
    blinks = 75
  }
  b := NewBlinker(blinks)

  for {
    var x int
    _, err := fmt.Scanf("%d", &x)
    if err != nil {
      break
    }

    b.AddStone(x)
  }
  fmt.Println(b.TotalStones())
}
