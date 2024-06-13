f = fopen(getenv('FILE'));

function v = is_valid(t)
  v = t(1) + t(2) > t(3) && t(1) + t(3) > t(2) && t(2) + t(3) > t(1);
endfunction

triangles = [];

while (s = fgetl(f)) != -1
  t = sscanf(s, '%d');
  triangles = [triangles, t];
end

valid = 0;

if getenv('PART') == '1'
  for i=1:size(triangles)(2)
    if is_valid(triangles(:,i:i))
      ++valid;
    end
  end
else
  for i=0:size(triangles)(2)/3-1
    for j=1:3
      if is_valid(triangles(j:j,i*3+1:i*3+3))
        ++valid;
      end
    end
  end
end

valid
