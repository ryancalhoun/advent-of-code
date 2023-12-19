require_relative 'trench'
require_relative 'covering'

class Lagoon
  R = [0, 1]
  L = [0, -1]
  
  def initialize
    @i = 0
    @j = 0
    @dir = [0, 0]

    @turns = 0

    @t = []
  end

  def dig!(n)
    @t << Trench.new(@i, @j, @i+@dir.first*n, @j+@dir.last*n)

    @i = @t.last.i1
    @j = @t.last.j1
  end

  def R
    @turns -= @dir.first
    @dir = [0, 1]
  end
  def D
    @turns += @dir.last
    @dir = [1, 0]
  end
  def L
    @turns += @dir.first
    @dir = [0, -1]
  end
  def U
    @turns -= @dir.last
    @dir = [-1, 0]
  end

  def cw?
    @turns > 0
  end
  def ccw?
    @turns < 0
  end

  def total_volume
    perimeter_volume + inner_volume
  end

  def perimeter_volume
    @t.map(&:size).sum
  end

  def inner_volume
    sum = 0

    vertical = @t.select { |t| t.up? || t.down? }.sort_by(&:j0)

    vertical.select {|left| cw? ? left.up? : left.down? }.each do |left|
      opposites = vertical.select {|right| right.j0 > left.j0 && right.v_overlaps?(left) }
      covering = Covering.new left.imin..left.imax

      until covering.covered? || opposites.empty?
        right = opposites.shift

        top = covering.first_after [left.imin+1, right.imin].max
        bottom = covering.last_before [left.imax-1, right.imax].min

        next if top > bottom

        covering.cover! (top..bottom)

        height = bottom - top + 1
        width = right.j0 - left.j0 - 1

        sum += width*height
      end
    end

    horizontal = @t.select { |t| t.left? || t.right? }.sort_by(&:j0)

    horizontal.each do |h|
      opposite = vertical.find {|v| v.j0 > h.jmax && v.v_overlaps?(h) }
      next unless opposite && (cw? ? opposite.down? : opposite.up?)

      width = opposite.j0 - h.jmax - 1
      sum += width
    end

    sum
  end
end

