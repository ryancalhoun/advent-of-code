require 'rspec'
require_relative 'equation'

describe Equation do
  subject { described_class.new s1, s2 }
  let(:s1) { double 'stone' }
  let(:s2) { double 'stone' }

  before do
    allow(s1).to receive(:x).and_return 19
    allow(s1).to receive(:y).and_return 13
    allow(s1).to receive(:vx).and_return -2
    allow(s1).to receive(:vy).and_return 1

    allow(s2).to receive(:x).and_return 18
    allow(s2).to receive(:y).and_return 19
    allow(s2).to receive(:vx).and_return -1
    allow(s2).to receive(:vy).and_return -1
  end

  it 'computs the coefficients' do
    expect(subject.x0).to eq 1 - -1
    expect(subject.y0).to eq -1 - -2
    expect(subject.vx).to eq 19 - 13
    expect(subject.vy).to eq 19 - 18
  end

  it 'computes the rhs' do
    expect(subject.b).to eq 19*1 - 13*-2 -18*-1 + 19*-1
  end
end
