package main

import (
  "bufio"
  "fmt"
  "os"
)

func main() {
  in := bufio.NewReader(os.Stdin)

  data := NewData()

  for {
    line, _, err := in.ReadLine()
    if err != nil {
      break
    }

    data.Add(line)
  }

  var w window
  if os.Getenv("PART") == "1" {
    w = NewWindow_Xmas()
  } else {
    w = NewWindow_X_Mas()
  }

  total := data.ApplyWindow(w.Size(), w.OnPosition)

  fmt.Println(total) 
}
