require 'rspec'

require_relative 'sym'

describe Sym do
  subject { described_class.new symbol, i, j }
  let(:symbol) { '&' }
  let(:i) { 2 }
  let(:j) { 4 }

  it 'has the expected fields' do
    expect(subject.i).to eq i
    expect(subject.j).to eq j
  end

  it 'is not a gear' do
    expect(subject.is_gear?).to be_falsey
  end

  context 'has one part' do
    let(:symbol) { '*' }
    before do
      subject.add_part 1
    end

    it 'is still not a gear' do
      expect(subject.is_gear?).to be_falsey
    end

    context 'has two parts' do
      before do
        subject.add_part 2
      end

      it 'is a gear' do
        expect(subject.is_gear?).to be_truthy
      end
    end
  end

end
