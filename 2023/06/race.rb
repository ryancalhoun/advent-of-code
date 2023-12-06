class Race
  attr_reader :time, :record
  def initialize(time, record)
    @time = time
    @record = record
  end 

  def distance(hold_time)
    speed = hold_time

    actual_hold_time = [hold_time, @time].min
    actual_travel_time = @time - actual_hold_time

    speed * actual_travel_time
  end

  def beat_record?(hold_time)
    distance(hold_time) > @record
  end

  def ways_to_win
    # brute force
    #@time.times.select {|x| beat_record?(x)}.size

    high_bound - low_bound + 1
  end

  def low_bound
    ((@time - Math.sqrt(@time**2 - 4*@record - 1)) / 2).ceil
  end
  def high_bound
    ((@time + Math.sqrt(@time**2 - 4*@record - 1)) / 2).floor
  end
end
