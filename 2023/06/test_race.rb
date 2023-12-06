require 'rspec'

require_relative 'race'

describe Race do
  subject { described_class.new time, record }
  let(:time) { 5 }
  let(:record) { 5 }

  it 'calculates the distance' do
    expect(subject.distance(0)).to eq 0
    expect(subject.distance(1)).to eq 4
    expect(subject.distance(2)).to eq 6
    expect(subject.distance(3)).to eq 6
    expect(subject.distance(4)).to eq 4
    expect(subject.distance(5)).to eq 0
  end

  it 'compares against the record' do
    expect(subject.beat_record?(1)).to be_falsey
    expect(subject.beat_record?(2)).to be_truthy
    expect(subject.beat_record?(3)).to be_truthy
    expect(subject.beat_record?(4)).to be_falsey
  end

  it 'counts ways to win' do
    expect(subject.ways_to_win).to eq 2
  end

  context 'algebraic optimization' do
    let(:time) { 50 }
    let(:record) { 500 }

    it 'these are the record-beating bounds' do
      expect(subject.low_bound).to eq 14
      expect(subject.high_bound).to eq 36
    end

    it 'calculates ways to win' do
      expect(subject.ways_to_win).to eq 23
    end
  end
end
