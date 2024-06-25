require_relative 'player'
require_relative 'spellbook'

class Wizard < Player
  @@book = Spellbook.load

  def initialize(points, mana)
    super points
    @mana = mana
    @cast = []
  end

  def to_s
    "Wizard points=#{points} armor=#{armor} mana=#{@mana}"
  end

  def win
    spent
  end

  def spent
    @cast.map(&:cost).sum
  end

  def before_turn!
    @points -= 1
    alive?
  end

  def apply(source, spell)
    if source.is_a?(self.class)
      @mana += spell.mana.to_i
      @armor += spell.armor.to_i
    else
      super source, spell
    end
  end

  def take_turn(spent, effects, time, &block)
    @@book.each do |kind|
      next if effects.is_active?(time+1, kind)

      spell = kind.new(time)
      next if spell.cost > @mana

      next if spent.amount && self.spent + spell.cost > spent.amount

      @mana -= spell.cost
      @cast << spell

      if spell.active_at?(time)
        @points += spell.heal.to_i
        block.call spell
        @points -= spell.heal.to_i
      else
        effects.add spell, self
        block.call
        effects.remove spell
      end

      @cast.pop
      @mana += spell.cost
    end
  end
end
