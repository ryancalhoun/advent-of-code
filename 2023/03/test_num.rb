require 'rspec'

require_relative 'num'

describe Num do
  subject { described_class.new digit, i, j }
  let(:digit) { 4 }
  let(:i) { 0 }
  let(:j) { 0 }

  it 'has the expected fields' do
    expect(subject.value).to eq digit
  end

  context 'adds a digit' do
    before do
      subject.append 2
    end

    it 'has a new value' do
      expect(subject.value).to eq 42
    end
  end

  it 'checks adjacent' do
    expect(subject.adj?(0, 1)).to be_truthy
    expect(subject.adj?(0, 2)).to be_falsey

    expect(subject.adj?(1, 0)).to be_truthy
    expect(subject.adj?(1, 1)).to be_truthy

    expect(subject.adj?(2, 0)).to be_falsey
  end

  context 'not at the corner' do
    let(:i) { 4 }
    let(:j) { 8 }
    before do
      subject.append 0
      subject.append 0
    end

    it 'has adjacent corners' do
      expect(subject.adj?(3, 7)).to be_truthy
      expect(subject.adj?(5, 7)).to be_truthy

      expect(subject.adj?(3, 11)).to be_truthy
      expect(subject.adj?(5, 11)).to be_truthy
    end

    it 'not adjacent' do
      expect(subject.adj?(2, 8)).to be_falsey
      expect(subject.adj?(6, 8)).to be_falsey

      expect(subject.adj?(2, 10)).to be_falsey
      expect(subject.adj?(6, 10)).to be_falsey

      expect(subject.adj?(4, 6)).to be_falsey
      expect(subject.adj?(4, 12)).to be_falsey
    end
  end

end
