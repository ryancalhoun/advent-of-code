#!/bin/bash

dir=$(printf %02d $1)

if [[ ! -d $dir ]]; then
  dotnet new console -n $dir
fi

cd $dir

if [[ ! -f README.md ]]; then
cat > README.md <<END
# Day $1: ${@:2}

[Full info here](https://adventofcode.com/2018/day/$1)

END
fi

if [[ ! -f Makefile ]]; then
cat > Makefile <<END
all: sample1 sample2 part1 part2

sample1:
	PART=1 dotnet run < sample.txt
sample2:
	PART=2 dotnet run < sample.txt
part1:
	PART=1 dotnet run < full.txt
part2:
	PART=2 dotnet run < full.txt
END

fi
