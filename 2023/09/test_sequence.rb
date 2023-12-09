require 'rspec'
require_relative 'sequence'

describe Sequence do
  subject { described_class.new values }

  context 'all zero' do
    let(:values) { [ 0, 0, 0, 0 ] }

    it 'finds the next value' do
      expect(subject.next_value).to eq 0
    end
    it 'finds the prev value' do
      expect(subject.prev_value).to eq 0
    end
  end
  context 'all equal' do
    let(:values) { [ 2, 2, 2, 2 ] }

    it 'finds the next value' do
      expect(subject.next_value).to eq 2
    end
    it 'finds the prev value' do
      expect(subject.prev_value).to eq 2
    end
  end
  context 'step by 1' do
    let(:values) { [ 2, 3, 4, 5 ] }

    it 'finds the next value' do
      expect(subject.next_value).to eq 6
    end
    it 'finds the prev value' do
      expect(subject.prev_value).to eq 1
    end
  end
  context 'increasing step' do
    let(:values) { [ 1, 3, 6, 10, 15, 21 ] }

    it 'finds the next value' do
      expect(subject.next_value).to eq 28
    end
    it 'finds the prev value' do
      expect(subject.prev_value).to eq 0
    end
  end
  context 'step by -1' do
    let(:values) { [ 2, 1, 0, -1, -2 ] }

    it 'finds the next value' do
      expect(subject.next_value).to eq -3
    end
    it 'finds the prev value' do
      expect(subject.prev_value).to eq 3
    end
  end
end
