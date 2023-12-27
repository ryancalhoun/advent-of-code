require_relative 'brick'
require_relative 'stack'

class App
  def initialize(part:)
    @part = part
  end

  def run(filename)
    stack = Stack.new
    File.open(filename) do |f|
      f.each_line do |line|
        stack.add Brick.parse line
      end
    end

    stack.settle!

    if @part == 1
      stack.count_safe
    else
      stack.count_chain_reactions
    end
  end
end

if __FILE__ == $0
  puts App.new(part: ENV['PART'].to_i).run ARGV[0]
end
