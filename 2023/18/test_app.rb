require 'rspec'
require_relative 'app'

describe App do
  subject { described_class.new part: part }

  context 'part one' do
    let(:part) { 1 }
    it 'counts volume' do
      expect(subject.run('sample.txt')).to eq 62
    end
  end
  context 'part one' do
    let(:part) { 2 }
    it 'counts volume' do
      expect(subject.run('sample.txt')).to eq 952408144115
    end
  end
end
