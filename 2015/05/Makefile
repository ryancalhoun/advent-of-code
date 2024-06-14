all: sample1 sample2 part1 part2

sample1: lib/1/rules.so
	LD_LIBRARY_PATH=lib/1 dotnet run < sample.txt
sample2: lib/2/rules.so
	LD_LIBRARY_PATH=lib/2 dotnet run < sample2.txt

part1: lib/1/rules.so
	LD_LIBRARY_PATH=lib/1 dotnet run < full.txt
part2: lib/2/rules.so
	LD_LIBRARY_PATH=lib/2 dotnet run < full.txt


lib/1/rules.so: rules1.c
lib/2/rules.so: rules2.c

lib/1/rules.so lib/2/rules.so:
	mkdir -p $(@D)
	gcc -shared -o $@ $<

clean:
	rm -rf bin lib
