require_relative 'type'

class Hand
  TYPES = [
    Type.new('High card', [1,1,1,1,1]),
    Type.new('One pair', [2,1,1,1]),
    Type.new('Two pair', [2,2,1]),
    Type.new('Three of a kind', [3,1,1]),
    Type.new('Full house', [3,2]),
    Type.new('Four of a kind', [4,1]),
    Type.new('Five of a kind', [5]),
  ]

  attr_reader :cards, :type
  def initialize(cards, overrides = {})
    @cards = cards
    @type = get_hand_type overrides
  end

  def <=>(b)
    if type.value == b.type.value
      cards <=> b.cards
    else
      type.value <=> b.type.value
    end
  end

  def get_hand_type(overrides)
    of_a_kind = Hash.new 0
    cards.each do |card|
      of_a_kind[card.to_i] += 1
    end

    wild = overrides.values.map {|v| of_a_kind.delete(v)}.inject(:+) || 0

    TYPES.find {|type| type.matches? of_a_kind.values, jokers: wild }
  end
end

