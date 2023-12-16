require_relative 'bounce'

class Grid
  attr_reader :width, :height
  def initialize
    @rows = {}
    @cols = {}
    @width = 0
    @height = 0

    @visited = {}
  end

  def add_left_mirror!(i, j)
    Bounce.left_mirror(i, j).tap do |m|
      (@rows[i] ||= []) << m
      (@cols[j] ||= []) << m
    end
    touch! i, j
  end
  def add_right_mirror!(i, j)
    Bounce.right_mirror(i, j).tap do |m|
      (@rows[i] ||= []) << m
      (@cols[j] ||= []) << m
    end
    touch! i, j
  end
  def add_h_splitter!(i, j)
    (@rows[i] ||= []) << Bounce.splitter(i, j)
    touch! i, j
  end
  def add_v_splitter!(i, j)
    (@cols[j] ||= []) << Bounce.splitter(i, j)
    touch! i, j
  end
  def touch!(i, j)
    @width = [j+1, @width].max
    @height = [i+1, @height].max
  end

  def reset!
    @visited = {}
    @rows.each do |k,v|
      v.each(&:reset!)
    end
    @cols.each do |k,v|
      v.each(&:reset!)
    end
  end

  def shoot!(dir, i, j)
    b = case dir
    when :up, :down
      shoot_col @cols[j]&.sort_by(&:i), dir, i
    when :left, :right
      shoot_row @rows[i]&.sort_by(&:j), dir, j
    end

    if b
      visit! [i, j], [b.i, b.j]
      b.hit dir do |next_dir|
        shoot! next_dir, b.i, b.j
      end
    else
      edge(dir, i, j) do |e_i, e_j|
        visit! [i, j], [e_i, e_j]
      end
    end 
  end
  def visit!(from, to)
    rows = [from[0], to[0]].sort
    cols = [from[1], to[1]].sort

    (rows[0]..rows[1]).each do |i|
      (cols[0]..cols[1]).each do |j|
        if (0...height).include?(i) && (0...width).include?(j)
          @visited[[i, j]] = true
        end
      end
    end
  end
  def shoot_col(col, dir, i)
    if col
      if dir == :up
        col.select {|b| i > b.i }.last
      else
        col.select {|b| i < b.i }.first
      end
    end
  end
  def shoot_row(row, dir, j)
    if row
      if dir == :left
        row.select {|b| j > b.j }.last
      else
        row.select {|b| j < b.j }.first
      end
    end
  end
  def edge(dir, i, j)
    case dir
    when :up
      yield 0, j
    when :down
      yield @height-1, j
    when :left
      yield i, 0
    when :right
      yield i, @width-1
    end
  end

  def count_visited
    @visited.keys.size
  end
end
