grid = []

STDIN.each_line do |line|
  grid << line.strip.each_char.map(&:to_i)
end

def neighbors(grid, p)
  n = []
  n << grid[p.first-1][p.last] if p.first > 0
  n << grid[p.first+1][p.last] if p.first < grid.size-1
  n << grid[p.first][p.last-1] if p.last > 0
  n << grid[p.first][p.last+1] if p.last < grid.last.size-1

  n
end

class Vertex
  attr_reader :i, :j, :weight, :neighbors
  def initialize(i, j, weight)
    @i, @j = i, j
    @weight = weight
    @neighbors = []

    @from_path = {}
  end
  def min_cost
    @from_path.values.min
    #@from_path.select {|path, cost| path.size >= 4 }.sort_by {|path, cost| cost }[0].last
  end
  def min_path
    @from_path.select {|path, cost| path.size >= 4 }.sort_by {|path, cost| cost }[0].first
  end
  def with_min
    @from_path.each do |path, cost|
      yield cost, path + [loc]
    end
  end
  def add(v)
    @neighbors << v
    v.add(self)
  end
  def relevant_part(from_path)
    #return nil if from_path[-2] == loc
    #return from_path if from_path.size < 3
    return from_path if from_path.size < 2

    rpath = from_path.reverse
    i_aligned, is = rpath.chunk {|p| p.first == loc.first }.first
    j_aligned, js = rpath.chunk {|p| p.last == loc.last }.first

    #puts "FROM #{from_path} #{i_aligned},#{is} #{j_aligned},#{js}"

    #return nil if (i_aligned && is.size > 3) || (j_aligned && js.size > 3)
    if i_aligned
      #puts "I #{is}"
      if is.size > 10 
        return nil
      end
      #if rpath.size >= 4 && is.size < 4 && rpath[is.size..is.size+3]&.map(&:last) != [is.last.last]*4
      if is.size == 1 && rpath.first(5).map(&:last) != [is[0].last]*5
        return nil
      end

      j_vals = is.map(&:last).uniq
      #puts "  jval #{j_vals}"
      if j_vals.size != is.size || j_vals.include?(loc.last)
        return nil
      end
      return from_path.last(is.size)
    elsif j_aligned
      #puts "J #{js}"
      if js.size > 10
        return nil
      end
      #if rpath.size >= 4 && js.size < 4 && rpath[js.size..js.size+3]&.map(&:first) != [js.last.first]*4
      if js.size == 1 && rpath.first(5).map(&:first) != [js[0].first]*5
        return nil
      end

      i_vals = js.map(&:first).uniq
      #puts "  ival #{i_vals}"
      if i_vals.size != js.size || i_vals.include?(loc.first)
        return nil
      end
      return from_path.last(js.size)
    end
    nil

    #return nil if (i_aligned && is.size > 10) || (j_aligned && js.size > 10)
    #return nil if (i_aligned && is.size < [from_path.size, 4].min) && (j_aligned && js.size < [from_path.size, 4].min)

    #return from_path.last([is.size, js.size].max)
  end
  def visit!(cost, from_path)
    if from = relevant_part(from_path)
      potential_cost = cost + (from.empty? ? 0 : @weight)
      #puts "VISIT #{loc} FROM #{from} ... #{potential_cost}"
      if !@from_path[from] || @from_path[from] > potential_cost
        @from_path[from] = potential_cost
        true
      end
    end
  end
  def loc
    [i, j]
  end
end

def find_path(grid, start, finish)
  nodes = []
  grid.each_with_index do |row, i|
    nodes << []
    row.each_with_index do |w, j|
      nodes[i][j] = Vertex.new(i, j, w)
    end
  end

  q = [nodes[start.first][start.last]]
  q.first.visit! 0, []

  until q.empty?
    u = q.shift

    neighbors(nodes, u.loc).each do |v|
      u.with_min do |cost, path|
        if v.visit! cost, path
          q << v
        end 
      end
    end
    q.sort_by! &:min_cost
    q.uniq!
    print "Current cost=#{u.min_cost} q=#{q.size}    \r"
  end
  puts
#  puts nodes.last.last.inspect
  puts nodes.last.last.min_cost

  n = nodes.last.last

  path = []
  loop do
    best_path = n.min_path
    puts best_path.inspect

    path << best_path

    start = best_path.first

    if start == [0, 0]
      break
    end
    n = nodes[start.first][start.last]
  end

  sum = grid.last.last
  path.reverse.each do |seg|
    puts "segment length=#{seg.size}"
    seg.each do |p|
      next if p == [0, 0]
      puts "(#{p.first},#{p.last}) = #{grid[p.first][p.last]}"
      sum += grid[p.first][p.last]
    end
  end
  puts sum

  grid.size.times do |i|
    grid[i].size.times do |j|
      if path.find{ |seg| seg.include?([i, j]) } or [grid.size-1, grid.last.size-1] == [i,j]
        print '#'
      else
        print '.'
      end
    end
    puts
  end

end

find_path(grid, [0, 0], [grid.size-1, grid.last.size-1])


