target = app.bin
objects = main.o snailfish.o

$(target): $(objects)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ $(objects)

all: sample1 sample2 part1 part2

deps := $(objects:.o=.dep)
-include $(deps)

CXXFLAGS = -std=c++17

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c -MM -MF $(patsubst %.o,%.dep,$@) -o $@ $<
	$(CXX) $(CXXFLAGS) -c -g -o $@ $<

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

