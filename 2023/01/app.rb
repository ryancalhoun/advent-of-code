sum = 0

class String
  def to_num
    case self
    when 'one'
      1
    when 'two'
      2
    when 'three'
      3
    when 'four'
      4
    when 'five'
      5
    when 'six'
      6
    when 'seven'
      7
    when 'eight'
      8
    when 'nine'
      9
    else
      to_i
    end

  end
end



STDIN.each_line do |line|
  puts line
  digits = line.scan(/(?=(\d|one|two|three|four|five|six|seven|eight|nine))/).flatten
  puts digits.inspect
  x = "#{digits.first.to_num}#{digits.last.to_num}".to_i

  sum += x
end

puts sum
