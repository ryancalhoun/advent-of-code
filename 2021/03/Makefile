target = app.bin
objects = main.o diagnostic.o

all: sample1 sample2 part1 part2

$(target): $(objects)
	g++ -o $(target) $(objects)

sample1: $(target)
	PART=1 ./$(target) < sample.txt
sample2: $(target)
	PART=2 ./$(target) < sample.txt

part1: $(target)
	PART=1 ./$(target) < full.txt
part2: $(target)
	PART=2 ./$(target) < full.txt

clean:
	rm -f $(target) $(objects)
