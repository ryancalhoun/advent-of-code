class Stack
  def initialize
    @falling = []
    @settled = []
    @supported = {}
    @supporting = {}
  end

  def add(brick)
    @falling << brick
  end

  def initialize_tops
    tops = []
    10.times do
      tops << []
      10.times do
        tops.last << nil
      end
    end
    tops
  end

  def settle!
    tops = initialize_tops

    @falling.sort_by(&:bottom).each do |brick|

      below = brick.x.map {|x|
        tops[x][brick.y]
      }.flatten.compact.uniq

      floor = below.map {|i| @settled[i].z.end }.max

      if floor
        @supported[@settled.size] = below.select {|i| @settled[i].z.end == floor }
      
        below.select {|i| @settled[i].z.end == floor }.each do |i|
          (@supporting[i] ||= []) << @settled.size
        end
      else
        floor = 0
      end 

      brick.drop! floor + 1

      brick.x.each do |x|
        brick.y.each do |y|
          tops[x][y] = @settled.size
        end
      end
      @settled << brick
    end
    @falling = []
  end

  def count_chain_reactions
    chains = 0
    @settled.each_with_index do |s,i|
      chains += count_chains_from [i], []
    end
    chains
  end
  def count_chains_from(check, removed)
    those = check.map {|i| @supporting[i] }.flatten.uniq.compact
    return 0 if those.empty?

    only_by_these = those.select do |j|
      (@supported[j] - check - removed).empty?
    end
    return 0 if only_by_these.empty?

    only_by_these.size + count_chains_from(only_by_these, check+removed)
  end

  def count_safe
    safe = {}
    @settled.each_with_index do |s,i|
      safe[i] = true
      if by = @supported[i]
        if by.size == 1
          safe.delete by.first
        end
      end
    end 

    safe.size
  end
end
