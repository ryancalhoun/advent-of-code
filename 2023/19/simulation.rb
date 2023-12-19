require_relative 'range_object'
class Simulation
  def initialize
    @q = [RangeObject.new(self)]
  end
  def each
    until @q.empty?
      yield @q.shift
    end
  end
  def add(obj)
    @q << RangeObject.new(self, obj)
  end
end
