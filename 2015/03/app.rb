h = Hash.new(0)

visitors = [[0, 0]]
visitors.push [0, 0] if ENV['PART'].to_i == 2

def visitors.get
  begin
    at @i ||= 0
  ensure
    @i = (@i + 1) % size
  end
end

visitors.each do |v|
  h[v.to_s] += 1
end

IO.popen(['java', 'ProcessInput'], in: :in) do |stdout|
  stdout.each_line do |line|
    s = line.split(' ').map(&:to_i)

    visitors.get.tap do |v|
      2.times {|i| v[i] += s[i] }
      h[v.to_s] += 1
    end
  end
end

puts h.keys.size
