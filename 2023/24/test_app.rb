require 'rspec'
require_relative 'app'

describe App do
  subject { described_class.new part: part, bounds: bounds }

  context 'part one' do
    let(:part) { 1 }
    let(:bounds) { 7..27 }
    it 'finds future intersections in bounds' do
      expect(subject.run 'sample.txt').to eq 2
    end
  end
end
