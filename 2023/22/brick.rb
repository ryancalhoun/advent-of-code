class Brick
  attr_reader :x, :y, :z
  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
  end
  def self.parse(line)
    a, b = line.split('~').map {|s| s.split(',').map(&:to_i) }

    new a[0]..b[0], a[1]..b[1], a[2]..b[2] 
  end
  def overlaps?(b)
    overlaps_dim?(x, b.x) && overlaps_dim?(y, b.y)
  end
  def overlaps_dim?(a, b)
    a.begin <= b.end && b.begin <= a.end
  end
  def drop!(to)
    @z = to..to+@z.size-1
  end
  def bottom
    @z.begin
  end
  def top
    @z.end
  end

  def to_s
    "#{x}, #{y}, #{z}"
  end
end
