require 'rspec'
require_relative 'app'

describe App do
  subject { described_class.new part: part }

  context 'part one' do
    let(:part) { 1 }
    it 'finds the shortest paths' do
      expect(subject.run 'sample.txt').to eq 374
    end
  end

  context 'part two' do
    let(:part) { 2 }
    it 'finds the shortest paths' do
      expect(subject.run 'sample.txt').to eq 82000210
    end
  end
end
