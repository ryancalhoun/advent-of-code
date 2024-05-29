
all: sample1 sample2 part1 part2

sample1:
	PART=1 ./app.pl < sample.txt
sample2: $(target)
	PART=2 ./app.pl < sample2.txt

part1: $(target)
	PART=1 ./app.pl < full.txt
part2: $(target)
	PART=2 ./app.pl < full.txt

