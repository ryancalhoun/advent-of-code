require 'rspec'
require_relative 'stone'

describe Stone do
  subject { described_class.parse line }
  let(:line) { '3 0 0 @ -1 2 0' }
  let(:other) { double 'other stone' }

  it 'gives the slope' do
    expect(subject.m).to eq -2
  end
  it 'gives the y-intercept' do
    expect(subject.b).to eq 6
  end
  it 'knows the direction' do
    expect(subject.future?(1, 4)).to be_truthy
    expect(subject.future?(5, -4)).to be_falsey
  end

  context 'intersection' do
    before do
      allow(other).to receive(:m).and_return 1
      allow(other).to receive(:b).and_return 3
    end
    context 'both future' do
      before do
        allow(other).to receive(:future?).and_return true
      end
      it 'intersects in the future' do
        expect(subject.intersection(other)).to eq [1, 4]
      end
    end
    context 'only my future' do
      before do
        allow(other).to receive(:future?).and_return false
      end
      it 'does not intersect in the future' do
        expect(subject.intersection(other)).to be_nil
      end
    end
  end
  
end
