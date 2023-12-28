require 'rspec'
require_relative 'pair'

describe Pair do
  before do
    subject.add(0, 3)
  end
  it 'counts one' do
    expect(subject.count).to eq 1
  end

  context 'a first' do
    before do
      subject.add(1, 3)
    end
    it 'counts two' do
      expect(subject.count).to eq 2
    end
    context 'then a again' do
      before do
        subject.add(2, 3)
      end
      it 'counts three' do
        expect(subject.count).to eq 3
      end
    end
    context 'then b' do
      before do
        subject.add(1, 4)
      end
      it 'counts four' do
        expect(subject.count).to eq 4
      end
      context 'then a again' do
        before do
          subject.add(2, 4)
        end
        it 'counts five' do
          expect(subject.count).to eq 5
        end
      end
    end
  end

  context 'b first' do
    before do
      subject.add(0, 4)
    end
    it 'counts two' do
      expect(subject.count).to eq 2
    end
    context 'then a' do
      before do
        subject.add(1, 4)
      end
      it 'counts three' do
        expect(subject.count).to eq 3
      end
      context 'then a again' do
        before do
          subject.add(2, 4)
        end
        it 'counts four' do
          expect(subject.count).to eq 4
        end
      end
    end
    context 'then b again' do
      before do
        subject.add(0, 5)
      end
      it 'counts three' do
        expect(subject.count).to eq 3
      end
    end
  end
end
