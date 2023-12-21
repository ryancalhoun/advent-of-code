require 'rspec'
require_relative 'app'

describe App do
  subject { described_class.new part: part }

  context 'part one' do
    let(:part) { 1 }
    it 'adds the reflection lines' do
      expect(subject.run('sample.txt')).to eq 405
    end
  end
  context 'part one' do
    let(:part) { 2 }
    it 'adds the reflection lines' do
      expect(subject.run('sample.txt')).to eq 400
    end
  end
end
