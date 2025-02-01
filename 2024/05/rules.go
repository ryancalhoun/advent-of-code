package main

type rule struct {
  x int
  y int
}

type rules struct {
  list []rule
}

func NewRules() *rules {
  return &rules{}
}

func (r *rules) On(line string) {
  i := len(r.list)
  r.list = append(r.list, rule{})

  a := ToA(line, `|`)
  a.SplitV(&r.list[i].x, &r.list[i].y)
}

func (r *rules) Valid(pages []int) bool {
  pos := map[int]int {}

  for i, p := range pages {
    pos[p] = i
  }

  for _, rule := range r.list {
    if ! rule.Valid(pos) {
      return false
    }
  }

  return true
}

func (r* rule) Valid(pos map[int]int) bool {
  x, ex := pos[r.x]
  y, ey := pos[r.y]

  return !ex || !ey || x < y
}

func (r* rules) Sort(pages []int) {

  ok := false
  for ! ok {
    ok = true
    for i := 0; i < len(pages) - 1; i++ {
      for j := i + 1; j < len(pages); j++ {
        if r.Invalid(pages[i], pages[j]) {
          pages[i], pages[j] = pages[j], pages[i]
          ok = false
          break
        }
      }
    }
  }
}

func (r* rules) Invalid(x int, y int) bool {
  for _, rule := range r.list {
    if rule.x == y && rule.y == x {
      return true
    }
  }
  return false
}

