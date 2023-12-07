class Card
  VALUES = %w[A K Q J T 9 8 7 6 5 4 3 2]

  attr_reader :value, :order

  def initialize(value, overrides = {})
    @value = value
    @order = overrides[value] || (VALUES.size - VALUES.index(value) + 1)
  end

  def to_i
    order
  end

  def <=>(b)
    @order <=> b.order
  end
end

