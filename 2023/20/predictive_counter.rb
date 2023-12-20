class PredictiveCounter
  def initialize
    @cycle = {}
    @count = Hash.new(0)
  end
  def onreceive(from)
    ->(pulse, state) do
      @count[pulse] += 1

      state.each do |key, val|
        @cycle[key] ||= nil
        @cycle[key] = @i if val
      end
    end
  end

  def cycle=(i)
    @i = i
  end

  def done?
    @count[false] > 0 || (@cycle.size > 0 && @cycle.values.none?(nil))
  end

  def prediction
    @cycle.values.inject(&:lcm)
  end
end
