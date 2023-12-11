require 'rspec'
require_relative 'grid'

describe Grid do
  let(:grid) { [%w{. . . . .}, %w{. S - 7 .}, %w{. | . | .}, %w{. L - J .}, %w{. . . . .}] }
  before do
    grid.each_with_index do |row,i|
      row.each_with_index do |char,j|
        subject.at(i, j).add(char)
      end
    end
  end

  it 'starts at 1,1' do
    expect(subject.starting.i).to eq 1
    expect(subject.starting.j).to eq 1
  end
  it 'finds neighbors' do
    expect(subject.find_neighbors(subject.starting).map {|s| [s.i,s.j]}).to eq [[1,0],[1,2],[0,1],[2,1]]
  end
  context 'path' do
    before do
      subject.find_loop!
    end
    it 'knows the path' do
      expect(subject.path.map {|s| [s.i,s.j]}).to eq [[1, 1], [1, 2], [1, 3], [2, 3], [3, 3], [3, 2], [3, 1], [2, 1]]
    end
    it 'counts turns' do
      expect(subject.right_turns).to eq 3
      expect(subject.left_turns).to eq 0
    end

    context 'enclosed' do
      before do
        subject.find_enclosed!
      end
      it 'knows the enclosed' do
        expect(subject.enclosed.map {|s| [s.i,s.j]}).to eq [[2, 2]]
      end
    end
  end
end
