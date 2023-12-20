require 'rspec'
require_relative 'app'

describe App do
  subject { described_class.new part: part }
  let(:part) { 1 }

  it 'counts pulses' do
    expect(subject.run('sample.txt')).to eq 4000*8000
  end
end
