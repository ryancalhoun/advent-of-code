package main

type bucket struct {
  x int
  t int
}

type blinker struct {
  buckets map[bucket]int
  blinks int
  stones int
}

func NewBlinker(blinks int) *blinker {
  return &blinker{map[bucket]int{}, blinks, 0}
}

func (b *blinker) AddStone(v int) {
  b.stones += _blink(v, b.blinks, b.buckets)
}

func (b *blinker) TotalStones() int {
  return b.stones
}

func _blink(x int, t int, buckets map[bucket]int) int {
  if t == 0 {
    return 1
  }

  answer, ok := buckets[bucket{x,t}]
  if ok {
    return answer
  }

  if x == 0 {
    answer =  _blink(1, t - 1, buckets)
  } else {
    d := _digits(x)
    if d % 2 == 0 {
      p := _power(d / 2)
      answer = _blink(x / p, t - 1, buckets) + _blink(x % p, t - 1, buckets)
    } else {
      answer = _blink(x * 2024, t - 1, buckets)
    }
  }

  buckets[bucket{x,t}] = answer

  return answer
}

func _digits(x int) int {
  d := 0
  for x != 0 {
    d++
    x /= 10
  }
  return d
}

func _power(d int) int {
  p := 1
  for i := 0; i < d; i++ {
    p *= 10
  }
  return p
}
