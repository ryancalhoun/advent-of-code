package main

type point struct {
  x int
  y int
}

type guard struct {
  pos point
  next point
  width int
  height int
}

type lab_map struct {
  obstacles map[point]bool
  visited map[point]point
  guard *guard
}

func NewMap() *lab_map {
  return &lab_map {map[point]bool{}, map[point]point{}, &guard {}}
}

func (m *lab_map) Set(x int, y int, c byte) {
  m.guard.width = max(m.guard.width, x+1)
  m.guard.height = max(m.guard.height, y+1)

  if c == '#' {
    m.obstacles[point{x,y}] = true
  } else if c != '.' {
    m.guard.pos = point{x,y}
    if c == '<' {
      m.guard.next = point{-1,0}
    } else if c == '>' {
      m.guard.next = point{1,0}
    } else if c == '^' {
      m.guard.next = point{0,-1}
    } else {
      m.guard.next = point{0,1}
    }
  }
}

func (m *lab_map) CountPath() int {
  m._gallavant()
  return len(m.visited)
}

func (m *lab_map) FindLoops() int {
  loops := 0

  start := m.guard.pos
  next := m.guard.next

  for y := 0; y < m.guard.height; y++ {
    for x := 0; x < m.guard.width; x++ {
      p := point{x,y}
      if p == start {
        continue
      }
      if _isset(m.obstacles, p, true) {
        continue
      }

      m.guard.pos = start
      m.guard.next = next

      clear(m.visited)

      m.obstacles[p] = true

      if m._gallavant() {
        loops++
      }

      delete(m.obstacles, p)
    }
  }
  return loops
}

func (m *lab_map) _gallavant() bool {
  for m.guard.InBounds() {
    n, ok := m.visited[m.guard.pos] 

    if ok {
      if n == m.guard.next {
        return true
      }
    } else {
      m.visited[m.guard.pos] = m.guard.next
    }

    if _isset(m.obstacles, m.guard.Next(), true) {
      m.guard.Turn()
    } else {
      m.guard.Step()
    }
  }

  return false
}

func (g *guard) InBounds() bool {
  return g.pos.x >= 0 && g.pos.y >= 0 && g.pos.x < g.width && g.pos.y < g.height
}

func (g *guard) Next() point {
  return point{g.pos.x + g.next.x, g.pos.y + g.next.y}
}

func (g *guard) Step() {
  g.pos.x += g.next.x
  g.pos.y += g.next.y
}

func (g *guard) Turn() {
  g.next = point{-g.next.y, g.next.x}
}

func _isset[V comparable](m map[point]V, p point, v V) bool {
  x, ok := m[p]
  return ok && x == v
}

