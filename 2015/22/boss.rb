require_relative 'player'

class Boss < Player
  attr_reader :damage
  def initialize(points, damage)
    super points
    @damage = damage
  end

  def to_s
    "Boss points=#{points}"
  end

  def win
    nil
  end

  def before_turn!
    true
  end

  def take_turn(spent, effects, time, &block)
    attack = Attack.new time, damage
    block.call attack
  end

  class Attack
    attr_reader :name, :damage
    def initialize(time, damage)
      @time = time
      @name = 'boss attack'
      @damage = damage
    end
    #def active_at?(time)
      #@time == time
    #end
  end
end
