package main

import "fmt"

type coord struct {
  x int
  y int
}

type claw_machine struct {
  a coord
  b coord
  p coord
}

func NewClawMachine() *claw_machine {
  c := claw_machine{}
  n, _ := fmt.Scanf("Button A: X+%d, Y+%d\n", &c.a.x, &c.a.y)
  if n != 2 {
    return nil
  }
  fmt.Scanf("Button B: X+%d, Y+%d\n", &c.b.x, &c.b.y)
  fmt.Scanf("Prize: X=%d, Y=%d\n", &c.p.x, &c.p.y)
  fmt.Scanf("\n")

  return &c
}

func (c *claw_machine) AdjustScale() {
  c.p.x += 10000000000000
  c.p.y += 10000000000000
}

func (c *claw_machine) MinTokens() int {

  b := (c.p.y*c.a.x - c.p.x*c.a.y) / (c.a.x*c.b.y - c.a.y*c.b.x)
  a := (c.p.x - c.b.x*b)/c.a.x

  if a*c.a.x + b*c.b.x == c.p.x && a*c.a.y + b*c.b.y == c.p.y {
    return 3*a + b
  }

  return -1
}
