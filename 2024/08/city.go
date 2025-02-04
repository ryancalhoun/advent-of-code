package main

type point struct {
  x int
  y int
}

type city struct {
  antennae map[byte][]point
  width int
  height int
  harmonics bool
}

func NewCity() *city {
  return &city{map[byte][]point{}, 0, 0, false}
}

func (c *city) Set(x int, y int, ch byte) {
  c.width = max(c.width, x+1)
  c.height = max(c.height, y+1)

  if ch == '.' {
    return
  }
  same, _ := c.antennae[ch]
  c.antennae[ch] = append(same, point{x,y})
}

func (c *city) ResonantHarmonics() {
  c.harmonics = true
}

func (c *city) CountAntinodes() int {
  antinodes := map[point]bool{}

  for _, same := range c.antennae {
    for i := 0; i < len(same)-1; i++ {
      for j := i+1; j < len(same); j++ {
        a, b := &same[i], &same[j]
        if a.x > b.x {
          a, b = b, a
        }
        dx := b.x - a.x
        dy := b.y - a.y

        c.SetAntinodes(*a, -dx, -dy, antinodes)
        c.SetAntinodes(*b, dx, dy, antinodes)
      }
    }
  }

  return len(antinodes)
}

func (c* city) SetAntinodes(p point, dx int, dy int, to_set map[point]bool) {
  if c.harmonics {
    for c.Includes(p) {
      to_set[p] = true
      p.x += dx
      p.y += dy
    }
  } else {
    p.x += dx
    p.y += dy
    if c.Includes(p) {
      to_set[p] = true
    }
  }
}

func (c *city) Includes(p point) bool {
  return p.x >= 0 && p.y >= 0 && p.x < c.width && p.y < c.height
}

