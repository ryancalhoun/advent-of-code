package main

type LineHandler interface {
  On(line string)
}
