class Box
  def initialize
    @lenses = []
  end
  def add(label, focal)
    if e = @lenses.find {|l| l.first == label}
      e[1] = focal
    else
      @lenses << [label, focal]
    end
  end
  def remove(label)
    @lenses.delete_if {|l| l.first == label}
  end
  def empty?
    @lenses.empty?
  end
  def power
    @lenses.each_with_index.map {|l,i| (i+1) * l.last }.sum
  end
end

