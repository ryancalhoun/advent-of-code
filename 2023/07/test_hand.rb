require 'rspec'

require_relative 'hand'

describe Hand do
  subject { described_class.new cards, overrides }
  let(:overrides) { {} }

  context 'Five of a kind' do
    let(:cards) { [2,2,2,2,2] }
    it 'has a type' do
      expect(subject.type.name).to eq 'Five of a kind'
    end
  end
  context 'Four of a kind' do
    let(:cards) { [2,2,2,2,3] }
    it 'has a type' do
      expect(subject.type.name).to eq 'Four of a kind'
    end
  end
  context 'Full house' do
    let(:cards) { [2,2,2,3,3] }
    it 'has a type' do
      expect(subject.type.name).to eq 'Full house'
    end
  end
  context 'Full house with joker' do
    let(:cards) { [2,2,3,3,1] }
    let(:overrides) { { 'anything' => 1 } }
    it 'has a type' do
      expect(subject.type.name).to eq 'Full house'
    end
  end
end
