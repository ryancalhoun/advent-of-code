require 'rspec'
require_relative 'box'

describe Box do
  before do
    subject.add 'a', 5
    subject.add 'b', 7
    subject.add 'c', 9
  end
  it 'finds the power' do
    expect(subject.power).to eq 1*5 + 2*7 + 3*9
  end
  it 'replaces existing' do
    subject.add 'b', 4
    expect(subject.power).to eq 1*5 + 2*4 + 3*9
  end
  it 'removes existing' do
    subject.remove 'b'
    expect(subject.power).to eq 1*5 + 2*9
  end
end
