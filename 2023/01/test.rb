require 'rspec'
require_relative './app'

describe App do
  it 'converts digit strings to numbers' do
    expect(subject.str_to_i('4')).to eq 4
    expect(subject.str_to_i('9')).to eq 9
    expect(subject.str_to_i('0')).to eq 0
  end

  it 'converts digit names to numbers' do
    expect(subject.str_to_i('zero')).to eq 0
    expect(subject.str_to_i('one')).to eq 1
    expect(subject.str_to_i('two')).to eq 2
    expect(subject.str_to_i('three')).to eq 3
    expect(subject.str_to_i('four')).to eq 4
    expect(subject.str_to_i('five')).to eq 5
    expect(subject.str_to_i('six')).to eq 6
    expect(subject.str_to_i('seven')).to eq 7
    expect(subject.str_to_i('eight')).to eq 8
    expect(subject.str_to_i('nine')).to eq 9
  end

  it 'converts lines to a list of digits' do
    expect(subject.line_to_digits('1abc2')).to eq ['1', '2']
    expect(subject.line_to_digits('pqr3stu8vwx')).to eq ['3', '8']
    expect(subject.line_to_digits('two1nine')).to eq ['two', '1', 'nine']
  end
  it 'converts lines with overlapping digit names' do
    expect(subject.line_to_digits('oneightwo')).to eq ['one', 'eight', 'two']
  end
  it 'selects the first and last digit' do
    expect(subject.first_and_last([4, 2])).to eq 42
    expect(subject.first_and_last([9, 0, 2, 1, 0])).to eq 90
    expect(subject.first_and_last([7])).to eq 77
  end

  it 'finds the sum of first and last digits' do
    expect(subject.run('sample.txt')).to eq 142
    expect(subject.run('sample2.txt')).to eq 281
  end
end
