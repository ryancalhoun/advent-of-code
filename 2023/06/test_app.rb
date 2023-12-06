require 'rspec'

require_relative 'app'

describe App do
  context 'part one' do
    subject { described_class.new part: 1 }

    it 'treats spaces as spaces' do
      expect(subject.str_to_data('1 2 3')).to eq [1, 2, 3]
    end

    it 'reads the race data' do
      subject.load_race_input! 'sample.txt'
      expect(subject.times).to eq [7, 15, 30]
      expect(subject.records).to eq [9, 40, 200]
    end

    it 'multiplies ways to win' do
      expect(subject.run('sample.txt')).to eq 288
    end
  end

  context 'part two' do
    subject { described_class.new part: 2 }

    it 'treats spaces as nothing' do
      expect(subject.str_to_data('1 2 3')).to eq [123]
    end

    it 'reads the race data' do
      subject.load_race_input! 'sample.txt'
      expect(subject.times).to eq [71530]
      expect(subject.records).to eq [940200]
    end

    it 'counts ways to win' do
      expect(subject.run('sample.txt')).to eq 71503
    end
  end
end
