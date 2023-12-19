class Destination
  def initialize
    @objects = []
  end
  def process(object)
    @objects << object
    nil
  end
  def sum
    @objects.map {|obj| obj.values.sum}.sum
  end
end

