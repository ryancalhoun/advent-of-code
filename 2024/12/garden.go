package main

import "sort"

type point struct {
  x int
  y int
}

type plot struct {
  p point
  ch byte
  group int
}

type fence struct {
  n bool
  s bool
  e bool
  w bool
}

type edges map[int][]int

type group []*plot
type groups map[int]group

type garden struct {
  plots map[byte]groups
  last group
  rows int
  group int
  discount bool
}

func NewGarden() *garden {
  g := garden{}
  g.plots = map[byte]groups{}
  return &g
}

func (g *garden) AddRow(row []byte) {
  last := []*plot{}

  for i := 0; i < len(row); i++ {
    g.group++
    last = append(last, &plot{point{i, g.rows}, row[i], g.group})

    groups, ok := g.plots[row[i]]
    if ! ok {
      groups = map[int]group{}
      g.plots[row[i]] = groups
    }
    p := last[len(last)-1]
    groups[p.group] = append(groups[p.group], p)

    if i > 0 && row[i] == last[i-1].ch {
      _join(groups, p.group, last[i-1].group)
    }
    if i < len(g.last) && row[i] == g.last[i].ch {
      _join(groups, p.group, g.last[i].group)
    }
  }
  g.last = last
  g.rows++
}

func (g *garden) ApplyDiscount() {
  g.discount = true
}

func (g *garden) TotalPrice() int {
  price := 0

  for _, groups := range g.plots {
    for _, group := range groups {
      var p int
      if g.discount {
        p = group.StraightLinePerimeter()
      } else {
        p = group.Perimeter()
      }
      price += group.Area() * p
    }
  } 

  return price
}

func (g group) Area() int {
  return len(g)
}

func (g group) Perimeter() int {
  n, s, e, w := _fencing(g)
  return _count(_each_unit, n, s, e, w)
}

func (g group) StraightLinePerimeter() int {
  n, s, e, w := _fencing(g)
  return _count(_straight_line, n, s, e, w)
}

func (p point) Offset(dx int, dy int) point {
  return point{p.x+dx, p.y+dy}
}

func _each_unit(side []int) int {
  return len(side) 
}

func _straight_line(side []int) int {
  s := 0
  sort.Ints(side)
  for i := 0; i < len(side); i++ {
    if i == 0 || side[i] != side[i-1] + 1 {
      s++
    }
  }
  return s
}

func _count(c func([]int) int, e... edges) int {
  s := 0
  for _, r := range e {
    for _, p := range r {
      s += c(p)
    }
  }

  return s
}

func _fencing(g group) (edges, edges, edges, edges) {
  plots := map[point]*fence{}

  for _, plot := range g {
    plots[plot.p] = &fence{true, true, true, true}
  }
  for plot := range plots {
    var ok bool
    _, ok = plots[plot.Offset(0, 1)]
    if ok {
      plots[plot].s = false
      plots[plot.Offset(0, 1)].n = false
    }
    _, ok = plots[plot.Offset(1, 0)]
    if ok {
      plots[plot].e = false
      plots[plot.Offset(1, 0)].w = false
    }
  }

  n := edges{}
  s := edges{}
  e := edges{}
  w := edges{}

  for p, plot := range plots {
    if plot.n {
      n[p.y] = append(n[p.y], p.x)
    }
    if plot.s {
      s[p.y] = append(s[p.y], p.x)
    }
    if plot.e {
      e[p.x] = append(e[p.x], p.y)
    }
    if plot.w {
      w[p.x] = append(w[p.x], p.y)
    }
  }

  return n, s, e, w
}

func _join(g groups, a int, b int) {
  if a == b {
    return
  }
  for _, p := range g[a] {
    p.group = b
    g[b] = append(g[b], p)
  }
  delete(g, a)
}

