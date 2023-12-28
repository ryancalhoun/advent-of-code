class Area
  def initialize(bounds)
    @bounds = bounds
  end

  def count_future_intersections(stones)
    count = 0
    stones.size.times do |i|
      (stones.size - i - 1).times do |j|
        s1 = stones[i]
        s2 = stones[i+j+1]

        x, y = s1.intersection(s2)

        if @bounds.include?(x) && @bounds.include?(y)
          count += 1
        end
      end
    end
    count
  end
end
