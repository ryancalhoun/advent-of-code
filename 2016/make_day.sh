#!/bin/bash

dir=$(printf %02d $1)

if [[ ! -d $dir ]]; then
  mkdir $dir
fi

cd $dir

if [[ ! -f README.md ]]; then
cat > README.md <<END
# Day $1: ${@:2}

[Full info here](https://adventofcode.com/2016/day/$1)

END
fi

if [[ ! -f app.m ]]; then
cat > app.m <<END
END
fi

if [[ ! -f run_all.m ]]; then
cat > run_all.m <<'END'
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
END
chmod a+x run_all.m
fi
