using System.IO;

IDictionary<string,string> arguments =
  args.Select(arg => arg.Split('=')).ToDictionary(s => s[0], s => s[1]);

int FullyReact(IEnumerable<int> polymer) {
  IList<int> react = new List<int>(polymer);
  for(int i = react.Count; i >= 0; --i) {
    if(i+1 > react.Count-1)
      continue;
    if(Math.Abs(react[i] - react[i+1]) == 32) {
      react.RemoveAt(i+1);
      react.RemoveAt(i);
    }
  }
  return react.Count();
}

List<int> polymer = new List<int>();

using (StreamReader file = new StreamReader(arguments["file"])) {
  for(int x; (x = file.Read()) != -1;) {
    if(x < 65)
      break;
    polymer.Add(x);
  }
}

if(arguments["part"] == "1") {
  Console.WriteLine(FullyReact(polymer));
  Console.WriteLine(polymer.Count());
} else {
  int [] r = Enumerable.Range(65, 26).ToArray();

  Console.WriteLine(r.Select(i => FullyReact(polymer.Where(p => p != i && p != i+32))).Min());
}
