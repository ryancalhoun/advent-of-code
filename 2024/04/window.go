package main

type window interface {
  Size() int
  OnPosition(w [][]byte) int
}

type xmas struct {
}

func NewWindow_Xmas() xmas {
  return xmas{}
}

func (x xmas) Size() int {
  return 4
}

func (x xmas) OnPosition(w [][]byte) int {
  m := 0

  match := func(b ...byte) bool {
    s := string(b)
    return s == "XMAS" || s == "SAMX"
  }

  if len(w) == 4 {
    if match(w[0][0], w[1][0], w[2][0], w[3][0]) {
      m += 1
    }

    if len(w[0]) == 4 {
      if match(w[0][0], w[1][1], w[2][2], w[3][3]) {
        m += 1
      }
      if match(w[0][3], w[1][2], w[2][1], w[3][0]) {
        m += 1
      }
    }
  }

  if len(w[0]) == 4 {
    if match(w[0][0], w[0][1], w[0][2], w[0][3]) {
      m += 1
    }
  }

  return m
}

type x_mas struct {
}

func NewWindow_X_Mas() x_mas {
  return x_mas{}
}

func (x x_mas) Size() int {
  return 3
}

func (x x_mas) OnPosition(w [][]byte) int {

  if len(w) < 3 || len(w[0]) < 3 {
    return 0
  }

  if w[1][1] != 'A' {
    return 0
  }

  corners := string([]byte{ w[0][0], w[0][2], w[2][0], w[2][2] })

  if corners == "MMSS" || corners == "MSMS" || corners == "SSMM" || corners == "SMSM" {
    return 1
  }

  return 0
}

