require 'rspec'
require_relative 'sequence'

describe Sequence do
  subject { described_class.new text, numbers }

  context do
    let(:text) { '???.###' }
    let(:numbers) { [1,1,3] }

    it 'counts' do
      expect(subject.count_matches).to eq 1
    end
    it 'unfolds' do
      subject.unfold! 5
      expect(subject.count_matches).to eq 1
    end
  end

  context do
    let(:text) { '?###????????' }
    let(:numbers) { [3,2,1] }

    it 'counts' do
      expect(subject.count_matches).to eq 10
    end
    it 'unfolds' do
      subject.unfold! 5
      expect(subject.count_matches).to eq 506250
    end
  end
end
