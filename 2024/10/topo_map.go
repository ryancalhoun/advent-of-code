package main

type point struct {
  x int
  y int
}

type topo_map struct {
  loc []map[point]map[int]int
}

func NewTopoMap() *topo_map {
  t := topo_map{make([]map[point]map[int]int, 10)}
  for i := range t.loc {
    t.loc[i] = map[point]map[int]int{}
  }
  return &t
}

func (t *topo_map) Set(x int, y int, h int) {
  v := map[int]int{}
  if h == 9 {
    v[1 + len(t.loc[h])] = 1
  }
  
  t.loc[h][point{x,y}] = v
}

func (t *topo_map) TraverseTrails() {
  for h := 9; h > 0; h-- {
    for p, v := range t.loc[h] {
      _add(t.loc[h-1], p.x+1, p.y, v)
      _add(t.loc[h-1], p.x-1, p.y, v)
      _add(t.loc[h-1], p.x, p.y+1, v)
      _add(t.loc[h-1], p.x, p.y-1, v)
    }
  }
}

func (t *topo_map) ScoreTrailheads() int {
  score := 0

  for _, v := range t.loc[0] {
    score += len(v)
  }

  return score
}

func (t *topo_map) ScoreUniqueTrails() int {
  score := 0

  for _, v := range t.loc[0] {
    for _, n := range v {
      score += n
    }
  }

  return score
}

func _add(loc map[point]map[int]int, x int, y int, v map[int]int) {
  p := point{x,y}
  pv, ok := loc[p]

  if ok {
    for k, m := range v {
      n, _ := pv[k]
      pv[k] = n + m
    }
  }
}

