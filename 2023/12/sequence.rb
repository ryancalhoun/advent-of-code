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
            @accum[i] += @accum[last]
            @accum[last] = 0
          end
          
          last = i
        end
      end


      m = 1 + (0..last-1).map {|j| @accum[j] }.sum
      @score += m
      @accum[last] += m

      puts "  last=#{last} accum=#{@accum}"
      puts "  score=#{@score}"
    end
    @s = s
  end
end
