in = in.bin
objects = in.o

all: sample1 sample2 part1 part2

$(in): $(objects)
	gcc -o $(in) $(objects)

sample1: $(in)
	./$(in) < sample.txt | PART=1 ./out.py
sample2: $(in)
	./$(in) < sample.txt | PART=2 ./out.py

part1: $(in)
	./$(in) < full.txt | PART=1 ./out.py
part2: $(in)
	./$(in) < full.txt | PART=2 ./out.py

clean:
	rm -f $(in) $(objects)
