require 'rspec'
require_relative 'predictive_counter'

describe PredictiveCounter do
  let(:sender) { subject.onreceive('anything') }
  let(:pulse) { 'any value' }

  before do
    subject.cycle = 2
    sender.call pulse, { 'a' => true, 'b' => false, 'c' => false }

    subject.cycle = 3
    sender.call pulse, { 'a' => false, 'b' => true, 'c' => false }
  end

  it 'is not done' do
    expect(subject.done?).to be_falsey
  end

  it 'finds the last value' do
    subject.cycle = 5
    sender.call pulse, { 'a' => false, 'b' => false, 'c' => true }

    expect(subject.done?).to be_truthy

    expect(subject.prediction).to eq 2*3*5
  end
end
