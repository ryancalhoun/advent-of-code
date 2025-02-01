package main

import (
  "bufio"
  "fmt"
  "os"
)

func main() {
  in := bufio.NewReader(os.Stdin)

  r := NewRules()
  u := NewUpdates(r)

  if os.Getenv("PART") == "2" {
    u.FixUnordered()
  }

  var handler LineHandler
  handler = r

  for {
    line, _, err := in.ReadLine()
    if err != nil {
      break
    }

    if len(line) == 0 {
      handler = u
    } else {
      handler.On(string(line))
    }
  }

  fmt.Println(u.Total())
}
