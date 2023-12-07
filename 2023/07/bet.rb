class Bet
  attr_reader :hand, :amount
  def initialize(hand, amount)
    @hand = hand
    @amount = amount
  end
  def <=>(b)
    hand <=> b.hand
  end
end

