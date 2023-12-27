require 'rspec'
require_relative 'trail_map'

    # . # # # # # #
    # . . # . . . #
    # # . # . # . #
    # . . > . # v #
    # . # # # # . #
    # . . . . # v #
    # . # # . # . #
    # . . . . . . #
    # # # # # # . #

class MockForest
  def initialize
    @segments = {
      [0, 1] => {
        finish: [3, 2],
        size: 5,
        continue: [[3, 3], [3, 1]],
      },
      [3, 3] => {
        finish: [7, 6],
        size: 13,
        continue: [[8, 6], [7, 5]],
        uphill: true
      },
      [3, 1] => {
        finish: [5, 1],
        size: 4,
        continue: [[6, 1], [5, 2]],
      },
      [8, 6] => {
        finish: [8, 6],
        size: 2,
        continue: [],
      },
      [7, 5] => {
        finish: [7, 4],
        size: 3,
        continue: [[6, 4], [7, 3]],
      },
      [6, 1] => {
        finish: [7, 3],
        size: 5,
        continue: [],
      },
      [5, 2] => {
        finish: [6, 4],
        size: 5,
        continue: [],
      },
      [6, 4] => {
        finish: [6, 4],
        size: 2,
        continue: []
      },
      [7, 3] => {
        finish: [7, 3],
        size: 2,
        continue: []
      },
    }
  end
  def trace_segment(p)
    s = @segments[p.finish]
    raise unless s

    until p.size == s[:size]
      p << s[:finish]
    end

    p.uphill = s[:uphill]

    s[:continue]
  end
end

describe TrailMap do
  let(:forest) { MockForest.new }

  before do
    allow(forest).to receive(:start).and_return [0, 1]
    subject.trace_paths! forest
  end

  context 'only downhill' do
    before do
      subject.strip_uphill!
    end

    it 'finds the longest path' do
      expect(subject.find_longest_path).to eq 15
    end
  end

  context 'either way' do
    it 'finds the longest path' do
      expect(subject.find_longest_path).to eq 23
    end
  end
end
