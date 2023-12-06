require 'rspec'

require_relative 'target'

describe Target do
  subject { described_class.new type }
  let(:type) { 'anything' }

  before do
    subject.add_range(20, 10, 5)
    subject.add_range(30, 25, 2)
  end

  it 'looks up the destination value' do
    expect(subject[1]).to eq 1
    expect(subject[11]).to eq 21
    expect(subject[20]).to eq 20
    expect(subject[25]).to eq 30
  end

  it 'looks up the destination ranges' do
    expect(subject[1..9]).to eq [1..9]
    expect(subject[1..15]).to eq [20..24, 1..9, 15..15]
    expect(subject[24..29]).to eq [30..31, 24..24, 27..29]
  end
end
