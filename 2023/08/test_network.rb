require 'rspec'
require_relative 'network'

describe Network do
  let(:l_branch) { double('left branch') }
  let(:r_branch) { double('right branch') }
  let(:path) { double('path') }

  before do
    allow(path).to receive(:done?).and_return(false, false, true)
    allow(path).to receive(:next_direction).and_return('L', 'R')
    allow(path).to receive(:current).and_return('A', 'B')

    subject['A'] = l_branch
    subject['B'] = r_branch
  end

  it 'follows the path' do
    expect(l_branch).to receive(:L).and_return 'B'
    expect(path).to receive(:go_to).with('B')

    expect(r_branch).to receive(:R).and_return 'Z'
    expect(path).to receive(:go_to).with('Z')

    subject.follow(path)
  end

end
