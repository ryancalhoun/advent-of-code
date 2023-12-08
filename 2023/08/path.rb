class Path
  attr_reader :start, :stop, :current, :directions, :length
  def initialize(start, stop, directions)
    @start, @stop, @directions = start, stop, directions

    @current = start
    @length = 0
  end
  def next_direction
    directions[ length % directions.size ]
  end
  def go_to(node)
    @current = node
    @length += 1
  end
  def done?
    if stop.respond_to? :call
      stop.call current
    else
      stop == current
    end
  end
end

