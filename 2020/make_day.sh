#!/bin/bash

dir=$(printf %02d $1)

if [[ ! -d $dir ]]; then
  mkdir $dir
fi

cd $dir

if [[ ! -f README.md ]]; then
cat > README.md <<END
# Day $1: ${@:2}

[Full info here](https://adventofcode.com/2020/day/$1)

END
fi

if [[ ! -f Makefile ]]; then
cat > Makefile <<'END'

all: sample1 sample2 part1 part2

sample1:
	PART=1 ./app.pl < sample.txt
sample2: $(target)
	PART=2 ./app.pl < sample.txt

part1: $(target)
	PART=1 ./app.pl < full.txt
part2: $(target)
	PART=2 ./app.pl < full.txt

END
fi

if [[ ! -f app.pl ]]; then
cat > app.pl <<END
#!/usr/bin/perl

use strict;
use warnings;

sub main
{

};

__PACKAGE__->main unless caller;
END
chmod a+x app.pl
fi
