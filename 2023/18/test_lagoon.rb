require 'rspec'
require_relative 'lagoon'

describe Lagoon do
=begin
   ^>>>>
   ^   v
   ^   v
   <<<<v
=end
  context 'clockwise' do
    before do
      subject.R
      subject.dig! 4
      subject.D
      subject.dig! 3
      subject.L
      subject.dig! 4
      subject.U
      subject.dig! 3
    end
    it 'knows the direction' do
      expect(subject.cw?).to be_truthy
      expect(subject.ccw?).to be_falsey
    end
    it 'knows the perimeter' do
      expect(subject.perimeter_volume).to eq 14
    end
    it 'finds the inner' do
      expect(subject.inner_volume).to eq 6
    end
  end

=begin
   ^>> ^>>>
   ^ v>>  v
   ^      v
   <<<<<<<v
=end
  context 'clockwise - bumps' do
    before do
      subject.R
      subject.dig! 2
      subject.D
      subject.dig! 1
      subject.R
      subject.dig! 2
      subject.U
      subject.dig! 1
      subject.R
      subject.dig! 3
      subject.D
      subject.dig! 3
      subject.L
      subject.dig! 7
      subject.U
      subject.dig! 3
    end
    it 'knows the perimeter' do
      expect(subject.perimeter_volume).to eq 22
    end
    it 'finds the inner' do
      expect(subject.inner_volume).to eq 9
    end
  end

=begin
   <<<<^
   v   ^
   v   ^
   v>>>>
=end
  context 'counterclockwise' do
    before do
      subject.D
      subject.dig! 3
      subject.R
      subject.dig! 4
      subject.U
      subject.dig! 3
      subject.L
      subject.dig! 4
    end

    it 'knows the direction' do
      expect(subject.cw?).to be_falsey
      expect(subject.ccw?).to be_truthy
    end
    it 'knows the perimeter' do
      expect(subject.perimeter_volume).to eq 14
    end
    it 'finds the inner' do
      expect(subject.inner_volume).to eq 6
    end
  end

=begin
   <<^ <<<^
   v <<v  ^
   v      ^
   v>>>>>>>
=end
  context 'counter clockwise - bumps' do
    before do
      subject.D
      subject.dig! 3
      subject.R
      subject.dig! 7
      subject.U
      subject.dig! 3
      subject.L
      subject.dig! 3
      subject.D
      subject.dig! 1
      subject.L
      subject.dig! 2
      subject.U
      subject.dig! 1
      subject.L
      subject.dig! 2
    end
    it 'knows the perimeter' do
      expect(subject.perimeter_volume).to eq 22
    end
    it 'finds the inner' do
      expect(subject.inner_volume).to eq 9
    end
  end
end
