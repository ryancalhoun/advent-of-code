package main

import (
  "fmt"
  "os"
)

func main() {
  total := 0
  for {
    clawMachine := NewClawMachine()
    if clawMachine == nil {
      break
    }

    if os.Getenv("PART") == "2" {
      clawMachine.AdjustScale()
    }

    tokens := clawMachine.MinTokens()

    if tokens > 0 {
      total += tokens
    }
  }

  fmt.Println(total)
}
