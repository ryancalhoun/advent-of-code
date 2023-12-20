require 'rspec'
require_relative 'flipflop'

describe Flipflop do
  subject { described_class.new name }
  let(:name) { 'anything' }
  let(:source) { 'something' }
  let(:sender) { subject.onreceive source }
  let(:prev_state) { nil }

  it 'starts with a state of off' do
    expect(subject.state).to be_falsey
  end

  context 'receives a high' do
    it 'does nothing' do
      expect(sender.call true, prev_state).to eq nil
      expect(subject.state).to be_falsey
    end
  end
  context 'receives a low' do
    it 'flops' do
      expect(sender.call false, prev_state).to be_truthy
      expect(subject.state).to be_truthy
    end
  end

  context 'is on' do
    before do
      sender.call false, nil
    end
    it 'starts with a state of on' do
      expect(subject.state).to be_truthy
    end

    context 'receives a high' do
      it 'does nothing' do
        expect(sender.call true, prev_state).to eq nil
        expect(subject.state).to be_truthy
      end
    end
    context 'receives a low' do
      it 'flops' do
        expect(sender.call false, prev_state).to be_falsey
        expect(subject.state).to be_falsey
      end
    end

  end
end
