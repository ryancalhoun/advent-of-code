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

if [[ ! -f Makefile ]]; then
cat > Makefile <<'END'

all: sample1 sample2 part1 part2

sample1:
	PART=1 octave app.m < sample.txt
sample2:
	PART=2 octave app.m < sample.txt

part1:
	PART=1 octave app.m < full.txt
part2: 
	PART=2 octave app.m < full.txt

END
fi
