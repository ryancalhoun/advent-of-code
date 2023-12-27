require 'rspec'
require_relative 'brick'

describe Brick do
  subject { described_class.parse line }
  let(:line) { '1,0,1~1,2,1' }
  let(:other) { double 'brick' }

  context 'only x overlaps' do
    before do
      allow(other).to receive(:x).and_return 1..2
      allow(other).to receive(:y).and_return 3..3
    end
    it 'does not overlap' do
      expect(subject.overlaps? other).to be_falsey
    end
  end

  context 'only y overlaps' do
    before do
      allow(other).to receive(:x).and_return 2..7
      allow(other).to receive(:y).and_return 2..3
    end
    it 'does not overlap' do
      expect(subject.overlaps? other).to be_falsey
    end
  end

  context 'x and y overlap' do
    before do
      allow(other).to receive(:x).and_return 1..2
      allow(other).to receive(:y).and_return 2..3
    end
    it 'overlaps' do
      expect(subject.overlaps? other).to be_truthy
    end
  end
end
