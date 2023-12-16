require 'rspec'
require_relative 'app'

describe App do
  subject { described_class.new part: part }

  context 'part one' do
    let(:part) { 1 }
    it 'counts the visited cells' do
      expect(subject.run('sample.txt')).to eq 46
    end
  end
  context 'part two' do
    let(:part) { 2 }
    it 'maximizes the visited cells' do
      expect(subject.run('sample.txt')).to eq 51
    end
  end
end
