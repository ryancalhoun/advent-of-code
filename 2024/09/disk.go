package main

type disk struct {
  blocks []int
  added int
}

func NewDisk() *disk {
  return &disk{[]int{}, 0}
}

func (d *disk) Add(r rune) {
  s := make([]int, r-'0')
  v := -1

  if d.added % 2 == 0 {
    v = d.added / 2
  }
  for i := range s {
    s[i] = v
  }
  d.blocks = append(d.blocks, s...)
  d.added++
}

func (d *disk) CompactBlocks() {
  end := len(d.blocks)
  for i := 0; i < end; i++ {
    if d.blocks[i] == -1 {
      for i < end {
        end--
        if d.blocks[end] != -1 {
          break
        }
      }
      d.blocks[i], d.blocks[end] = d.blocks[end], d.blocks[i]
    }
  }
}

func (d *disk) CompactWholeFiles() {
  end := len(d.blocks)
  for end > 0 {
    start := end - 1
    if d.blocks[start] != -1 {
      for start > 0 && d.blocks[start-1] == d.blocks[end-1] {
        start--
      }

      for i := 0; i < start; i++ {
        if d.blocks[i] == -1 {
          j := i
          for ; j-i < end-start; j++ {
            if d.blocks[j] != -1 {
              break
            }
          }
          if j-i == end-start {
            for k := 0; k < end-start; k++ {
              d.blocks[i+k], d.blocks[start+k] = d.blocks[start+k], d.blocks[i+k]
            }
            break
          }
        }
      }
    }

    end = start
  }
}

func (d *disk) Checksum() int {
  sum := 0
  for i, r := range d.blocks {
    if r > 0 {
      sum += i * r
    }
  }

  return sum
}
