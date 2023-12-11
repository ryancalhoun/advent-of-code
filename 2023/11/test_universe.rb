require 'rspec'
require_relative 'universe'

describe Universe do
  subject { described_class.new rate: rate }
  let(:rate) { 2 }

  let(:g1) { Galaxy.new 0, 0 }
  let(:g2) { Galaxy.new 1, 2 }
  let(:g3) { Galaxy.new 3, 3 }
=begin
  #...
  ..#.
  ....
  ...#
=end

  before do
    subject.add_galaxy g1
    subject.add_galaxy g2
    subject.add_galaxy g3
  end

  it 'finds the width and height' do
    expect {|b| subject.max_size &b }.to yield_with_args(4, 4)
  end

  it 'lists all galaxy pairs' do
    expect {|b| subject.each_pair &b }.to yield_successive_args([g1, g2], [g1, g3], [g2, g3])
  end

  it 'finds path lengths' do
    expect(subject.find_shortest_paths).to eq [3, 6, 3]
  end

  context 'expanded' do
=begin
    #....
    ...#.
    .....
    .....
    ....#
=end
    before do
      subject.expand!
    end
    it 'finds the width and height' do
      expect {|b| subject.max_size &b }.to yield_with_args(5, 5)
    end
    it 'finds path lengths' do
      expect(subject.find_shortest_paths).to eq [4, 8, 4]
    end
  end
  context 'expanded more' do
=begin
    #............
    ...........#.
    .............
    .............
    .............
    .............
    .............
    .............
    .............
    .............
    .............
    .............
    ............#
=end
    let(:rate) { 10 }
    before do
      subject.expand!
    end
    it 'finds the width and height' do
      expect {|b| subject.max_size &b }.to yield_with_args(13, 13)
    end
    it 'finds path lengths' do
      expect(subject.find_shortest_paths).to eq [12, 24, 12]
    end
  end
end
