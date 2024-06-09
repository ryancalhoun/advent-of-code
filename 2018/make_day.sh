#!/bin/bash

dir=$(printf %02d $1)

if [[ ! -d $dir ]]; then
  dotnet new console -n $dir
fi

cd $dir

if [[ ! -f README.md ]]; then
cat > README.md <<END
# Day $1: ${@:2}

[Full info here](https://adventofcode.com/2018/day/$1)

END
fi

rm -f Program.cs

if [[ ! -f App.cs ]]; then
cat > App.cs <<END
using System.IO;

IDictionary<string,string> arguments =
  args.Select(arg => arg.Split('=')).ToDictionary(s => s[0], s => s[1]);

using (StreamReader file = new StreamReader(arguments["file"])) {

}
END
fi

if [[ ! -f build.cake ]]; then
cat > build.cake <<END
var target = Argument("target", "All");

Task("All")
	.IsDependentOn("Sample1")
	.IsDependentOn("Sample2")
	.IsDependentOn("Part1")
	.IsDependentOn("Part2");

Task("Build").Does(() => {
	DotNetBuild(".");
});

var settings = new DotNetRunSettings {
	NoBuild = false,
	NoRestore = false
};

Task("Sample1").IsDependentOn("Build").Does(() => {
	DotNetRun(".", "part=1 file=sample.txt", settings);
});

Task("Sample2").IsDependentOn("Build").Does(() => {
	DotNetRun(".", "part=2 file=sample.txt", settings);
});

Task("Part1").IsDependentOn("Build").Does(() => {
	DotNetRun(".", "part=1 file=full.txt", settings);
});

Task("Part2").IsDependentOn("Build").Does(() => {
	DotNetRun(".", "part=2 file=full.txt", settings);
});

RunTarget(target);
END

fi
