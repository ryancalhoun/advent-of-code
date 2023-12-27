require 'rspec'
require_relative 'app'

describe App do
  subject { described_class.new part: part }

  context 'part one' do
    let(:part) { 1 }
    it 'counts safe' do
      expect(subject.run 'sample.txt').to eq 5
    end
  end

  context 'part two' do
    let(:part) { 2 }
    it 'counts chains' do
      expect(subject.run 'sample.txt').to eq 7
    end
  end
end
