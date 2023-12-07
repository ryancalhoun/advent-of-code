class Type
  @@value = 0

  attr_reader :name, :value
  def initialize(name, distribution)
    @name = name
    @value = @@value += 1
    @distribution = distribution.sort
  end

  def matches?(distribution, jokers: 0)
    d = distribution.sort
    if d.empty?
      d << jokers
    else
      d[-1] += jokers
    end

    @distribution == d
  end
end
