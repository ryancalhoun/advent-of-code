require 'rspec'
require_relative 'grid'

describe Grid do
=begin
.#.
OOO
.#.
=end
  before do
    subject.add_rolling 1, 0
    subject.add_rolling 1, 1
    subject.add_rolling 1, 2
    subject.add_fixed 0, 1
    subject.add_fixed 2, 1
    subject.touch 2, 2
  end

  it 'calculates the load' do
    expect(subject.load_score).to eq 2+2+2
  end

=begin
O#O
.O.
.#.
=end
  it 'tilts north' do
    subject.tilt_n!
    expect(subject.load_score).to eq 3+2+3
  end

=begin
.#.
.O.
O#O
=end
  it 'tilts south' do
    subject.tilt_s!
    expect(subject.load_score).to eq 1+2+1
  end

=begin
O#O
.O.
.#.

O#O
O..
.#.

.#.
O..
O#O

.#.
..O
O#O
=end
  it 'cycles' do
    subject.cycle!
    expect(subject.load_score).to eq 1+2+1
  end
  it 'extrapolates' do
    expect(subject.extrapolate! 100).to eq 1+2+1
  end
end
