class Pair
  attr_reader :count
  def initialize
    @a = []
    @b = []
    @count = 0
  end
  def add(a, b)
    if @a.last != a
      @a << a
    end
    if @b.last != b
      @b << b
      @count += @a.size - 1
    end
    @count += 1
  end
end
