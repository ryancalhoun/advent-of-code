class Vertex
  attr_reader :i, :j, :weight
  def initialize(i, j, weight)
    @i, @j = i, j
    @weight = weight

    @from_path = {}
  end
  def min_path(tail)
    tail = (tail || []).reverse.flatten 1
    @from_path.select do |path, cost|
      !tail.include?(path[0]) &&
      (tail.size < 2 ||
      (path.last[0] == loc[0] && tail[1][0] != loc[0]) ||
      (path.last[1] == loc[1] && tail[1][1] != loc[1]))

    end.sort_by {|path,cost| cost}.first.first
  end
  def min_cost
    @from_path.values.min
  end
  def with_min
    @from_path.each do |path, cost|
      yield cost, path + [loc]
    end
  end
  def relevant_part(from_path)
    return from_path if from_path.size < 2

    rpath = from_path.reverse
    i_aligned, is = rpath.chunk {|p| p.first == loc.first }.first
    j_aligned, js = rpath.chunk {|p| p.last == loc.last }.first

    limit = if i_aligned
      limit_to rpath, is, 1
    elsif j_aligned
      limit_to rpath, js, 0
    end

    limit && from_path.last(limit)
  end

  def limit_to(rpath, xs, other)
    if xs.size > 3
      return nil
    end
    if xs.map {|p| p[other] }.uniq.size != xs.size
      return nil
    end
    return xs.size

    if xs.size >= 10
      return nil
    end
    if xs.size == 1 && rpath.first(5).map {|p| p[other] } != [xs[0][other]]*5
      return nil
    end

    vals = xs.map {|p| p[other]}.uniq
    if vals.size != xs.size || vals.include?(loc[other])
      return nil
    end
    xs.size
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
