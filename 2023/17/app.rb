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
  end
  def with_min
    #@from_path.select {|path, cost| cost == min }.each do |path, cost|
    @from_path.each do |path, cost|
      yield cost, path + [loc]
    end
  end
  def add(v)
    @neighbors << v
    v.add(self)
  end
  def relevant_part(from_path)
    return nil if from_path[-2] == loc
    return from_path if from_path.size < 3

    i_aligned, is = from_path.reverse.chunk {|p| p.first == loc.first }.first
    j_aligned, js = from_path.reverse.chunk {|p| p.last == loc.last }.first

    return nil if (i_aligned && is.size > 3) || (j_aligned && js.size > 3)

    return from_path.last([is.size, js.size].min)
  end
  def visit!(cost, from_path)
    if from = relevant_part(from_path)
      potential_cost = cost + (from.empty? ? 0 : @weight)
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
  puts nodes.last.last.inspect
  puts nodes.last.last.min_cost
end

find_path(grid, [0, 0], [grid.size-1, grid.last.size-1])


