require 'rspec'
require_relative 'pipe'

describe Pipe do
  subject { described_class.new type }
  let(:type) { '.' }

  it 'is not a pipe' do
    expect(subject.ground?).to be_truthy

    expect(subject.top?).to be_falsey
    expect(subject.bottom?).to be_falsey
    expect(subject.left?).to be_falsey
    expect(subject.right?).to be_falsey
  end

  context '|' do
    let(:type) { '|' }

    it 'opens top and bottom' do
      expect(subject.top?).to be_truthy
      expect(subject.bottom?).to be_truthy

      expect(subject.left?).to be_falsey
      expect(subject.right?).to be_falsey
    end
  end
  context '-' do
    let(:type) { '-' }

    it 'opens left and right' do
      expect(subject.left?).to be_truthy
      expect(subject.right?).to be_truthy

      expect(subject.top?).to be_falsey
      expect(subject.bottom?).to be_falsey
    end
  end
  context 'L' do
    let(:type) { 'L' }

    it 'opens top and right' do
      expect(subject.top?).to be_truthy
      expect(subject.right?).to be_truthy

      expect(subject.left?).to be_falsey
      expect(subject.bottom?).to be_falsey
    end
  end
  context 'J' do
    let(:type) { 'J' }

    it 'opens top and left' do
      expect(subject.top?).to be_truthy
      expect(subject.left?).to be_truthy

      expect(subject.right?).to be_falsey
      expect(subject.bottom?).to be_falsey
    end
  end
  context '7' do
    let(:type) { '7' }

    it 'opens bottom and left' do
      expect(subject.bottom?).to be_truthy
      expect(subject.left?).to be_truthy

      expect(subject.right?).to be_falsey
      expect(subject.top?).to be_falsey
    end
  end
  context 'F' do
    let(:type) { 'F' }

    it 'opens bottom and right' do
      expect(subject.bottom?).to be_truthy
      expect(subject.right?).to be_truthy

      expect(subject.left?).to be_falsey
      expect(subject.top?).to be_falsey
    end
  end
  context 'S' do
    let(:type) { 'S' }

    it 'is the starting position' do
      expect(subject.start?).to be_truthy
      expect(subject.top?).to be_truthy
      expect(subject.left?).to be_truthy
      expect(subject.bottom?).to be_truthy
      expect(subject.right?).to be_truthy
    end
  end
end
