require 'rspec'
require_relative 'forest'
require_relative 'path_segment'

describe Forest do
  before do
    subject << %w{ # . # # # # # # }
    subject << %w{ # . . # . . . # }
    subject << %w{ # # . # . # . # }
    subject << %w{ # . . . . # . # }
    subject << %w{ # v # # # # . # }
    subject << %w{ # . . > . # . # }
    subject << %w{ # . # # . # . # }
    subject << %w{ # . > . . . . # }
    subject << %w{ # # # # # # . # }
  end

  it 'traces path segments' do
    path = PathSegment.new [0, 1]
    expect(subject.trace_segment path).to eq [[3, 3], [3, 1]]
    expect(path.finish).to eq [3, 2]
    expect(path.size).to eq 5

    path = PathSegment.new [3, 2]
    path << [3, 3]
    expect(subject.trace_segment path).to eq [[8, 6], [7, 5]]
    expect(path.finish).to eq [7, 6]
    expect(path.size).to eq 13

    path = PathSegment.new [3, 2]
    path << [3, 1]
    expect(subject.trace_segment path).to eq [[6, 1], [5, 2]]
    expect(path.finish).to eq [5, 1]
    expect(path.size).to eq 4
    expect(path.downhill).to be_truthy

    path = PathSegment.new [7, 6]
    path << [8, 6]
    expect(subject.trace_segment path).to eq []
    expect(path.finish).to eq [8, 6]
    expect(path.size).to eq 2

    path = PathSegment.new [7, 6]
    path << [7, 5]
    expect(subject.trace_segment path).to eq [[6, 4], [7, 3]]
    expect(path.finish).to eq [7, 4]
    expect(path.size).to eq 3

    # this is a dead-end
    path = PathSegment.new [5, 1]
    path << [6, 1]
    expect(subject.trace_segment path).to eq []
    expect(path.finish).to eq [7, 3]
    expect(path.size).to eq 5
    expect(path.downhill).to be_truthy

    # this is a dead-end
    path = PathSegment.new [5, 1]
    path << [5, 2]
    expect(subject.trace_segment path).to eq []
    expect(path.finish).to eq [6, 4]
    expect(path.size).to eq 5
    expect(path.downhill).to be_truthy
  end

end
