require 'rspec'
require_relative 'path_segment'

describe PathSegment do
  subject { described_class.new start }
  let(:start) { [2, 2] }

  it 'is left' do
    expect(subject.leftof? [2, 3]).to be_truthy
  end
  it 'is right' do
    expect(subject.rightof? [2, 1]).to be_truthy
  end
  it 'is above' do
    expect(subject.above? [3, 2]).to be_truthy
  end
  it 'is below' do
    expect(subject.below? [1, 2]).to be_truthy
  end

  context 'size' do
    before do
      subject << [2, 3]
      subject << [2, 4]
      subject << [3, 4]
      subject << [4, 4]
      subject << [4, 5]
    end
    it 'has the path length' do
      expect(subject.size).to eq 5
    end
    it 'has the path end' do
      expect(subject.finish).to eq [4, 5]
    end
  end
end
