class Equation
  def initialize(s_i, s_j)
    @s_i, @s_j = s_i, s_j
  end
  def x0
    @s_i.vy - @s_j.vy
  end
  def y0
    @s_j.vx - @s_i.vx
  end
  def vx
    @s_j.y - @s_i.y
  end
  def vy
    @s_i.x - @s_j.x
  end
  def b
    @s_i.x*@s_i.vy - @s_i.y*@s_i.vx - @s_j.x*@s_j.vy + @s_j.y*@s_j.vx
  end
end
