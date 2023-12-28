require 'rspec'
require_relative 'area'

describe Area do
  subject { described_class.new bounds }

  let(:stone1) { double 'stone'}
  let(:stone2) { double 'stone'}
  let(:stone3) { double 'stone'}
  let(:stones) { [stone1, stone2, stone3] }

  before do
    expect(stone1).to receive(:intersection).with(stone2).and_return [0, 0]
    expect(stone1).to receive(:intersection).with(stone3).and_return [11, 11]
    expect(stone2).to receive(:intersection).with(stone3).and_return nil
  end

  context 'smaller bounds' do
    let(:bounds) { 0..10 }
    it 'counts intersections' do
      expect(subject.count_future_intersections stones).to eq 1
    end
  end

  context 'larger bounds' do
    let(:bounds) { 0..11 }
    it 'counts intersections' do
      expect(subject.count_future_intersections stones).to eq 2
    end
  end
end
