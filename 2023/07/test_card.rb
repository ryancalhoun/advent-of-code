require 'rspec'

require_relative 'card'

describe Card do
  subject { described_class.new value, overrides }

  context 'part one' do
    let(:overrides) { Hash.new }
    context 'ace' do
      let(:value) { 'A' }
      it 'has a value' do
        expect(subject.order).to eq 14
      end
    end
    context 'king' do
      let(:value) { 'K' }
      it 'has a value' do
        expect(subject.order).to eq 13
      end
    end
    context 'queen' do
      let(:value) { 'Q' }
      it 'has a value' do
        expect(subject.order).to eq 12
      end
    end
    context 'jack' do
      let(:value) { 'J' }
      it 'has a value' do
        expect(subject.order).to eq 11
      end
    end
    context 'this one' do
      let(:value) { 'T' }
      it 'has a value' do
        expect(subject.order).to eq 10
      end
    end
    context 'nine' do
      let(:value) { '9' }
      it 'has a value' do
        expect(subject.order).to eq 9
      end
    end
    context 'eight' do
      let(:value) { '8' }
      it 'has a value' do
        expect(subject.order).to eq 8
      end
    end
    context 'seven' do
      let(:value) { '7' }
      it 'has a value' do
        expect(subject.order).to eq 7
      end
    end
    context 'six' do
      let(:value) { '6' }
      it 'has a value' do
        expect(subject.order).to eq 6
      end
    end
    context 'five' do
      let(:value) { '5' }
      it 'has a value' do
        expect(subject.order).to eq 5
      end
    end
    context 'four' do
      let(:value) { '4' }
      it 'has a value' do
        expect(subject.order).to eq 4
      end
    end
    context 'three' do
      let(:value) { '3' }
      it 'has a value' do
        expect(subject.order).to eq 3
      end
    end
    context 'two' do
      let(:value) { '2' }
      it 'has a value' do
        expect(subject.order).to eq 2
      end
    end
  end
  context 'part two' do
    let(:overrides) { {'J' => 1 }}
    context 'joker' do
      let(:value) { 'J' }
      it 'has a value' do
        expect(subject.order).to eq 1
      end
    end
  end
end
