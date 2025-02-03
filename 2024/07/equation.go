package main

type equation struct {
  result int
  operands []int
}

func NewEquation(line string) *equation {
  eq := equation{0, []int{}}

  x := &eq.result
  for _, ch := range line {
    if ch == ' ' {
      n := len(eq.operands)
      eq.operands = append(eq.operands, 0)
      x = &eq.operands[n]
    } else if ch >= '0' && ch <= '9' {
      *x *= 10
      *x += int(ch - '0')
    }
  }

  return &eq
}

func (eq *equation) Valid(operators []func(int, int)int) bool {
  n := 1

  for i := 0; i < len(eq.operands) - 1; i++ {
    n *= len(operators)
  }

  for i := 0; i < n; i++ {
    v := eq.operands[0]
    m := i
    for j := 1; j < len(eq.operands); j++ {
      v = operators[m % len(operators)](v, eq.operands[j])
      m /= len(operators)
    }

    if v == eq.result {
      return true
    }
  }

  return false
}

func (eq *equation) Result() int {
  return eq.result
}
