default: part2

all: sample1 sample2 part1 part2

sample1:
	PART=1 ROW=10 python3 app.py < sample.txt
sample2:
	PART=2 BOUND=20 python3 app.py < sample.txt

part1:
	PART=1 ROW=2000000 python3 app.py < full.txt
part2:
	PART=2 BOUND=4000000 python3 app.py < full.txt

test:
	python3 -munittest discover .
