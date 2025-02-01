package main

type update struct {
  m []int
  r *rules
  fix bool
}

func NewUpdates(r *rules) *update {
  return &update{[]int{}, r, false}
}

func (u *update) FixUnordered() {
  u.fix = true
}

func (u *update) On(line string) {
  a := ToA(line, `,`)
  pages := a.Split()

  if u.r.Valid(pages) == u.fix {
    return
  }
  if u.fix {
    u.r.Sort(pages)
  }

  u.m = append(u.m, pages[len(pages)/2])
}

func (u *update) Total() int {
  total := 0
  for _, m := range u.m {
    total += m
  }

  return total
}
