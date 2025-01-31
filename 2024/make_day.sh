#!/bin/bash

dir=$(printf %02d $1)

if [[ ! -d $dir ]]; then
  mkdir $dir
fi

cd $dir

if [[ ! -f README.md ]]; then
cat > README.md <<END
# Day $1: ${@:2}

[Full info here](https://adventofcode.com/2024/day/$1)

END
fi

if [[ ! -f Makefile ]]; then
cat > Makefile <<'END'
target = app

all: sample1 sample2 part1 part2

$(target): *.go
	go build

sample1: $(target)
	PART=1 ./$(target) < sample.txt
sample2: $(target)
	PART=2 ./$(target) < sample.txt

part1: $(target)
	PART=1 ./$(target) < full.txt
part2: $(target)
	PART=2 ./$(target) < full.txt

clean:
	rm -f $(target)

END
fi

if [[ ! -f go.mod ]]; then
  go mod init app
fi

if [[ ! -f main.go ]]; then
cat > main.go <<'END'
package main

import (
  "bufio"
  "fmt"
  "os"
)

func main() {

}
END
fi
