package main

type data struct {
  grid [][]byte
}

func NewData() data {
  return data{[][]byte{}}
}

func (d *data) Add(row []byte) {
  d.grid = append(d.grid, make([]byte, len(row)))
  copy(d.grid[len(d.grid)-1], row)
}

func (d *data) ApplyWindow(size int, cb func(w [][]byte) int) int {
  total := 0
  for i := 0; i < len(d.grid); i++ {
    rows := min(size, len(d.grid) - i)
    for j := 0; j < len(d.grid[i]); j++ {
      cols := min(size, len(d.grid[i]) - j)

      w := make([][]byte, rows)
      for m, _ := range w {
        w[m] = make([]byte, cols)
        for n, _ := range w[m] {
          w[m][n] = d.grid[i+m][j+n]
        }
      }

      total += cb(w)
    }
  }

  return total
}
