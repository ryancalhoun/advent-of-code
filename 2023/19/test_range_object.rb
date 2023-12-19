require 'rspec'
require_relative 'range_object'

describe RangeObject do
  subject { described_class.new sim, obj }
  let(:sim) { double 'simulation' }
  let(:obj) { nil }

  it 'slices the range for less' do
    expect(sim).to receive(:add).with({'x'=>1000..4000, 'm'=>1..4000, 'a'=>1..4000, 's'=>1..4000})

    expect(subject['x'] < 1000).to be_truthy
    expect(subject.values).to eq [999*4000*4000*4000]
  end
  it 'slices the range for greater' do
    expect(sim).to receive(:add).with({'x'=>1..1000, 'm'=>1..4000, 'a'=>1..4000, 's'=>1..4000})

    expect(subject['x'] > 1000).to be_truthy
    expect(subject.values).to eq [3000*4000*4000*4000]
  end
end
