package main

import (
  "fmt"
  "io"
  "os"
  "regexp"
  "strconv"
)

func main() {
  var data string
  chunk := make([]byte, 1024)
  for {
    n, err := io.ReadFull(os.Stdin, chunk)
    data += string(chunk[0:n])
    if err != nil {
      break
    }
  }

  if os.Getenv("PART") == "2" {
    dont := regexp.MustCompile(`(?s)don't\(\).*?(do\(\)|$)`)
    data = dont.ReplaceAllString(data, "")
  }

  mul := regexp.MustCompile(`mul\((\d{1,3}),(\d{1,3})\)`)
  matches := mul.FindAllStringSubmatch(data, -1)

  var total int
  for _, m := range matches {
    x, _ := strconv.Atoi(m[1])
    y, _ := strconv.Atoi(m[2])

    total += x * y
  }

  fmt.Println(total)
}
