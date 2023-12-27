require 'rspec'
require_relative 'hash_fn'

describe HashFn do
  it 'computes a hash' do
    expect(subject | 'HASH').to eq 52
  end
end
