class Bounce
  def self.left_mirror(i, j)
    new i, j, ({
      up:    [:right],
      down:  [:left],
      left:  [:down],
      right: [:up],
    })
  end
  def self.right_mirror(i, j)
    new i, j, ({
      up:    [:left],
      down:  [:right],
      left:  [:up],
      right: [:down],
    })
  end
  def self.splitter(i, j)
    new i, j, ({
      up:    [:left, :right],
      down:  [:left, :right],
      left:  [:up, :down],
      right: [:up, :down],
    })
  end

  attr_reader :i, :j
  def initialize(i, j, bounce)
    @i, @j = i, j
    @bounce = bounce
    @hit = []
  end
  def hit(dir)
    return if @hit.include?(dir)
    @hit << dir

    @bounce[dir].each do |d|
      yield d
    end
  end 
  def reset!
    @hit = []
  end
end

