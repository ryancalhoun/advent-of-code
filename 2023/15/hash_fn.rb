class HashFn
  def |(str)
    h = 0
    str.each_char do |c|
      h += c.ord
      h *= 17
      h %= 256
    end
    h
  end
end
