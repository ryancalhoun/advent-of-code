package main

import (
  "bufio"
  "fmt"
  "os"
)

func main() {
  in := bufio.NewReader(os.Stdin)
  disk := NewDisk()

  for  {
    r, _, e := in.ReadRune()
    if e != nil || r == '\n' {
      break
    }
    disk.Add(r)
  }

  if os.Getenv("PART") == "1" {
    disk.CompactBlocks()
  } else {
    disk.CompactWholeFiles()
  }

  fmt.Println(disk.Checksum())
}
