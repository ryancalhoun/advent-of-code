require 'rspec'
require_relative './app'

describe App do
  subject { described_class.new part: part }

  context 'part one' do
    let(:part) { 1 }

    it 'finds the sum of first and last digits' do
      expect(subject.run('sample.txt')).to eq 142
    end
  end

  context 'part two' do
    let(:part) { 2 }

    it 'finds the sum of first and last digits' do
      expect(subject.run('sample2.txt')).to eq 281
    end
  end
end
