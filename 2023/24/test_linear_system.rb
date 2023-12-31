require 'rspec'
require_relative 'linear_system'

describe LinearSystem do
  subject { described_class.new a }

  #   x + y = 3
  # 3x - 2y = 4
  context '2 unknowns' do
    let(:a) { [ [1, 1], [3, -2] ] }
    let(:b) { [3, 4] }

    it 'solves the system' do
      # 2 + 1 == 3
      # 6 - 2 == 4
      expect(subject.solve(b)).to eq [2, 1]
    end
  end

  #   x - 2y +  z =  0
  #  2x +  y - 3z =  5
  #  4x - 7y +  z = -1
  context '3 unknowns' do
    let(:a) { [ [1, -2, 1], [2, 1, -3], [4, -7, 1] ] }
    let(:b) { [0, 5, -1] }

    it 'solves the system' do
      #  3 -  4 + 1 ==  0
      #  6 +  2 - 3 ==  5
      # 12 - 14 + 1 == -1
      expect(subject.solve(b)).to eq [3, 2, 1]
    end
  end
end
