require 'rspec'

require_relative 'app'

describe App do
  subject { described_class.new part: part }

  before do
    subject.load_bets! 'sample.txt'
  end

  context 'part one' do
    let(:part) { 1 }
    it 'orders bets' do
      expect {|b| subject.each_ranked_bet &b }.to yield_successive_args([765, 1], [220, 2], [28, 3], [684, 4], [483, 5])
    end
    it 'finds total winnings' do
      expect(subject.total_winnings).to eq 6440
    end
  end
  context 'part two' do
    let(:part) { 2 }
    it 'orders bets' do
      expect {|b| subject.each_ranked_bet &b }.to yield_successive_args([765, 1], [28, 2], [684, 3], [483, 4], [220, 5])
    end
    it 'finds total winnings' do
      expect(subject.total_winnings).to eq 5905
    end
  end
end
