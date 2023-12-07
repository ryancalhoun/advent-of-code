require 'rspec'

require_relative 'type'

describe Type do
  subject { described_class.new name, distribution }
  let(:name) { self.class.description }

  context 'Five of a kind' do
    let(:distribution) { [5] }

    it 'matches' do
      expect(subject.matches?([5])).to be_truthy
      expect(subject.matches?([4,1])).to be_falsey
    end
    it 'matches with jokers' do
      expect(subject.matches?([4], jokers: 1)).to be_truthy
      expect(subject.matches?([3], jokers: 2)).to be_truthy
      expect(subject.matches?([2], jokers: 3)).to be_truthy
      expect(subject.matches?([1], jokers: 4)).to be_truthy
      expect(subject.matches?([], jokers: 5)).to be_truthy

      expect(subject.matches?([5], jokers: 1)).to be_falsey
      expect(subject.matches?([4], jokers: 0)).to be_falsey
    end
  end
  context 'Four of a kind' do
    let(:distribution) { [4,1] }

    it 'matches' do
      expect(subject.matches?([4,1])).to be_truthy
      expect(subject.matches?([3,2])).to be_falsey
    end
    it 'matches with jokers' do
      expect(subject.matches?([3,1], jokers: 1)).to be_truthy
      expect(subject.matches?([2,1], jokers: 2)).to be_truthy
      expect(subject.matches?([1,1], jokers: 3)).to be_truthy

      expect(subject.matches?([4,1], jokers: 1)).to be_falsey
      expect(subject.matches?([3,1], jokers: 0)).to be_falsey
    end
  end
  context 'Full house' do
    let(:distribution) { [3,2] }

    it 'matches' do
      expect(subject.matches?([3,2])).to be_truthy
      expect(subject.matches?([3,1,1])).to be_falsey
    end
    it 'matches with jokers' do
      expect(subject.matches?([2,2], jokers: 1)).to be_truthy

      expect(subject.matches?([3,2], jokers: 1)).to be_falsey
      expect(subject.matches?([2,2], jokers: 0)).to be_falsey
    end
  end
  context 'Three of a kind' do
    let(:distribution) { [3,1,1] }

    it 'matches' do
      expect(subject.matches?([3,1,1])).to be_truthy
      expect(subject.matches?([2,2,1])).to be_falsey
    end
    it 'matches with jokers' do
      expect(subject.matches?([2,1,1], jokers: 1)).to be_truthy
      expect(subject.matches?([1,1,1], jokers: 2)).to be_truthy

      expect(subject.matches?([3,1,1], jokers: 1)).to be_falsey
      expect(subject.matches?([2,1,1], jokers: 0)).to be_falsey
    end
  end
  context 'Two pair' do
    let(:distribution) { [2,2,1] }

    it 'matches' do
      expect(subject.matches?([2,2,1])).to be_truthy
      expect(subject.matches?([2,1,1,1])).to be_falsey
    end
  end
  context 'One pair' do
    let(:distribution) { [2,1,1,1] }

    it 'matches' do
      expect(subject.matches?([2,1,1,1])).to be_truthy
      expect(subject.matches?([1,1,1,1,1])).to be_falsey
    end
    it 'matches with jokers' do
      expect(subject.matches?([1,1,1,1], jokers: 1)).to be_truthy

      expect(subject.matches?([1,1,1,1,1], jokers: 1)).to be_falsey
      expect(subject.matches?([1,1,1,1], jokers: 0)).to be_falsey
    end
  end
  context 'High card' do
    let(:distribution) { [1,1,1,1,1] }

    it 'matches' do
      expect(subject.matches?([1,1,1,1,1])).to be_truthy
      expect(subject.matches?([4,1])).to be_falsey
    end
  end
end
