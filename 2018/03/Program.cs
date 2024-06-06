using System.Text.RegularExpressions;
using Fabric = System.Collections.Generic.Dictionary<System.Tuple<int,int>,System.Collections.Generic.List<int>>;

int CountOverlaps(Fabric fabric) {
  int x = 0;
  foreach(List<int> c in fabric.Values) {
    if(c.Count > 1)
      ++x;
  }
  return x;
}

int FindIntact(Fabric fabric) {

  ISet<int> overlaps = new HashSet<int>();
  foreach(List<int> c in fabric.Values) {
    if(c.Count > 1) {
      foreach(int id in c) {
        overlaps.Add(id);
      }
    }
  }

  foreach(List<int> c in fabric.Values) {
    foreach(int id in c) {
      if(! overlaps.Contains(id))
        return id;
    }
  }

  return 0;
}

string pattern = @"#(\d+) @ (\d+),(\d+): (\d+)x(\d+)";
int [] groups = new int[]{1,2,3,4,5};

Fabric fabric = new Fabric();

for(string? line; (line = Console.ReadLine()) != null;) {
  Match m = Regex.Match(line, pattern);
  List<int> claim = (from i in groups select Int32.Parse(m.Groups[i].Value)).ToList();

  for(int i = 0; i < claim[3]; ++i) {
    for(int j = 0; j < claim[4]; ++j) {
      Tuple<int,int> p = new Tuple<int,int>(claim[1] + i, claim[2] + j);

      if(! fabric.ContainsKey(p))
        fabric.Add(p, new List<int>());
      fabric[p].Add(claim[0]);
    }
  }
}

if(Environment.GetEnvironmentVariable("PART") == "1") {
  Console.WriteLine(CountOverlaps(fabric));
} else {
  Console.WriteLine(FindIntact(fabric));
}
