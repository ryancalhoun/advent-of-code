require 'rspec'

require_relative 'schematic'

class MockPart
  def initialize(val)
    @val = val
  end
  def ==(p)
    @val == p.value
  end
end
class MockGear
  def initialize(ratio)
    @ratio = ratio
  end
  def ==(g)
    @ratio == g.ratio
  end
end

describe Schematic do
  context 'part one' do
    before do
      subject.add_digit(1, 0, 0)
      subject.add_digit(2, 0, 1)
      subject.add_symbol('&', 0, 2)

      subject.add_digit(3, 2, 0)
      subject.add_digit(4, 2, 1)
      subject.add_symbol('&', 2, 8)

      subject.add_digit(5, 4, 0)
      subject.add_digit(6, 4, 1)
      subject.add_symbol('&', 5, 1)
    end

    it 'lists each part by a symbol' do
      expect {|b| subject.each_part(&b) }.to yield_successive_args(MockPart.new(12), MockPart.new(56))
    end
  end

  context 'part two' do
    before do
      subject.add_digit(1, 0, 0)
      subject.add_digit(2, 0, 1)
      subject.add_symbol('*', 0, 2)

      subject.add_digit(3, 1, 2)
      subject.add_digit(4, 1, 3)

      subject.add_digit(5, 4, 0)
      subject.add_digit(6, 4, 1)
      subject.add_symbol('*', 5, 1)
    end

    it 'lists each gear' do
      expect {|b| subject.each_gear(&b) }.to yield_successive_args(MockGear.new(12*34))
    end
  end
end
