require 'rspec'
require_relative 'damaged'

describe Damaged do
  subject { described_class.new size }
  let(:size) { 3 }

  before do
    subject.identify_candidates! records
  end

  context 'all positions' do
    let(:records) { [ nil ] * 10 }

    it 'finds candidates' do
      expect(subject.candidates).to eq [0, 1, 2, 3, 4, 5, 6, 7]
    end
    it 'finds bounds' do
      expect(subject.first_end_pos).to eq 3
      expect(subject.last_start_pos).to eq 7
    end
    it 'finds current range' do
      expect(subject.to_range).to eq 0..2
      expect(subject.to_range 1).to eq 1..3
    end

    context 'update before and after' do
      before do
        subject.not_before! 1
        subject.not_after! 7
      end
      it 'finds candidates' do
        expect(subject.candidates).to eq [2, 3]
      end
      it 'finds bounds' do
        expect(subject.first_end_pos).to eq 5
        expect(subject.last_start_pos).to eq 3
      end
      it 'finds current range' do
        expect(subject.to_range).to eq 2..4
        expect(subject.to_range 1).to eq 3..5

        subject.step!
        expect(subject.to_range).to eq 3..5
      end
    end
  end
end
