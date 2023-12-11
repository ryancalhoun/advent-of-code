require_relative 'pipe'

class Spot
  attr_reader :i, :j, :pipe, :visited, :enclosed
  def initialize(i, j, &if_start)
    @i, @j = i, j
    @if_start = if_start
    @pipe = nil
    @visited = false
    @enclosed = false
  end
  def add(char)
    pipe = Pipe.new char
    @pipe = pipe unless pipe.ground?
    @if_start.call(self) if pipe.start?
  end
  def connected?(to)
    return false unless @pipe && to.pipe

    if above?(to)
      pipe.bottom? && to.pipe.top?
    elsif below?(to)
      pipe.top? && to.pipe.bottom?
    elsif left?(to)
      pipe.right? && to.pipe.left?
    elsif right?(to)
      pipe.left? && to.pipe.right?
    end
  end
  def visit!
    @visited = true
  end
  def enclose!
    @enclosed = true
  end
  def above?(to)
    i == to.i - 1 && j == to.j
  end
  def below?(to)
    i == to.i + 1 && j == to.j
  end
  def left?(to)
    i == to.i && j == to.j - 1
  end
  def right?(to)
    i == to.i && j == to.j + 1
  end
end
