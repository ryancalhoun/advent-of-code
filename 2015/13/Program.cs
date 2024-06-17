using System.Diagnostics;
using System.IO;

IDictionary<string,string> arguments =
  args.Select(arg => arg.Split('=')).ToDictionary(s => s[0], s => s[1]);

int MaxPermutation(int n, Func<IList<int>,int> cost) {
  int max = 0;

  ProcessStartInfo si = new ProcessStartInfo();
  si.FileName = "octave";
  si.RedirectStandardInput = true;
  si.RedirectStandardOutput = true;

  Process? perms = Process.Start(si);

  using (StreamWriter sw = perms!.StandardInput)
  using (StreamReader sr = perms!.StandardOutput) {
    sw.WriteLine($"perms(0:{n-1})");
    sw.Close();

    for(string? line; (line = sr.ReadLine()) != null;) {
      IList<int> p = line.Split(' ').Where(x => Int32.TryParse(x, out _)).Select(Int32.Parse).ToList();
      if(p.Count != n)
        continue;
      int c = cost(p);

      if(c > max)
        max = c;
    }
  }
  return max;
}

IDictionary<string,IDictionary<string,int>> effect = new Dictionary<string,IDictionary<string,int>>();
using (StreamReader file = new StreamReader(arguments["file"])) {
  for(string? line; (line = file.ReadLine()) != null;) {
    IList<string> s = line.Split(' ');
    string a = s[0];
    string b = s[10].TrimEnd(new char[]{ '.' });
    int e = Int32.Parse(s[3]) * (s[2] == "gain" ? 1 : -1);

    if(! effect.ContainsKey(a))
      effect.Add(a, new Dictionary<string,int>());

    effect[a].Add(b, e);
  }
}

IList<string> people = effect.Keys.ToList();

int tableSize = people.Count;
if(arguments["part"] == "2")
  tableSize += 1;

int max = MaxPermutation(tableSize, (p) => {
  int cost = 0;

  for(int i = 0; i < p.Count; ++i) {
    int person = p[i];
    int left = p[(i==0?p.Count:i) - 1];
    int right = p[(i+1)%p.Count];

    if(person == people.Count)
      continue;

    if(left != people.Count)
      cost += effect[people[person]][people[left]];

    if(right != people.Count)
      cost += effect[people[person]][people[right]];
  }

  return cost;
});

Console.WriteLine(max);
