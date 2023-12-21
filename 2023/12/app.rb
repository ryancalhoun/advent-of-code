require_relative 'trial'

class App
  def initialize(part:)
    @part = part
  end
  def run(filename)
    total = 0
    File.open(filename) do |f|
      f.each_line do |line|
        t = Trial.parse(line)
        t.unfold! unless @part == 1
        t.run!

        t_sum = t.count_arrangements
  
        total += t_sum
      end
    end
    total
  end
end

if __FILE__ == $0
  puts App.new(part: ENV['PART'].to_i).run ARGV[0]
end
