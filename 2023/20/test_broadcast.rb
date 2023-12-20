require 'rspec'
require_relative 'broadcast'

describe Broadcast do
  let(:name) { 'anything' }
  let(:source) { 'probably a button' }
  let(:sender) { subject.onreceive source }
  let(:prev_state) { nil }

  context 'receives a high' do
    it 'returns high' do
      expect(sender.call true, prev_state).to be_truthy
    end
  end
  context 'receives a low' do
    it 'returns high' do
      expect(sender.call false, prev_state).to be_falsey
    end
  end
end
