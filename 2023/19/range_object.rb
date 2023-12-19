require_relative 'rule_eval.rb'

class RangeObject
  def initialize(sim, obj = nil)
    @sim = sim
    @obj = obj || {
      'm' => 1..4000,
      'a' => 1..4000,
      'x' => 1..4000,
      's' => 1..4000,
    }
  end
  def values
    [@obj.values.map {|r| r.size }.inject(:*)]
  end
  def [](key)
    RuleEval.new self, key
  end
  def lt(limit, key)
    toslice = @obj[key]
    slice key, toslice.first..[toslice.last, limit-1].min, [toslice.first, limit].max..toslice.last
  end

  def gt(limit, key)
    toslice = @obj[key]
    slice key, [toslice.first, limit+1].max..toslice.last, toslice.first..[toslice.last, limit].min
  end

  def slice(key, if_true, if_false)
    if if_true.size > 0
      @obj[key] = if_true

      if if_false.size > 0
        @sim.add @obj.merge key => if_false
      end
      true
    else
      @obj[key] = if_false
      false
    end
  end
end
