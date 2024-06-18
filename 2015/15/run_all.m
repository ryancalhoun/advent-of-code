#!/usr/bin/env octave
1;
function run_part(part, file)
  setenv('PART', part);
  setenv('FILE', file);
  app;
endfunction

function sample1()
  run_part('1', 'sample.txt');
endfunction
function sample2()
  run_part('2', 'sample.txt');
endfunction
function part1()
  run_part('1', 'full.txt');
endfunction
function part2()
  run_part('2', 'full.txt');
endfunction

m = stat('nways.mex');
if length(m) == 0 || stat('nways.cpp').mtime > m.mtime
  mkoctfile '-mex' 'nways.cpp';
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
