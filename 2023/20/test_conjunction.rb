require 'rspec'
require_relative 'conjunction'

describe Conjunction do
  subject { described_class.new name }
  let(:name) { 'anything' }
  let(:sources) { ['a', 'b'] }
  let(:a) { subject.onreceive sources.first }
  let(:b) { subject.onreceive sources.last }
  let(:prev_state) { nil }

  before do
    a
    b
  end

  it 'starts with a state of all off' do
    expect(subject.state).to eq( { sources.first => false, sources.last => false } )
  end

  context 'receives a high' do
    it 'returns high' do
      expect(a.call true, prev_state).to be_truthy
      expect(subject.state).to eq( { sources.first => true, sources.last => false } )
    end
  end
  context 'receives the other high' do
    it 'returns high' do
      expect(b.call true, prev_state).to be_truthy
      expect(subject.state).to eq( { sources.first => false, sources.last => true } )
    end
  end
  context 'receives both high' do
    before do
      a.call true, prev_state
    end
    it 'returns low' do
      expect(b.call true, prev_state).to be_falsey
      expect(subject.state).to eq( { sources.first => true, sources.last => true } )
    end
  end

end
