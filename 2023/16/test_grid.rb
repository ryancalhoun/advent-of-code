require 'rspec'
require_relative 'grid'

describe Grid do
  before do
    subject.add_right_mirror! 0, 4
    subject.add_left_mirror! 5, 4
    subject.add_h_splitter! 5, 1
  end
=begin
....\
.....
.....
.....
.....
.|../
=end

  it 'visits the edge' do
    expect {|b| subject.edge :up, 2, 3, &b }.to yield_with_args 0, 3
    expect {|b| subject.edge :down, 2, 3, &b }.to yield_with_args 5, 3
    expect {|b| subject.edge :left, 2, 3, &b }.to yield_with_args 2, 0
    expect {|b| subject.edge :right, 2, 3, &b }.to yield_with_args 2, 4
  end

  it 'visits a row -> right' do
    subject.visit! [0, 1], [0, 4]
    expect(subject.count_visited).to eq 4
  end
  it 'visits a row <- left' do
    subject.visit! [0, 4], [0, 1]
    expect(subject.count_visited).to eq 4
  end
  it 'visits a col v down' do
    subject.visit! [1, 0], [4, 0]
    expect(subject.count_visited).to eq 4
  end
  it 'visits a col ^ up' do
    subject.visit! [4, 0], [1, 0]
    expect(subject.count_visited).to eq 4
  end

=begin
#####
.#..#
.#..#
.#..#
.#..#
.####
=end
  it 'follows the path' do
    subject.shoot! :right, 0, -1
    expect(subject.count_visited).to eq 17
  end
end
