require 'rspec'
require_relative 'records'

describe Records do
  subject { described_class.parse str }
  let(:str) { '?#.' }

  it 'has the records' do
    expect(subject.to_a).to eq [nil, false, true]
  end
  it 'counts' do
    expect(subject.unknowns).to eq 1
    expect(subject.known_damaged).to eq 1
  end

  context 'cover' do
    let(:str) { '?###????????' }
    it 'fills in covered values' do
      expect(subject.cover_with(1..3, 5..5, 7..7)).to eq [true, false, false, false, true, false, true, false, true, true, true, true]
      expect(subject.count_covered_with(1..3, 5..5, 7..7)).to eq 5
    end
    it 'counts unknowns' do
      expect(subject.unknowns).to eq 9
      expect(subject.known_damaged).to eq 3
    end
    it 'counts unknowns in range' do
      expect(subject.covered_by 1..3).to eq [1, 2, 3]
      expect(subject.covered_by 2..4).to eq [2, 3]
      expect(subject.covered_by 5..7).to eq []
    end
  end
end
