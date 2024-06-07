require 'rspec'
require_relative 'app'

describe App do
  subject { described_class.new part: part }

  context 'part one' do
    let(:part) { 1 }

    it 'gets the sum of game ids' do
      expect(subject.run('sample.txt')).to eq 8
    end
  end

  context 'part 2' do
    let(:part) { 2 }

    it 'gets the sum of powers' do
      expect(subject.run('sample.txt')).to eq 2286
    end
  end
end
