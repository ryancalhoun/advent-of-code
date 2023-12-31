require 'matrix'

class LinearSystem
  def initialize(a)
    @a = a
  end
  def solve(b)
    Matrix::LUPDecomposition.new(Matrix[ *@a ]).solve(b).to_a.map(&:to_i)
  end
end
