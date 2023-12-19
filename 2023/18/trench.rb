class Trench
  attr_reader :i0, :j0, :i1, :j1
  def initialize(i0, j0, i1, j1)
    @i0, @j0 = i0, j0
    @i1, @j1 = i1, j1
  end
  def to_s
    "(#{i0},#{j0}) === #(#{i1},#{j1}) .... #{size}"
  end
  def size
    (i1-i0).abs + (j1-j0).abs
  end

  def up?
    j1 == j0 && i1 < i0
  end
  def down?
    j1 == j0 && i1 > i0
  end
  def left?
    i1 == i0 && j1 < j0
  end
  def right?
    i1 == i0 && j1 > j0
  end
  def imin
    [i0, i1].min
  end
  def imax
    [i0, i1].max
  end
  def jmin
    [j0, j1].min
  end
  def jmax
    [j0, j1].max
  end
  def v_overlaps?(t)
    min = [imin, t.imin].max
    max = [imax, t.imax].min

    min <= max
  end
end

