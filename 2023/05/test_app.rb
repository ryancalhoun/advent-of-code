require 'rspec'

require_relative 'app'

describe App do
  context 'part one' do
    subject { described_class.new part: 1 }

    before do
      subject.load_maps! 'sample.txt'
    end

    it 'loads the data' do
      expect(subject.start).to eq 'seed'
      expect(subject.finish).to eq 'location'

      expect(subject.sources).to eq ["seed", "soil", "fertilizer", "water", "light", "temperature", "humidity"]
    end

    it 'looks up the location value' do
      expect(subject.get_value 79).to eq 82
      expect(subject.get_value 14).to eq 43
      expect(subject.get_value 55).to eq 86
      expect(subject.get_value 13).to eq 35
    end

    it 'finds the lowest location' do
      expect(subject.find_min_finish).to eq 35
    end
  end

  context 'part two' do
    subject { described_class.new part: 2 }

    before do
      subject.load_maps! 'sample.txt'
    end

    it 'looks up the location range' do
      expect(subject.get_ranges 79..92).to eq [46..55, 60..60, 82..84]
      expect(subject.get_ranges 55..67).to eq [56..59, 86..89, 94..96, 97..98]
    end

    it 'finds the lowest location' do
      expect(subject.find_min_finish).to eq 46
    end
  end
end
