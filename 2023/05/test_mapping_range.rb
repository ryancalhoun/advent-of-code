require 'rspec'

require_relative 'mapping_range'

describe MappingRange do
  subject { described_class.new dest, source, len }
  let(:dest) { 20 }
  let(:source) { 10 }
  let(:len) { 5 }

  it 'looks up the dest value' do
    expect(subject.lookup 10).to eq 20
    expect(subject.lookup 11).to eq 21
    expect(subject.lookup 12).to eq 22
    expect(subject.lookup 13).to eq 23
    expect(subject.lookup 14).to eq 24
    expect(subject.lookup 15).to be_nil
  end

  it 'looks up the dest range' do
    expect(subject.lookup 10..14).to eq 20..24
    expect(subject.lookup 9..14).to eq 20..24
    expect(subject.lookup 10..15).to eq 20..24
    expect(subject.lookup 11..13).to eq 21..23
    expect(subject.lookup 15..17).to be_nil
  end

  it 'identifies the covered part of source' do
    expect(subject.covered 10..14).to eq 10..14
    expect(subject.covered 9..14).to eq 10..14
    expect(subject.covered 10..15).to eq 10..14
    expect(subject.covered 11..13).to eq 11..13
    expect(subject.covered 15..17).to be_nil
  end

end
