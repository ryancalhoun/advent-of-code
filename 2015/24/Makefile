all: sample1 sample2 part1 part2

sample1:
	PART=1 ./app.py < sample.txt | dotnet run
part1:
	PART=1 ./app.py < full.txt | dotnet run
sample2:
	PART=2 ./app.py < sample.txt | dotnet run
part2:
	PART=2 ./app.py < full.txt | dotnet run

clean:
	rm -rf __pycache__ bin obj
