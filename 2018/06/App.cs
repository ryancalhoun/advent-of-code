using System.IO;

IDictionary<string,string> arguments =
  args.Select(arg => arg.Split('=')).ToDictionary(s => s[0], s => s[1]);

List<Point> points = new List<Point>();

using (StreamReader file = new StreamReader(arguments["file"])) {
  for(string? line; (line = file.ReadLine()) != null;) {
    points.Add(new Point(line));
  }
}

int xmin = points.Min(p => p.x);
int ymin = points.Min(p => p.y);
int xmax = points.Max(p => p.x);
int ymax = points.Max(p => p.y);

IGridVisitor<int> visitor = arguments["part"] == "1" ?
  new LargestFiniteArea(points) :
  new MostDenseArea(points, Int32.Parse(arguments["limit"]));

for(int y = ymin; y <= ymax; ++y) {
  for(int x = xmin; x <= xmax; ++x) {
    visitor.Visit(x, y);
  }
}

Console.WriteLine(visitor.Value());
