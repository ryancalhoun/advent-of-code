require 'rspec'

require_relative 'app'

describe App do
  subject { described_class.new part: part }

  context 'part one' do
    let(:part) { 1 }
    it 'finds the sum' do
      expect(subject.run('sample.txt')).to eq 114
    end
  end

  context 'part two' do
    let(:part) { 2 }
    it 'finds the sum' do
      expect(subject.run('sample.txt')).to eq 2
    end
  end
end
