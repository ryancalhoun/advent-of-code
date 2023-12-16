require 'rspec'
require_relative 'bounce'

describe Bounce do
  let(:i) { 7 }
  let(:j) { 42 }

  context 'left mirror' do
    subject { described_class.left_mirror i, j }

    it 'reflects' do
      expect { |b| subject.hit :up, &b }.to yield_with_args(:right)
      expect { |b| subject.hit :down, &b }.to yield_with_args(:left)
      expect { |b| subject.hit :left, &b }.to yield_with_args(:down)
      expect { |b| subject.hit :right, &b }.to yield_with_args(:up)
    end
  end
  context 'right mirror' do
    subject { described_class.right_mirror i, j }

    it 'reflects' do
      expect { |b| subject.hit :up, &b }.to yield_with_args(:left)
      expect { |b| subject.hit :down, &b }.to yield_with_args(:right)
      expect { |b| subject.hit :left, &b }.to yield_with_args(:up)
      expect { |b| subject.hit :right, &b }.to yield_with_args(:down)
    end
  end
  context 'splitter' do
    subject { described_class.splitter i, j }

    it 'splits' do
      expect { |b| subject.hit :up, &b }.to yield_successive_args(:left, :right)
      expect { |b| subject.hit :down, &b }.to yield_successive_args(:left, :right)
      expect { |b| subject.hit :left, &b }.to yield_successive_args(:up, :down)
      expect { |b| subject.hit :right, &b }.to yield_successive_args(:up, :down)
    end
  end
end
