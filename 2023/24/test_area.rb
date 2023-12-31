require 'rspec'
require_relative 'area'

describe Area do
  subject { described_class.new stones }

  let(:stone1) { double 'stone'}
  let(:stone2) { double 'stone'}
  let(:stone3) { double 'stone'}
  let(:stones) { [stone1, stone2, stone3] }

  context 'bounds' do
    before do
      expect(stone1).to receive(:intersection).with(stone2).and_return [0, 0]
      expect(stone1).to receive(:intersection).with(stone3).and_return [11, 11]
      expect(stone2).to receive(:intersection).with(stone3).and_return nil
    end

    context 'smaller bounds' do
      let(:bounds) { 0..10 }
      it 'counts intersections' do
        expect(subject.future_intersections_within bounds).to eq 1
      end
    end

    context 'larger bounds' do
      let(:bounds) { 0..11 }
      it 'counts intersections' do
        expect(subject.future_intersections_within bounds).to eq 2
      end
    end
  end

  context 'magic line' do
    let(:stone4) { double 'stone' }
    let(:stone5) { double 'stone' }
    let(:stones) { [stone1, stone2, stone3, stone4, stone5] }
    let(:eqn) { double 'equation' }
    let(:lu) { double 'lu' }

    let(:x0) { 24 }
    let(:y0) { 13 }
    let(:z0) { 10 }
    let(:vx) { -3 }
    let(:vy) { 1 }
    let(:vz) { 2 }

    before do
      expect(Equation).to receive(:new).exactly(4).times.and_return eqn
      expect(eqn).to receive(:x0).exactly(4).times
      expect(eqn).to receive(:y0).exactly(4).times
      expect(eqn).to receive(:vx).exactly(4).times
      expect(eqn).to receive(:vy).exactly(4).times
      expect(eqn).to receive(:b).exactly(4).times

      expect(LinearSystem).to receive(:new).once.and_return(lu)
      expect(lu).to receive(:solve).once.and_return [x0, y0, vx, vy]

      allow(stone1).to receive(:x).and_return 19
      allow(stone1).to receive(:vx).and_return -2
      allow(stone2).to receive(:x).and_return 18
      allow(stone2).to receive(:vx).and_return -1

      expect(stone1).to receive(:z_at).twice.with(5).and_return 30-10
      expect(stone2).to receive(:z_at).with(3).and_return 22-6
    end

    it 'finds the magic line' do
      expect(subject.find_magic_line).to eq [x0, y0, z0]
    end
  end
end
