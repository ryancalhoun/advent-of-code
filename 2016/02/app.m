f = fopen(getenv('FILE'));

d = struct(
  'U', [-1;0],
  'R', [0;1],
  'L', [0;-1],
  'D', [1;0]
);

if getenv('PART') == '1'
  buttons = [
    '1','2','3';
    '4','5','6';
    '7','8','9'
  ];
  p = [2;2];
else
  buttons = [
    '0','0','1','0','0';
    '0','2','3','4','0';
    '5','6','7','8','9';
    '0','A','B','C','0';
    '0','0','D','0','0'
  ];
  p = [3;1];
end

code = [];
while (s = fgetl(f)) != -1

  for i = 1:length(s)
    n = p + d.(s(i));
    if n >= [1;1] && n <= size(buttons) && buttons(n(1), n(2)) != '0'
      p = n;
    end
  end

  code(end+1) = buttons(p(1), p(2));
end
printf("%c", code, "\n");
