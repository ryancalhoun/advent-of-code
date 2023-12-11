require 'rspec'
require_relative 'app'

describe App do
  subject { described_class.new part: part }

  context 'part one' do
    let(:part) { 1 }
    it 'finds the distance - 1' do
      expect(subject.run('sample.txt')).to eq 4
    end
    it 'finds the distance - 2' do
      expect(subject.run('sample2.txt')).to eq 4
    end
    it 'finds the distance - 3' do
      expect(subject.run('sample3.txt')).to eq 8
    end
  end
  context 'part two' do
    let(:part) { 2 }
    it 'counts enclosed - 4' do
      expect(subject.run('sample4.txt')).to eq 4
    end
    it 'counts enclosed - 5' do
      expect(subject.run('sample5.txt')).to eq 8
    end
    it 'counts enclosed - 6' do
      expect(subject.run('sample6.txt')).to eq 10 
    end
  end
end
