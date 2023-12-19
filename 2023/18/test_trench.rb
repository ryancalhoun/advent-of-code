require 'rspec'
require_relative 'trench'

class Array
  def imin
    first
  end
  def imax
    last
  end
end

describe Trench do
  subject { described_class.new i0, j0, i1, j1 }

  context "up" do
    let(:i0) { 10 }
    let(:i1) { 1 }
    let(:j0) { 2 }
    let(:j1) { 2 }

    it 'has the right values' do
      expect(subject.up?).to be_truthy
      expect(subject.down?).to be_falsey
      expect(subject.imin).to eq 1
      expect(subject.imax).to eq 10
      expect(subject.size).to eq 9
    end

    it 'overlaps' do
      expect(subject.v_overlaps? [1, 10]).to be_truthy
      expect(subject.v_overlaps? [0, 5]).to be_truthy
      expect(subject.v_overlaps? [3, 4]).to be_truthy
      expect(subject.v_overlaps? [9, 11]).to be_truthy
      expect(subject.v_overlaps? [0, 20]).to be_truthy
      expect(subject.v_overlaps? [10, 10]).to be_truthy

      expect(subject.v_overlaps? [11, 12]).to be_falsey
      expect(subject.v_overlaps? [0, 0]).to be_falsey
    end
  end

  context "down" do
    let(:i0) { 1 }
    let(:i1) { 10 }
    let(:j0) { 2 }
    let(:j1) { 2 }

    it 'has the right values' do
      expect(subject.down?).to be_truthy
      expect(subject.up?).to be_falsey
      expect(subject.imin).to eq 1
      expect(subject.imax).to eq 10
      expect(subject.size).to eq 9
    end

    it 'overlaps' do
      expect(subject.v_overlaps? [1, 10]).to be_truthy
      expect(subject.v_overlaps? [0, 5]).to be_truthy
      expect(subject.v_overlaps? [3, 4]).to be_truthy
      expect(subject.v_overlaps? [9, 11]).to be_truthy
      expect(subject.v_overlaps? [0, 20]).to be_truthy
      expect(subject.v_overlaps? [10, 10]).to be_truthy

      expect(subject.v_overlaps? [11, 12]).to be_falsey
      expect(subject.v_overlaps? [0, 0]).to be_falsey
    end
  end
end
