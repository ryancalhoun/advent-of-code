require_relative 'records'
require_relative 'damaged'

class Trial
  attr_reader :records, :damaged, :visited

  def initialize(records, damaged)
    @records, @damaged = records, damaged
    @visited = []
  end

  def self.parse(line)
    r, d = line.split ' '
    new Records.parse(r), d.scan(/\d+/).map {|s| Damaged.new s.to_i }
  end

  def find_initial_positions!
    damaged.size.times do |i|
      d = damaged[i]
      d.identify_candidates! records.to_a

      if i > 0
        d.not_before! damaged[i-1].first_end_pos
      end
    end
    (damaged.size-1).times do |i|
      j = damaged.size - i - 1
      damaged[j-1].not_after! damaged[j].last_start_pos
    end
    snapshot!
    lock_in!
  end

  def unfold!
    r = records.to_a

    sizes = damaged.map &:size
    4.times do
      sizes.each do |s|
        damaged << Damaged.new(s)
      end
      r += [nil] + records.to_a
    end


    @records = Records.new r
  end

  def run!
    find_initial_positions!
    until done?
      i = next_to_move
      break unless i

      move! i
    end
  end

  def move!(i)
    damaged[i].step!
    snapshot!
    lock_in!
  end
  def snapshot!
    return unless valid?
    damaged.each_with_index do |d,i|
      (visited[i] ||= {})[d.to_range] = 1
    end
  end

  def lock_in!

    last_locked = -1

    damaged.size.times do |i|
      d = damaged[i]

      if d.done?
        last_locked = i
        next
      end

      covered = records.covered_by d.to_range
      covered_if = records.covered_by d.to_range(1)

      uncovered_if = covered - covered_if
      next if uncovered_if.empty?

      if i > 0
        set = uncovered_if.slice_when {|prev,cur| cur != prev + 1}.first

        free = damaged.slice(last_locked+1..i-1)
        if free.find {|d1| d1.includes?(set) }
          next
        end

        last_end = -1 
        free.size.times do |j|
          free[j].reset_after! last_end
          last_end = free[j].to
        end
      end

      last_locked = i
      d.lock!
    end
  end

  def count_arrangements
    (visited.size-1).times do |i|
      v0 = visited[i]
      v1 = visited[i+1]

      v1.keys.each do |r|
        back_stop = records.to_a[0..r.first-1].rindex(false) || 0

        v1[r] = v0.select do |k,v|
          k.last >= back_stop && k.last + 1 < r.first
        end.map {|k,v| v }.sum
      end
    end
    visited.last.values.sum
  end

  def done?
    damaged.all? &:done?
  end
  def valid?
    damaged.map(&:size).sum == records.count_covered_with(damaged.map(&:to_range))
  end

  def next_to_move
    to_move = nil

    damaged.size.times do |i|
      d = damaged[i]

      next if d.done?

      d_next = damaged[i+1]
      next_start = d_next&.from || records.size + 1
      next if d.to(1) >= next_start - 1

      after = records.covered_by d.to+1..next_start-1

      if !to_move || after.size > 0
        to_move = i
      end
    end
    to_move
  end

end


