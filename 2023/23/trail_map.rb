require_relative 'path_segment'

class TrailMap
  def initialize
    @paths = {}
  end
  def trace_paths!(g)
    dead_ends = {}

    q = [PathSegment.new(g.start)]

    until q.empty?
      path = q.shift
      more = g.trace_segment(path)

      if more.empty?
        if path.size == 2 && dead_ends.has_key?(path.finish)
          e = dead_ends.delete path.finish
          e << path.start
          (@paths[e.finish] ||= []) << e
        else
          dead_ends[path.finish] = path
          (@paths[path.start] ||= []) << path
        end
      else
        more.each do |n|
          branch = PathSegment.new path.finish
          branch << n
          q << branch
        end
        (@paths[path.start] ||= []) << path
        (@paths[path.finish] ||= []) << path
      end
    end


    last = dead_ends.values.last
    (@paths[last.finish] ||= []) << last

    @paths
  end

  def strip_uphill!
    @paths.each do |p, segments|
      segments.delete_if do |seg|
        (seg.start == p && seg.uphill) || (seg.finish == p && seg.downhill)
      end
    end
  end

  def find_longest_path
    find_longest_path_from @paths.keys.first, [@paths.keys.first]
  end

  def find_longest_path_from(start, visited)
    if start == @paths.keys.last
      return 0
    end

    @paths[start].map do |p|
      other_end = ([p.start, p.finish] - [start]).first
      next if visited.include?(other_end)

      p.size + find_longest_path_from(other_end, visited + [other_end]) - 1
    end.compact.max.to_i
  end
end
