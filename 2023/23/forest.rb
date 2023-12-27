class Forest
  def initialize
    @g = []
  end
  def <<(row)
    @g << row
  end
  def start
    [0, @g[0].index('.')]
  end
  def finish
    [@g.size-1, @g.last.index('.')]
  end
  def height
    @g.size
  end
  def width
    @g.last.size
  end
  def get(pos)
    @g[pos.first][pos.last]
  end
  def set(pos, val)
    @g[pos.first][pos.last] = val
  end
  def neighbors(pos)
    [].tap do |n|
      n << [pos.first+1, pos.last] if pos.first+1 < height
      n << [pos.first-1, pos.last] if pos.first > 0
      n << [pos.first, pos.last+1] if pos.last+1 < width
      n << [pos.first, pos.last-1] if pos.last > 0
    end
  end

  def trace_segment(path)
    n = [path.finish]

    while n.size == 1
      p = n.shift

      v = get p

      if v == '>'
        if path.leftof?(p)
          path.downhill = true
        elsif path.rightof?(p)
          path.uphill = true
        end
      end
      if v == 'v'
        if path.above?(p)
          path.downhill = true
        elsif path.below?(p)
          path.uphill = true
        end
      end

      set p, '#'

      path << p
      break if v == '+'

      n += neighbors(p).select {|n| get(n) != '#' }
    end

    n
  end
end
