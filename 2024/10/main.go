package main

import (
  "bufio"
  "fmt"
  "os"
)

func main() {
  in := bufio.NewReader(os.Stdin)

  topo := NewTopoMap()

  for y := 0; ; y++ {
    line, _, err := in.ReadLine()
    if err != nil {
      break
    }
    for x, ch := range line {
      topo.Set(x, y, int(ch-'0'))
    }
  }

  topo.TraverseTrails()

  if os.Getenv("PART") == "1" {
    fmt.Println(topo.ScoreTrailheads())
  } else {
    fmt.Println(topo.ScoreUniqueTrails())
  }
}
