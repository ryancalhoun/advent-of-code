require 'rspec'
require_relative 'covering'

describe Covering do
  subject { described_class.new range }
  let(:range) { 4..20 }

  it 'is initially not covered' do
    expect(subject.covered?).to be_falsey
  end

  context 'beginning covered' do
    before do
      subject.cover! 4..10
    end
    it 'counts uncovered' do
      expect(subject.uncovered).to eq 10
    end
    it 'finds uncovered' do
      expect(subject.first_after 4).to eq 11
      expect(subject.last_before 20).to eq 20
      expect(subject.first_after 20).to eq 20
    end
  end
  context 'ending covered' do
    before do
      subject.cover! 15..20
    end
    it 'counts uncovered' do
      expect(subject.uncovered).to eq 11
    end
    it 'finds uncovered' do
      expect(subject.first_after 4).to eq 4
      expect(subject.last_before 20).to eq 14
      expect(subject.last_before 4).to eq 4
    end
  end
  context 'ends covered' do
    before do
      subject.cover! 4..10
      subject.cover! 15..20
    end
    it 'counts uncovered' do
      expect(subject.uncovered).to eq 4
    end
    it 'finds uncovered' do
      expect(subject.first_after 4).to eq 11
      expect(subject.last_before 20).to eq 14
    end
  end
  context 'middle covered' do
    before do
      subject.cover! 10..15
    end
    it 'counts uncovered' do
      expect(subject.uncovered).to eq 6 + 5
    end
    it 'finds uncovered' do
      expect(subject.first_after 4).to eq 4
      expect(subject.last_before 20).to eq 20
    end
  end
  context 'middle(s) covered' do
    before do
      # .XXXXXX.XXXX.....
      subject.cover! 5..6
      subject.cover! 6..8
      subject.cover! 9..10
      subject.cover! 12..15
    end
    it 'counts uncovered' do
      expect(subject.uncovered).to eq 1 + 1 + 5
    end
    it 'finds uncovered' do
      expect(subject.first_after 4).to eq 4
      expect(subject.first_after 5).to eq 11
      expect(subject.last_before 20).to eq 20
      expect(subject.last_before 15).to eq 11
    end
  end
  context 'all covered' do
    before do
      # .XXXXXX.XXXX.....
      subject.cover! 4..10
      subject.cover! 13..17
      subject.cover! 19..20
    end
    it 'counts uncovered' do
      expect(subject.uncovered).to eq 2 + 1
    end
    it 'coveres the rest' do
      subject.cover! 11..12
      subject.cover! 18..18
      expect(subject.uncovered).to eq 0
    end
  end
end
