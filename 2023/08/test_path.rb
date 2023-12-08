require 'rspec'
require_relative 'path'

describe Path do
  subject { described_class.new start, stop, directions }
  let(:start) { 'AAA' }
  let(:stop) { 'ZZZ' }
  let(:directions) { ['L', 'R'] }

  it 'tells the next direction' do
    expect(subject.next_direction).to eq 'L'
  end
  it 'is not done' do
    expect(subject.done?).to be_falsey
  end

  context 'move' do
    before do
      subject.go_to 'BBB'
      subject.go_to 'CCC'
      subject.go_to 'DDD'
    end

    it 'tells the next direction' do
      expect(subject.next_direction).to eq 'R'
    end
    it 'tells the length' do
      expect(subject.length).to eq 3
    end
    it 'is not done' do
      expect(subject.done?).to be_falsey
    end
  end

  context 'done' do
    before do
      subject.go_to 'ZZZ'
    end
    it 'is done' do
      expect(subject.done?).to be_truthy
    end
  end
  context 'done with callback' do
    let(:stop) { ->(n) { n.end_with?'Z' } }
    before do
      subject.go_to '11Z'
    end
    it 'is done' do
      expect(subject.done?).to be_truthy
    end
  end
end
