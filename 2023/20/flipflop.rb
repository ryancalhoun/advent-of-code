class Flipflop
  attr_reader :name
  def initialize(name)
    @name = name
    @on = false
  end
  def onreceive(from)
    ->(pulse, state) do
      if !pulse
        @on = !@on
      end
    end
  end
  def state
    @on
  end
end
