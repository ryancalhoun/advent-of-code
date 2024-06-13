d = 0;
x = [0; 0];

m = containers.Map();

f = fopen(getenv('FILE'));
while length(step = fscanf(f, '%c%d,')) >= 2
  if step(1) == 'R'
    d -= 90;
  elseif step(1) == 'L'
    d += 90;
  end
  incby = [cosd(d), -sind(d); sind(d), cosd(d)] * [0; 1];
  for i = 1:step(2)
    x += incby;

    if getenv('PART') == '2'
      s = sprintf("%d,%d", x);
      if !isKey(m, s)
        m(s) = 0;
      end

      m(s) += 1;
      if m(s) == 2
        sum(abs(x))
        exit()
      end
    end
  end
end
fclose(f);

if getenv('PART') == '1'
  sum(abs(x))
end
