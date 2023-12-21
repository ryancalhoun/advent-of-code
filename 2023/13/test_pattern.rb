require 'rspec'
require_relative 'pattern'

describe Pattern do
=begin
    #..##
    .##.
    #..#
=end
  before do
    subject.score! 0, 0
    subject.score! 0, 3
    subject.score! 0, 4
    subject.score! 1, 1
    subject.score! 1, 2
    subject.score! 2, 0
    subject.score! 2, 3
  end

  it 'finds the reflection' do
    expect(subject.row_reflection).to eq 0
    expect(subject.col_reflection).to eq 2
  end
  it 'finds the similar rows' do
    expect { |b| subject.row_similar &b }.to_not yield_control
  end
  it 'finds the similar cols' do
    expect { |b| subject.col_similar &b }.to yield_with_args(2, 3, 4)
  end

  context 'toggle' do
    before do
      subject.toggle! 2, 4
    end
  it 'finds the reflection' do
    expect(subject.col_reflection).to eq 2
    expect(subject.col_reflection skip: 2).to eq 4
  end
  end
end
