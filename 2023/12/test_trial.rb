require 'rspec'
require_relative 'trial'

describe Trial do
  subject { described_class.parse line }

  context 'one' do
    let(:line) { '???.### 1,1,3' }
    before do
      subject.find_initial_positions!
    end
    it 'sets up the initial positions' do
      expect(subject.records.to_a).to eq [nil, nil, nil, true, false, false, false]
      expect(subject.damaged.map(&:candidates)).to eq [[0], [2], [4]]
    end
    it 'is done' do
      expect(subject.done?).to be_truthy
    end
    it 'keeps track of visited' do
      expect(subject.visited).to eq [{0..0=>1}, {2..2=>1}, {4..6=>1}]
    end
  end
  context 'two' do
    let(:line) { '.??..??...?##. 1,1,3' }
    before do
      subject.find_initial_positions!
    end

    it 'sets up the initial positions' do
      expect(subject.records.to_a).to eq [true, nil, nil, true, true, nil, nil, true, true, true, nil, false, false, true]
      expect(subject.damaged.map(&:candidates)).to eq [[1, 2], [5, 6], [10]]
    end
    it 'is not done' do
      expect(subject.done?).to be_falsey
    end
    it 'finds the next to move' do
      expect(subject.next_to_move).to eq 0
    end

    context 'move' do
      before do
        subject.move! 0
      end
      it 'is not done' do
        expect(subject.done?).to be_falsey
      end
      it 'finds the next to move' do
        expect(subject.next_to_move).to eq 1
      end
      context 'again' do
        before do
          subject.move! 1
        end
        it 'is done' do
          expect(subject.done?).to be_truthy
        end
      end
    end
  end
  context 'three' do
    let(:line) { '?#?#?#?#?#?#?#? 1,3,1,6' }
    before do
      subject.find_initial_positions!
    end

    it 'sets up the initial positions' do
      expect(subject.records.to_a).to eq [nil, false, nil, false, nil, false, nil, false, nil, false, nil, false, nil, false, nil]
      expect(subject.damaged.map(&:candidates)).to eq [[1], [3], [7], [9]]
    end
    it 'is done' do
      expect(subject.done?).to be_truthy
    end
    it 'keeps track of visited' do
      expect(subject.visited).to eq [{1..1=>1}, {3..5=>1}, {7..7=>1}, {9..14=>1}]
    end
  end
  context 'four' do
    let(:line) { '????.#...#... 4,1,1' }
    before do
      subject.find_initial_positions!
    end

    it 'sets up the initial positions' do
      expect(subject.records.to_a).to eq [nil, nil, nil, nil, true, false, true, true, true, false, true, true, true]
      expect(subject.damaged.map(&:candidates)).to eq [[0], [5], [9]]
    end
    it 'is done' do
      expect(subject.done?).to be_truthy
    end
  end
  context 'five' do
    let(:line) { '????.######..#####. 1,6,5' }
    before do
      subject.find_initial_positions!
    end

    it 'sets up the initial positions' do
      expect(subject.records.to_a).to eq [nil, nil, nil, nil, true, false, false, false, false, false, false, true, true, false, false, false, false, false, true]
      expect(subject.damaged.map(&:candidates)).to eq [[0, 1, 2, 3], [5], [13]]
    end
    it 'is not done' do
      expect(subject.done?).to be_falsey
    end
    it 'finds the next to move' do
      expect(subject.next_to_move).to eq 0
    end
    context 'move' do
      before do
        subject.move! 0
        subject.move! 0
        subject.move! 0
      end
      it 'is done' do
        expect(subject.done?).to be_truthy
      end
    end
  end
  context 'six' do
    let(:line) { '?###???????? 3,2,1' }
    before do
      subject.find_initial_positions!
    end

    it 'sets up the initial positions' do
      expect(subject.records.to_a).to eq [nil, false, false, false, nil, nil, nil, nil, nil, nil, nil, nil]
      expect(subject.damaged.map(&:candidates)).to eq [[1], [5, 6, 7, 8], [8, 9, 10, 11]]
    end
    it 'is not done' do
      expect(subject.done?).to be_falsey
    end
    it 'finds the next to move' do
      expect(subject.next_to_move).to eq 2
    end
    it 'keeps track of visited' do
      expect(subject.visited).to eq [{1..3=>1}, {5..6=>1}, {8..8=>1}]
    end
    context 'run' do
      before do
        subject.run!
      end
      it 'keeps track of visited' do
        expect(subject.visited).to eq [{1..3=>1}, {5..6=>1, 6..7=>1, 7..8=>1, 8..9=>1}, {8..8=>1, 9..9=>1, 10..10=>1, 11..11=>1}]
      end
      it 'counts arrangements' do
        expect(subject.count_arrangements).to eq 10
      end
    end
  end
  context 'too many at end' do
    let(:line) { '??????#??# 1,1,1' }
    before do
      subject.find_initial_positions!
    end

    it 'sets up the initial positions' do
      expect(subject.damaged.map(&:candidates)).to eq [[0, 1, 2, 3, 4], [2, 3, 4, 6], [4, 6, 9]]
    end
    it 'is not done' do
      expect(subject.done?).to be_falsey
    end
    it 'finds the next to move' do
      expect(subject.next_to_move).to eq 2
    end
    context 'move' do
      before do
        subject.move! 2
      end
      it 'finds the next to move' do
        expect(subject.next_to_move).to eq 2
      end
      context 'again' do
        before do
          subject.move! 2
        end
        it 'finds the next to move' do
          expect(subject.next_to_move).to eq 1
        end
      end
    end
    context 'run' do
      before do
        subject.run!
      end
      it 'keeps track of visited' do
        expect(subject.visited).to eq [{0..0=>1, 1..1=>1, 2..2=>1, 3..3=>1, 4..4=>1}, {6..6=>1}, {9..9=>1}]
      end
    end
  end
  context 'at end - 2' do
    let(:line) { '????????#????#?.# 1,2,3,2,1' }
    before do
      subject.find_initial_positions!
    end

    it 'sets up the initial positions' do
      expect(subject.damaged.map(&:candidates)).to eq [[0, 1, 2, 3], [2, 3, 4, 5], [6, 7, 8], [10, 12, 13], [13, 16]]
    end
    it 'finds the next to move' do
      expect(subject.next_to_move).to eq 4
    end
    context 'move' do
      before do
        subject.move! 4
      end
      it 'finds the next to move' do
        expect(subject.next_to_move).to eq 3
      end
      context 'again' do
        before do
          subject.move! 3
        end
        it 'finds the next to move' do
          expect(subject.next_to_move).to eq 1
        end
        it 'keeps track of visited' do
          expect(subject.visited).to eq [{0..0=>1}, {2..3=>1}, {6..8=>1}, {12..13=>1}, {16..16=>1}]
        end
      end
    end
    context 'run' do
      before do
        subject.run!
      end
      it 'keeps track of visited' do
        expect(subject.visited).to eq [{0..0=>1, 1..1=>1, 2..2=>1, 3..3=>1}, {2..3=>1, 3..4=>1, 4..5=>1, 5..6=>1}, {6..8=>1, 7..9=>1, 8..10=>1}, {12..13=>1, 13..14=>1}, {16..16=>1}]
      end
      it 'counts arrangements' do
        expect(subject.count_arrangements).to eq 38
      end
    end
  end
  context 'frozen singles' do
    let(:line) { '?#?#?????? 1,1,1' }
    before do
      subject.find_initial_positions!
    end
    it 'sets up the initial positions' do
      expect(subject.damaged.map(&:candidates)).to eq [[1, 3, 5], [3, 5, 6, 7], [5, 6, 7, 8, 9]]
    end
    context 'move' do
      before do
        subject.move! 2
        subject.move! 2
        subject.move! 2
      end
      it 'finds the next to move' do
        expect(subject.next_to_move).to eq 2
      end
    end
    context 'run' do
      before do
        subject.run!
      end
      it 'keeps track of visited' do
        expect(subject.visited).to eq [{1..1=>1}, {3..3=>1}, {5..5=>1, 6..6=>1, 7..7=>1, 8..8=>1, 9..9=>1}]
      end
      it 'counts arrangements' do
        expect(subject.count_arrangements).to eq 5
      end
    end
  end
  context 'frozen at beginning' do
    let(:line) { '?#?.???.??????????# 3,1,3,4' }
=begin
                  ###.#...###....####
                  ###..#..###....####
                  ###...#.###....####
                  ###.#....###...####
                  ###..#...###...####
                  ###...#..###...####
                  ###.#.....###..####
                  ###..#....###..####
                  ###...#...###..####
                  ###.....#.###..####
                  ###.#......###.####
                  ###..#.....###.####
                  ###...#....###.####
                  ###.....#..###.####
                  ###......#.###.####
=end
    before do
      subject.find_initial_positions!
    end

    it 'sets up the initial positions' do
      expect(subject.damaged.map(&:candidates)).to eq [[0, 4], [4, 5, 6, 8, 9], [8, 9, 10, 11], [12, 13, 15]]
    end
    context 'run' do
      before do
        subject.run!
      end
      it 'keeps track of visited' do
        expect(subject.visited).to eq  [{0..2=>1}, {4..4=>1, 5..5=>1, 6..6=>1, 8..8=>1, 9..9=>1}, {8..10=>1, 9..11=>1, 10..12=>1, 11..13=>1}, {15..18=>1}]
      end
      it 'counts arrangements' do
        expect(subject.count_arrangements).to eq 15
      end
    end
  end
end
