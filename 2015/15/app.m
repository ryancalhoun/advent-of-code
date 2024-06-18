f = fopen(getenv('FILE'));

ingredients = [];
while (s = fgetl(f)) != -1
  [name,value] = strsplit(s, ': '){1,:};
  v = sscanf(value, 'capacity %f, durability %f, flavor %f, texture %f, calories %f');
  ingredients = [ingredients, v];
end

ways = nways(100, size(ingredients)(2));

all = getenv('PART') == '1';
best = 0;
for i=1:size(ways)(1)
  s = max(sum(ingredients .* ways(i:i,:), 2), 0);
  if all || s(5) == 500
    p = prod(s(1:4,:));
    best = max(p, best);
  end
end

format long g;
disp(best);

