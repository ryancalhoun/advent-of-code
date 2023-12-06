require_relative 'race'

class App

  attr_reader :times, :records

  def initialize(part:)
    @part = part
    @times = []
    @records = []
  end

  def run(filename)
    load_race_input!(filename)

    times.zip(records).map do |time, record|
      Race.new(time, record).ways_to_win
    end.inject(:*)
  end

  def load_race_input!(filename)
    File.open(filename) do |f|
      @times = str_to_data f.readline
      @records = str_to_data f.readline
    end
  end

  def str_to_data(str)
    str.gsub!(/\s+/, '') unless @part == 1
    str.scan(/\d+/).map(&:to_i)
  end
end

if __FILE__ == $0
  puts App.new(part: ENV['PART'].to_i).run ARGV[0]
end
