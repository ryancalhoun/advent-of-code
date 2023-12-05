require 'rspec'

require_relative 'app'

describe App do
  subject { described_class.new part: part }

  context 'part one' do
    let(:part) { 1 }

    it 'finds all parts' do
      expect(subject.run('sample.txt')).to eq 4361
    end
  end

  context 'part two' do
    let(:part) { 2 }

    it 'finds all gear ratios' do
      expect(subject.run('sample.txt')).to eq 467835
    end
  end
end
