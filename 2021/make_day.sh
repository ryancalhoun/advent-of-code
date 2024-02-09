#!/bin/bash

dir=$(printf %02d $1)

if [[ ! -d $dir ]]; then
  mkdir $dir
fi

cd $dir

if [[ ! -f README.md ]]; then
cat > README.md <<END
# Day $1: ${@:2}

[Full info here](https://adventofcode.com/2021/day/$1)

END
fi

if [[ ! -f Makefile ]]; then
cat > Makefile <<'END'
target = app.bin
objects = main.o

$(target): $(objects)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ $(objects)

all: sample1 sample2 part1 part2

deps := $(objects:.o=.dep)
-include $(deps)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c -MM -MF $(patsubst %.o,%.dep,$@) -o $@ $<
	$(CXX) $(CXXFLAGS) -c -o $@ $<

sample1: $(target)
	PART=1 ./$(target) < sample.txt
sample2: $(target)
	PART=2 ./$(target) < sample.txt

part1: $(target)
	PART=1 ./$(target) < full.txt
part2: $(target)
	PART=2 ./$(target) < full.txt

clean:
	rm -f $(target) $(objects) $(deps)

END
fi

if [[ ! -f main.cpp ]]; then
cat > main.cpp <<END
#include <iostream>

int main(int argc, char* const argv[], char* const envp[])
{

}
END
fi
