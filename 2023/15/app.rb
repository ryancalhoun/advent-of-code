require_relative 'box'
require_relative 'hash_fn'

class App
  def initialize(part:)
    @part = part
    @fn = HashFn.new
  end

  def run(filename)
    input = File.open(filename) do |file|
      file.read.strip
    end

    if @part == 1
      input.split(',').map do |step|
        @fn | step
      end.sum
    else
      boxes = {}
      input.split(',').each do |step|
        label,focal = /(\w+)(?:=(\d)|-)/.match(step).captures

        h = @fn | label
        box = boxes[h] ||= Box.new

        if focal
          box.add label, focal.to_i
        else
          box.remove label
        end
      end
      boxes.select {|h,b| !b.empty?}.map do |h,b|
        (h+1) * b.power
      end.sum
    end
  end
end

if __FILE__ == $0
  puts App.new(part: ENV['PART'].to_i).run ARGV[0]
end

