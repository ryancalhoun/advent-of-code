package main

import (
  "bufio"
  "fmt"
  "os"
)

func main() {
  in := bufio.NewReader(os.Stdin)
  n := 0

  for {
    bytes, _, e := in.ReadLine()
    if e != nil {
      break
    }

    report := NewReport(bytes)
    if os.Getenv("PART") == "2" {
      report.applyDampener()
    }

    if report.isSafe() {
      n += 1
    }
  }

  fmt.Println(n)
}
