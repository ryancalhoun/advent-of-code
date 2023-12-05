class App
  DIGITS = {
    'one'   => 1,
    'two'   => 2,
    'three' => 3,
    'four'  => 4,
    'five'  => 5,
    'six'   => 6,
    'seven' => 7,
    'eight' => 8,
    'nine'  => 9,
  }

  def initialize(part:)
    @part = part
  end

  def run(filename)
    sum = 0
    File.open(filename) do |f|
      f.each_line do |line|
        sum += first_and_last(line_to_digits(line).map {|s| str_to_i(s)})
      end
    end
    sum
  end

  def str_to_i(str)
    DIGITS[str] || str.to_i
  end

  def line_to_digits(line)
    if @part == 1
      line.scan(/\d/).flatten
    else
      line.scan(/(?=(\d|one|two|three|four|five|six|seven|eight|nine))/).flatten
    end
  end

  def first_and_last(digits)
    "#{digits.first}#{digits.last}".to_i
  end
end

if __FILE__ == $0
  puts App.new(part: ENV['PART'].to_i).run(ARGV[0])
end
