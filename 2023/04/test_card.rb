require 'rspec'
require_relative 'card'

describe Card do
  context 'parse' do
    subject { described_class.parse('Card 4: 1 2 3 | 4 5 6') }
    it 'parses the line' do
      expect(subject.num).to eq 4
      expect(subject.winning).to eq [1, 2, 3]
      expect(subject.have).to eq [4, 5, 6]
    end
  end

  context 'matches' do
    subject { described_class.new 4, [41, 48, 83, 86, 17], [83, 86, 6, 31, 17, 9, 48, 53] }

    it 'finds matches' do
      expect(subject.count_matches).to eq 4
      expect(subject.points).to eq 8
    end

  end
  context 'no matches' do
    subject { described_class.new 4, [1, 2, 3], [4, 5, 6] }

    it 'finds matches' do
      expect(subject.count_matches).to eq 0
      expect(subject.points).to eq 0
    end

  end
end
