
List<int> changes = new List<int> {};

for(string? line; (line = Console.ReadLine()) != null; ) {
  changes.Add(Int32.Parse(line));
}

int GetLast(List<int> changes) {
  int freq = 0;
  foreach(int change in changes) {
    freq += change;
  }
  return freq;
}

int FindRepeat(List<int> changes) {

  Dictionary<int,int> d = new Dictionary<int,int>();

  int freq = 0;

  for(;;) {
    foreach(int change in changes) {

      int seen;
      d.TryGetValue(freq, out seen);
      if(++seen == 2) {
        return freq;
      }
      d.Add(freq, seen);

      freq += change;
    }
  }
  
}

if(Environment.GetEnvironmentVariable("PART") == "1") {
  Console.WriteLine(GetLast(changes));
} else {
  Console.WriteLine(FindRepeat(changes));
}
