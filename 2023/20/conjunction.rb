class Conjunction
  attr_reader :name
  def initialize(name)
    @name = name
    @memory = {}
  end
  def onreceive(from)
    @memory[from] = false
    ->(pulse, state) do
      @memory[from] = pulse
      !@memory.values.all?(true)
    end
  end
  def state
    @memory
  end
end
