class PathSegment
  attr_reader :start, :finish, :size
  attr_accessor :uphill, :downhill

  def initialize(start)
    @start = start
    @finish = start
    @size = 0
    @uphill = false
    @downhill = false
  end
  def <<(p)
    @size += 1
    @finish = p
  end
  def leftof?(p)
    if @finish == p
      @start.last < p.last
    else
      @finish.last < p.last
    end
  end
  def rightof?(p)
    if @finish == p
      @start.last > p.last
    else
      @finish.last > p.last
    end
  end
  def above?(p)
    if @finish == p
      @start.first < p.first
    else
      @finish.first < p.first
    end
  end
  def below?(p)
    if @finish == p
      @start.first > p.first
    else
      @finish.first > p.first
    end
  end
end

