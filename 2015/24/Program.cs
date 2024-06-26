IList<Tuple<int,long>> candidates = new List<Tuple<int,long>>();

for(string? line; (line = Console.ReadLine()) != null;) {
  IList<int> values = line.Split(' ').Select(int.Parse).ToList();

  long q = 1;
  foreach(int v in values) {
    q *= v;
  }

  candidates.Add(Tuple.Create(values.Count(), q));
}

var (n,qs) = candidates.Min()!;
Console.WriteLine(qs);
