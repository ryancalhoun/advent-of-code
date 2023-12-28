class Stone
  attr_reader :x, :y, :z, :m, :b
  def initialize(x, y, z, vx, vy, vz)
    @x, @y, @z = x, y, z
    @vx, @vy, @vz = vx, vy, vz

    @m = vy.to_f/vx
    @b = y - @m * x
  end

  def self.parse(line)
    new *line.scan(/-?\d+/).map(&:to_i)
  end

  def future?(x, y)
   (x - @x) * @vx > 0 && (y - @y) * @vy > 0
  end

  def intersection(s)
    dm = m - s.m
    return nil if dm == 0

    x = (s.b - b) / dm
    y = (m*s.b - s.m*b) / dm

    return nil unless future?(x, y) && s.future?(x, y)

    [x, y]
  end
end
