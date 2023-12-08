require 'rspec'
require_relative 'app'

describe App do
  subject { described_class.new part: part }

  context 'part one' do
    let(:part) { 1 }
    it 'finds the path length' do
      expect(subject.run('sample.txt')).to eq 2
      expect(subject.run('sample2.txt')).to eq 6
    end
    it 'expects the starting node to exist' do
      expect { subject.run('sample3.txt') }.to raise_exception(RuntimeError)
    end
  end
  context 'part two' do
    let(:part) { 2 }
    it 'finds the simultaneous path length' do
      expect(subject.run('sample3.txt')).to eq 6
    end
  end
end

