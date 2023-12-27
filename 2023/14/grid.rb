class Grid
  def initialize
    @fixed_rows = {}
    @fixed_cols = {}
    @rolling = []

    @height = 0
    @width = 0
  end

  def add_rolling(i, j)
    @rolling << [i,j]
    touch i, j
  end
  def add_fixed(i, j)
    (@fixed_rows[i] ||= []) << j
    (@fixed_cols[j] ||= []) << i
    touch i, j
  end
  def touch(i, j)
    @height = [@height, i+1].max
    @width = [@width, j+1].max
  end

  def tilt_n!
    stacks = tilt_stacks @fixed_cols, @width, -1
    @rolling.each do |r|
      s = stacks[r[1]]
      bucket = s.keys.sort.partition {|k| k < r[0]}[0].last
      r[0] = bucket + 1 + s[bucket]
      s[bucket] += 1
    end
  end
  def tilt_s!
    stacks = tilt_stacks @fixed_cols, @width, @height
    @rolling.each do |r|
      s = stacks[r[1]]
      bucket = s.keys.sort.partition {|k| k < r[0]}[1].first
      r[0] = bucket - 1 - s[bucket]
      s[bucket] += 1
    end
  end
  def tilt_w!
    stacks = tilt_stacks @fixed_rows, @height, -1
    @rolling.each do |r|
      s = stacks[r[0]]
      bucket = s.keys.sort.partition {|k| k < r[1]}[0].last
      r[1] = bucket + 1 + s[bucket]
      s[bucket] += 1
    end
  end
  def tilt_e!
    stacks = tilt_stacks @fixed_rows, @height, @width
    @rolling.each do |r|
      s = stacks[r[0]]
      bucket = s.keys.sort.partition {|k| k < r[1]}[1].first
      r[1] = bucket - 1 - s[bucket]
      s[bucket] += 1
    end
  end

  def cycle!
    tilt_n!
    tilt_w!
    tilt_s!
    tilt_e!
  end

  def tilt_stacks(fixed, dim, limit)
    stacks = []
    dim.times do
      stacks << {limit => 0}
    end

    fixed.each do |k,v|
      v.each do |i|
        stacks[k][i] = 0
      end
    end

    stacks
  end

  def extrapolate!(n)
    history = [score]
    load_values = {}
    start = 0
    length = 0

    n.times do |i|
      cycle!

      s = score
      load_values[i+1] = load_score
      if length == 0
        if i = history.index(s)
          start = i
          length = history.size - i
        else
          history << score
        end
      else
        break
      end
    end

    load_values[n] || load_values[(n-start)%length + start]
  end

  def score
    [@rolling.map {|r| 2**r[0]}.sum, @rolling.map {|r| 2**r[1]}.sum]
  end

  def load_score
    @rolling.map {|r| @height - r[0]}.sum
  end

  def show
    @height.times do |i|
      @width.times do |j|
        if @rolling.select {|r| r == [i,j] }.size == 1
          print '0'
        elsif @fixed_rows[i]&.include?(j)
          print '#'
        else
          print '.'
        end
      end
      puts
    end
  end
end
