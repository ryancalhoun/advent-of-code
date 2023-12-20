require 'rspec'
require_relative 'wiring'

describe Wiring do
  subject { described_class.new bus, mod, connections }
  let(:bus) { double 'bus' }
  let(:mod) { double 'module' }
  let(:name) { 'this module' }
  let(:connections) { ['a', 'b', 'c'] }
  let(:receiver) { double 'receiver' }
  let(:wrap_block) { ->(b) { ->(*args) { b.call *args; receiver } } }
  let(:pulse) { 'the pulse' }
  let(:state) { 'the last state' }
  let(:a) { double 'sender' }
  let(:b) { double 'sender' }
  let(:c) { double 'sender' }

  before do
    allow(mod).to receive(:name).and_return(name)
    allow(mod).to receive(:state).and_return(state)
  end

  it 'wires up the receiving modules' do
    expect(receiver).to receive(:onreceive).exactly(3).times.with(name).and_return(a, b, c)
    expect {|b| subject.wire! &wrap_block[b.to_proc]}.to yield_successive_args *connections

    expect(bus).to receive(:count!).exactly(3).times.with(pulse)
    expect(a).to receive(:call).with(pulse, state)
    expect(b).to receive(:call).with(pulse, state)
    expect(c).to receive(:call).with(pulse, state)
    subject.trigger!(pulse)
  end
end
