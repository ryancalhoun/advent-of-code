require 'rspec'
require_relative 'spot'

describe Spot do
  subject { described_class.new i, j, &if_start }
  let(:i) { 0 }
  let(:j) { 0 }
  let(:if_start) { ->(x) { x } }
  let(:to) { double 'to' }
  before do
    allow(to).to receive(:pipe).and_return(true)
    allow(to).to receive(:i).and_return(0)
    allow(to).to receive(:j).and_return(0)
  end

  it 'does not call start callback for pipe or ground' do
    expect(if_start).not_to receive(:call)
    subject.add '.'
    subject.add '|'
    subject.add '-'
    subject.add 'L'
    subject.add '7'
    subject.add 'F'
    subject.add 'J'
  end
  it 'calls start callback for start' do
    expect(if_start).to receive(:call).with(subject)
    subject.add 'S'
  end

  context 'above' do
    before do
      allow(to).to receive(:i).and_return(1)
    end
    it 'is above the other' do
      expect(subject.above?(to)).to be_truthy

      expect(subject.below?(to)).to be_falsey
      expect(subject.left?(to)).to be_falsey
      expect(subject.right?(to)).to be_falsey
    end
    context 'top' do
      before do
        allow(to).to receive_message_chain(:pipe, :top?).and_return(true)
      end
      it 'connects to' do
        subject.add '|'
        expect(subject.connected?(to)).to be_truthy
        subject.add '7'
        expect(subject.connected?(to)).to be_truthy
        subject.add 'F'
        expect(subject.connected?(to)).to be_truthy
      end
      it 'does not connect to' do
        subject.add '-'
        expect(subject.connected?(to)).to be_falsey
        subject.add 'L'
        expect(subject.connected?(to)).to be_falsey
        subject.add 'J'
        expect(subject.connected?(to)).to be_falsey
      end
    end
    context 'not top' do
      before do
        allow(to).to receive_message_chain(:pipe, :top?).and_return(false)
      end
    end
  end
  context 'below' do
    let(:i) { 1 }
    it 'is below the other' do
      expect(subject.below?(to)).to be_truthy

      expect(subject.above?(to)).to be_falsey
      expect(subject.left?(to)).to be_falsey
      expect(subject.right?(to)).to be_falsey
    end
    context 'bottom' do
      before do
        allow(to).to receive_message_chain(:pipe, :bottom?).and_return(true)
      end
      it 'connects to' do
        subject.add '|'
        expect(subject.connected?(to)).to be_truthy
        subject.add 'L'
        expect(subject.connected?(to)).to be_truthy
        subject.add 'J'
        expect(subject.connected?(to)).to be_truthy
      end
      it 'does not connect to' do
        subject.add '-'
        expect(subject.connected?(to)).to be_falsey
        subject.add '7'
        expect(subject.connected?(to)).to be_falsey
        subject.add 'F'
        expect(subject.connected?(to)).to be_falsey
      end
    end
    context 'not bottom' do
      before do
        allow(to).to receive_message_chain(:pipe, :bottom?).and_return(false)
      end
    end
  end
  context 'left' do
    before do
      allow(to).to receive(:j).and_return(1)
    end
    it 'is left of the other' do
      expect(subject.left?(to)).to be_truthy

      expect(subject.above?(to)).to be_falsey
      expect(subject.below?(to)).to be_falsey
      expect(subject.right?(to)).to be_falsey
    end
    context 'left' do
      before do
        allow(to).to receive_message_chain(:pipe, :left?).and_return(true)
      end
      it 'connects to' do
        subject.add '-'
        expect(subject.connected?(to)).to be_truthy
        subject.add 'L'
        expect(subject.connected?(to)).to be_truthy
        subject.add 'F'
        expect(subject.connected?(to)).to be_truthy
      end
      it 'does not connect to' do
        subject.add '|'
        expect(subject.connected?(to)).to be_falsey
        subject.add '7'
        expect(subject.connected?(to)).to be_falsey
        subject.add 'J'
        expect(subject.connected?(to)).to be_falsey
      end
    end
    context 'not left' do
      before do
        allow(to).to receive_message_chain(:pipe, :left?).and_return(false)
      end
    end
  end
  context 'right' do
    let(:j) { 1 }
    it 'is right of the other' do
      expect(subject.right?(to)).to be_truthy

      expect(subject.above?(to)).to be_falsey
      expect(subject.below?(to)).to be_falsey
      expect(subject.left?(to)).to be_falsey
    end
    context 'right' do
      before do
        allow(to).to receive_message_chain(:pipe, :right?).and_return(true)
      end
      it 'connects to' do
        subject.add '-'
        expect(subject.connected?(to)).to be_truthy
        subject.add '7'
        expect(subject.connected?(to)).to be_truthy
        subject.add 'J'
        expect(subject.connected?(to)).to be_truthy
      end
      it 'does not connect to' do
        subject.add '|'
        expect(subject.connected?(to)).to be_falsey
        subject.add 'L'
        expect(subject.connected?(to)).to be_falsey
        subject.add 'F'
        expect(subject.connected?(to)).to be_falsey
      end
    end
    context 'not right' do
      before do
        allow(to).to receive_message_chain(:pipe, :right?).and_return(false)
      end
    end
  end
end
