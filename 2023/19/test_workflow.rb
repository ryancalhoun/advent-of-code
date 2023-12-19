require 'rspec'
require_relative 'workflow'

describe Workflow do
  subject { described_class.parse line }
  let(:line) { "#{name}{a<1000:#{a_lt},m>1000:#{m_gt},#{default}}" }
  let(:name) { 'theflow' }
  let(:a_lt) { 'apple' }
  let(:m_gt) { 'monkey' }
  let(:default) { 'the default' }

  it 'knows its name' do
    expect(subject.name).to eq name
  end

  it 'returns the first destination' do
    expect(subject.process({'a'=>999})).to eq a_lt
  end
  it 'returns the second destination' do
    expect(subject.process({'a'=>1000, 'm'=>1001})).to eq m_gt
  end
  it 'returns the final destination' do
    expect(subject.process({'a'=>1000, 'm'=>100})).to eq default
  end
end
