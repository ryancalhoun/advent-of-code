all: sample1 sample2 part1 part2

target=game.so
objects=game.o boss.o

CXXFLAGS=$(shell python3-config --cflags) -fPIC

sample1: $(target)
	PART=1 START=8 ./app.py < sample.txt
part1: $(target)
	PART=1 ./app.py < full.txt
sample2: $(target)
	PART=2 START=8 ./app.py < sample.txt
part2: $(target)
	PART=2 ./app.py < full.txt

$(target): $(objects)
	$(CXX) -shared -o $@ $(objects) $(shell python3-config --ldflags)

clean:
	rm -f $(target) $(objects)
