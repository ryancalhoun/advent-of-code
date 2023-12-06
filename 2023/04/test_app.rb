require 'rspec'
require_relative 'app'

describe App do
  subject { described_class.new part: part }

  context 'part one' do
    let(:part) { 1 }
    it 'counts points' do
      expect(subject.run('sample.txt')).to eq 13
    end
  end
  context 'part two' do
    let(:part) { 2 }
    it 'counts card copies' do
      expect(subject.run('sample.txt')).to eq 30
    end
  end
end
