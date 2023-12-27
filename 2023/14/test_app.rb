require 'rspec'
require_relative 'app'

describe App do
  subject { described_class.new part: part }

  context 'part one' do
    let(:part) { 1 }
    it 'finds the load score' do
      expect(subject.run 'sample.txt').to eq 136
    end
  end
  context 'part two' do
    let(:part) { 2 }
    it 'extrapolates a bunch of cycles' do
      expect(subject.run 'sample.txt').to eq 64
    end
  end
end
