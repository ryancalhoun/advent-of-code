require 'rspec'
require_relative 'destination'

describe Destination do
  let(:a) { { 'a' => 2, 'b' => 3 } }
  let(:b) { { 'a' => 4, 'b' => 5 } }

  before do
    subject.process a
    subject.process b
  end

  it 'adds the sums of values' do
    expect(subject.sum).to eq 2+3+4+5
  end
end
