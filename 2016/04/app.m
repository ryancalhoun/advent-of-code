f = fopen(getenv('FILE'));

result = 0;

while (s = fgetl(f)) != -1
  m = containers.Map();

  name = substr(s, 1, -7);
  checksum = substr(s, -6, 5);

  id = str2num(name(regexp(name, "\\d")));

  letters = regexp(name, "[a-z]");
  u = unique(name(letters));
  h = histc(name, u);

  v = sortrows([h; 1:length(u)]', [-1, 2]);

  ck = u(v(1:5,2));

  if ck == checksum
    if getenv('PART') == '1'
      result += id;
    else
      decrypted = char(mod((name - 'a' + id), 26) + 'a');
      if strcmp(decrypted(letters), 'northpoleobjectstorage')
        result = id;
      end
    end
  end
end

printf("%d\n", result);
