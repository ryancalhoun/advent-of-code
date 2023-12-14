
a = [205, 180, 259, 259, 180, 204, 181]
b = [77, 12, 115, 33, 82, 82, 33, 115, 12]

c = [305, 289, 460, 223, 223, 460, 289]
d = [91, 24, 60, 60, 25, 67, 60, 60, 103]

def each_similar(list)
  list.size.times do |i|
    (list.size - 1 - i).times do |j|
      a = list[i]
      b = list[i+j+1]
      diff = (a-b).abs

      n = Math.log2(diff)

      if n % 1 == 0
        puts "i=#{i} j=#{i+j+1} n=#{n}"
      end
    end
  end
end

puts "A"
each_similar a

puts
puts "B"
each_similar b

puts
puts "C"
each_similar c

puts
puts "D"
each_similar d
