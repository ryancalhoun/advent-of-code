class Sequence
  attr_reader :score
  def initialize
    @s = []
    @score = 0
    @accum = Hash.new(0)
  end
  def add(*s)
    puts "ADD #{s}"
    if @s.empty?
      @score = 1
    else
      last = -1
      s.each_with_index do |v,i|
        if v != @s[i]
          if last >= 0
            @accum[last] = 0
          end
          
          last = i
        end
      end

      puts "  last=#{last} accum=#{@accum}"

      m = 1 + (0..last-1).map {|j| @accum[j] }.sum
      @score += m
      @accum[last] += m
    end
    @s = s
  end
end
