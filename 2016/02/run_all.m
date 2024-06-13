#!/usr/bin/env octave
1;
function r = run_part(part, file)
  setenv('PART', part);
  setenv('FILE', file);
  app;
end

function sample1()
  run_part('1', 'sample.txt');
end
function sample2()
  run_part('2', 'sample.txt');
end
function part1()
  run_part('1', 'full.txt');
end
function part2()
  run_part('2', 'full.txt');
end

if length(argv) == 0
  sample1();
  sample2();
  part1();
  part2();
else
  for i = 1:length(argv)
    eval(argv{i});
  end
end
