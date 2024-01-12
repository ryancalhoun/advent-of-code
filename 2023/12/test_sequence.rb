require 'rspec'
require_relative 'sequence'

describe Sequence do
  it 'scores .??..??...?##. 1,1,3' do
    subject.add(1, 5, 10)
    expect(subject.score).to eq 1

    subject.add(2, 5, 10)
    expect(subject.score).to eq 2

    subject.add(2, 6, 10)
    expect(subject.score).to eq 4
  end

  it 'scores ?#?.???.??????????# 3,1,3,4' do
    subject.add(0, 4, 8, 15)
    expect(subject.score).to eq 1

    subject.add(0, 5, 8, 15)
    expect(subject.score).to eq 2

    subject.add(0, 6, 8, 15)
    expect(subject.score).to eq 3

    subject.add(0, 6, 9, 15)
    expect(subject.score).to eq 6

    subject.add(0, 6, 10, 15)
    expect(subject.score).to eq 9

    subject.add(0, 8, 10, 15)
    expect(subject.score).to eq 10

    subject.add(0, 8, 11, 15)
    expect(subject.score).to eq 14

    subject.add(0, 9, 11, 15)
    expect(subject.score).to eq 15
  end

=begin
    ????#???..?.?? 5,1,1
    #####.#...#...  <<<
    #####..#..#...  <<<
    .#####.#..#...  <<<
    #####.#.....#.
    #####..#....#.
    .#####.#....#.  <<<
    #####.....#.#.
    .#####....#.#.  <<<
    ..#####...#.#.  <<<
    ...#####..#.#.  <<<
    #####.#......#
    #####..#.....#
    .#####.#.....#
    #####.....#..#
    .#####....#..#
    ..#####...#..#
    ...#####..#..#  <<< 
=end
  it 'scores ????#???..?.?? 5,1,1' do
    subject.add(0, 6, 10)
    expect(subject.score).to eq 1

    subject.add(0, 7, 10)
    expect(subject.score).to eq 2

    subject.add(1, 7, 10)
    expect(subject.score).to eq 3

    subject.add(1, 7, 12)
    expect(subject.score).to eq 6

    subject.add(1, 10, 12)
    expect(subject.score).to eq 8

    subject.add(2, 10, 12)
    expect(subject.score).to eq 9

    subject.add(3, 10, 12)
    expect(subject.score).to eq 10

    subject.add(3, 10, 13)
    expect(subject.score).to eq 17
  end

  it 'scores ???..#?#????? 1,3' do
    subject.add(0, 5)
    expect(subject.score).to eq 1

    subject.add(1, 5)
    expect(subject.score).to eq 2

    subject.add(2, 5)
    expect(subject.score).to eq 3

    subject.add(5, 7)
    expect(subject.score).to eq 4
  end

  it '???#.?????.??? 1,1,2,2' do
    subject.add(0, 3, 5, 8)
    expect(subject.score).to eq 1

    subject.add(1, 3, 5, 8)
    expect(subject.score).to eq 2

    subject.add(1, 3, 5, 11)
    expect(subject.score).to eq 4

    subject.add(1, 3, 6, 11)
    expect(subject.score).to eq 6

    subject.add(1, 3, 7, 11)
    expect(subject.score).to eq 8

    subject.add(3, 5, 7, 11)
    expect(subject.score).to eq 9

    subject.add(3, 5, 8, 11)
    expect(subject.score).to eq 12

    subject.add(3, 6, 8, 11)
    expect(subject.score).to eq 13

    subject.add(3, 6, 8, 12)
    expect(subject.score).to eq 24
  end
end
