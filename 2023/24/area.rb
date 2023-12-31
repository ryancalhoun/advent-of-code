require_relative 'equation'
require_relative 'linear_system'

class Area
  def initialize(stones)
    @stones = stones
  end

  def future_intersections_within(bounds)
    count = 0
    @stones.size.times do |i|
      (@stones.size - i - 1).times do |j|
        s1 = @stones[i]
        s2 = @stones[i+j+1]

        x, y = s1.intersection(s2)

        if bounds.include?(x) && bounds.include?(y)
          count += 1
        end
      end
    end
    count
  end

  def find_magic_line
    a = []
    b = []

    @stones.first(5).each_cons(2) do |s1, s2|
      eq = Equation.new s1, s2

      a << [eq.x0, eq.y0, eq.vx, eq.vy]
      b << eq.b
    end
    x0, y0, vx, vy = LinearSystem.new(a).solve(b)

    s1, s2 = @stones.first(2)

    t1 = (s1.x - x0) / (vx - s1.vx)
    t2 = (s2.x - x0) / (vx - s2.vx)

    dt = t2 - t1
    dz = s2.z_at(t2) - s1.z_at(t1)

    vz = dz / dt
    z0 = s1.z_at(t1) - vz*t1

    return x0, y0, z0
  end
end
