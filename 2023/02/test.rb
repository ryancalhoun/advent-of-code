require 'rspec'
require_relative 'app'

describe App do
  subject { described_class.new part: part }

  context 'part one' do
    let(:part) { 1 }

    it 'checks if a game is possible' do
      expect(subject.is_game_possible?({'red' => 1, 'blue' => 1, 'green' => 1})).to be_truthy
      expect(subject.is_game_possible?(Hash.new)).to be_truthy

      expect(subject.is_game_possible?({'red' => 13})).to be_falsey
      expect(subject.is_game_possible?({'blue' => 15})).to be_falsey
      expect(subject.is_game_possible?({'green' => 14})).to be_falsey
    end

    it 'parses the number of each color' do
      expect(subject.str_to_colors('3 blue, 4 red')).to eq({'red' => 4, 'blue' => 3})
      expect(subject.str_to_colors('5 green')).to eq({'green' => 5})
    end

    it 'parses the list of throws' do
      expect(subject.str_to_throws('3 blue, 4 red; 1 red, 2 green')).to eq ['3 blue, 4 red', '1 red, 2 green']
    end

    it 'parses the game info' do
      expect(subject.str_to_game('Game 1: 3 blue, 4 red')).to eq [1, '3 blue, 4 red']
    end

    it 'checks if all throws are possible' do
      expect(subject.all_throws_possible?([{'red' => 1}, {'green' => 1}])).to be_truthy

      expect(subject.all_throws_possible?([{'red' => 13}, {'green' => 1}])).to be_falsey
      expect(subject.all_throws_possible?([{'red' => 1}, {'green' => 14}])).to be_falsey
    end

    it 'gets id of possible games' do
      expect(subject.id_of_possible_game('Game 12: 3 blue, 4 red')).to eq 12
      expect(subject.id_of_possible_game('Game 12: 15 blue, 13 red')).to eq nil
    end

    it 'gets the sum of game ids' do
      expect(subject.run('sample.txt')).to eq 8
    end
  end

  context 'part 2' do
    let(:part) { 2 }

    it 'gets the power' do
      expect(subject.get_power({'red' => 4, 'blue' => 2, 'green' => 7})).to eq 56
    end

    it 'gets the max' do
      expect(subject.get_max([{'red' => 1}, {'green' => 4}, {'red' => 5, 'blue'=> 7}])).to eq({'red' => 5, 'green' => 4, 'blue' => 7})
    end

    it 'gets power of min cubes' do
      expect(subject.power_of_min_cubes('Game 12: 3 blue, 4 red')).to eq 12
      expect(subject.power_of_min_cubes('Game 12: 1 blue, 4 red; 3 blue, 3 red')).to eq 12
    end

    it 'gets the sum of powers' do
      expect(subject.run('sample.txt')).to eq 2286
    end
  end
end
