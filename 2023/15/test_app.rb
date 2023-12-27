require 'rspec'
require_relative 'app'

describe App do
  subject { described_class.new part: part }

  context 'part one' do
    let(:part) { 1 }
    it 'checks the hash' do
      expect(subject.run 'sample.txt').to eq 1320
    end
  end
  context 'part two' do
    let(:part) { 2 }
    it 'finds the focusing power' do
      expect(subject.run 'sample.txt').to eq 145
    end
  end
end
