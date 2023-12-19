class Simulation
  def initialize
    @obj = { 'm' => 4, 'a' => 2, 'x' => 7, 's' => 9 }
  end
  def values
    @obj.values
  end
  def [](key)
    @obj[key]
  end
end

