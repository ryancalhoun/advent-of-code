class Covering
  attr_reader :uncovered
  def initialize(range)
    @range = range

    @covered = []
    @uncovered = @range.size
  end

  def cover!(range)
    @covered << range
    @covered.sort_by! &:first

    @uncovered = 0

    last = @range.first - 1
    @covered.each do |c|
      diff = c.first - last - 1
      if diff > 0
        @uncovered += diff
      end
      last = c.last
    end

    if last < @range.last
      @uncovered += @range.last - last
    end
  end

  def first_after(i)
    @covered.each do |c|
      next if i > c.last
      break if i < c.first
      i = c.last + 1
    end
    i
  end 
  def last_before(i)
    @covered.reverse.each do |c|
      next if i < c.first
      break if i > c.last
      i = c.first - 1
    end
    i
  end 

  def covered?
    @uncovered == 0
  end
end
