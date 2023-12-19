require 'rspec'
require_relative 'rule_eval'

describe RuleEval do
  subject { described_class.new object, key }
  let(:object) { double 'simulation object' }
  let(:key) { anything }
  let(:limit) { 999 }
  let(:result) { 'whatever' }

  it 'calls the less callback' do
    expect(object).to receive(:lt).with(limit, key).and_return(result)
    expect(subject < limit).to eq result
  end
  it 'calls the greater callback' do
    expect(object).to receive(:gt).with(limit, key).and_return(result)
    expect(subject > limit).to eq result
  end
end
