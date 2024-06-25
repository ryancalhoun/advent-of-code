class Player
  attr_reader :points, :armor

  def initialize(points, armor = 0)
    @points = points
    @armor = armor
  end

  def alive?
    points > 0
  end

  def apply_all(effects)
    @armor = 0
    effects.each do |e,s|
      apply s, e
    end
  end

  def apply(source, spell)
    if !source.is_a?(self.class) && spell.damage
      @points -= [spell.damage - armor, 1].max
    end
  end
end
