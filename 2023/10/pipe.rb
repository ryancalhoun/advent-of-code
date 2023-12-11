class Pipe
  attr_reader :type
  def initialize(type)
    @type = type
  end
  def start?
    type == 'S'
  end
  def ground?
    type == '.'
  end
  def top?
    ['|', 'L', 'J'].include?(type) || start?
  end
  def bottom?
    ['|', '7', 'F'].include?(type) || start?
  end
  def left?
    ['-', '7', 'J'].include?(type) || start?
  end
  def right?
    ['-', 'F', 'L'].include?(type) || start?
  end
end

