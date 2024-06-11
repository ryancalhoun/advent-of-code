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
	DotNetRun(".", "part=2 file=sample2.txt", settings);
});

Task("Part1").IsDependentOn("Build").Does(() => {
	DotNetRun(".", "part=1 file=full.txt", settings);
});

Task("Part2").IsDependentOn("Build").Does(() => {
	DotNetRun(".", "part=2 file=full.txt", settings);
});

RunTarget(target);
