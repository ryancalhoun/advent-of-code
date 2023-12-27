require 'rspec'
require_relative 'stack'
require_relative 'brick'

describe Stack do

  context 'all flat' do
=begin
      2 3
      2 3
      1 1
=end
    before do
      subject.add Brick.new 1..2, 1..1, 4..4
      subject.add Brick.new 1..1, 2..3, 7..7
      subject.add Brick.new 2..2, 2..3, 2..2
      subject.settle!
    end
    it 'finds all are safe' do
      expect(subject.count_safe).to eq 3
    end
    it 'finds chains' do
      expect(subject.count_chain_reactions).to eq 0
    end
  end

  context 'all stacked' do
=begin
      from side

      2 2
        1 1
          3 3
=end
    before do
      subject.add Brick.new 2..3, 1..1, 4..4
      subject.add Brick.new 1..2, 1..1, 7..7
      subject.add Brick.new 3..4, 1..1, 2..2
      subject.settle!
    end
    it 'finds top is safe' do
      expect(subject.count_safe).to eq 1
    end
    it 'finds chains' do
      expect(subject.count_chain_reactions).to eq 0 + 1 + 2
    end
  end

  context 'one on top' do
=begin
      from side

        1 1
      2 2 3 3
=end
    before do
      subject.add Brick.new 2..3, 1..1, 7..7
      subject.add Brick.new 1..2, 1..1, 4..4
      subject.add Brick.new 3..4, 1..1, 2..2
      subject.settle!
    end
    it 'finds all three are safe' do
      expect(subject.count_safe).to eq 3
    end
    it 'finds chains' do
      expect(subject.count_chain_reactions).to eq 0
    end
  end

  context 'two on top' do
=begin
      from side

      2 2 3 3
        1 1
=end
    before do
      subject.add Brick.new 2..3, 1..1, 2..2
      subject.add Brick.new 1..2, 1..1, 4..4
      subject.add Brick.new 3..4, 1..1, 7..7
      subject.settle!
    end
    it 'finds top two are safe' do
      expect(subject.count_safe).to eq 2
    end
    it 'finds chains' do
      expect(subject.count_chain_reactions).to eq 2
    end
  end
end
