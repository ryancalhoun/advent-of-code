def hash(str)
  h = 0
  str.each_char do |c|
    h += c.ord
    h *= 17
    h %= 256
  end
  h
end

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
  def to_s
    @lenses.inspect
  end
  def power
    @lenses.each_with_index.map {|l,i| (i+1) * l.last }.sum
  end
end

boxes = {}

input = STDIN.read.strip

sum = 0
input.split(',').each do |step|

  label,focal = /(\w+)(?:=(\d)|-)/.match(step).captures

  h = hash(label)
  box = boxes[h] ||= Box.new

  if focal
    box.add label, focal.to_i
  else
    box.remove label
  end

end
boxes.select {|h,b| !b.empty?}.each {|h,b|
  sum += (h+1) * b.power
}

puts sum

