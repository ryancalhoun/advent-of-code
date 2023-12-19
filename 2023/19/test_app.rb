require 'rspec'
require_relative 'app'

describe App do
  subject { described_class.new part: part }

  context 'part one' do
    let(:part) { 1 }
    it 'sums the accepted parts' do
      expect(subject.run('sample.txt')).to eq 19114
    end
  end
  context 'part two' do
    let(:part) { 2 }
    it 'finds all the possible accepted combinations' do
      expect(subject.run('sample.txt')).to eq 167409079868000
    end
  end

end
