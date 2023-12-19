require 'rspec'
require_relative 'rule'

describe Rule do
  subject { described_class.parse line }
  let(:key) { 'x' }
  let(:limit) { 1000 }
  let(:dest) { 'something' }
  let(:line) { "#{key}#{op}#{limit}:#{dest}" }

  context 'less' do
    let(:op) { '<' }
    it 'compares with the limit' do
      expect(subject.call key => 999 ).to be_truthy
      expect(subject.call key => 1000 ).to be_falsey
    end
  end
  context 'greater' do
    let(:op) { '>' }
    it 'compares with the limit' do
      expect(subject.call key => 1001 ).to be_truthy
      expect(subject.call key => 1000 ).to be_falsey
    end
  end
end
