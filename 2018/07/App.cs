using System.IO;

IDictionary<string,string> arguments =
  args.Select(arg => arg.Split('=')).ToDictionary(s => s[0], s => s[1]);

Dictionary<char,List<char>> steps = new Dictionary<char,List<char>>();
HashSet<char> parents = new HashSet<char>();

using (StreamReader file = new StreamReader(arguments["file"])) {
  for(string? line; (line = file.ReadLine()) != null;) {
    char p = line[5];
    char c = line[36];

    if(! steps.ContainsKey(c))
      steps.Add(c, new List<char>());
    steps[c].Add(p);

    parents.Add(p);
  }
}

List<char> q = (from p in parents where !steps.ContainsKey(p) select p).ToList();
WorkQueue<InProgress> workers = arguments["part"] == "1" ?
  new WorkQueue<InProgress>(1) :
  new WorkQueue<InProgress>(Int32.Parse(arguments["workers"]));

int t = 0;
Func<char,int> until = arguments["part"] == "1" ?
  (s) => t + 1 :
  (s) => t + ((int)s - 64) + Int32.Parse(arguments["effort"]);

string order = "";

for(;; ++t) {
  workers.Sort();
  for(InProgress? p; (p = workers.Done(p => p.until == t)) != null;) {

    order += p.step;

    foreach(var s in steps) {
      if(s.Value.Contains(p.step)) {
        if(s.Value.Count == 1) {
          q.Add(s.Key);
        }
        s.Value.Remove(p.step);
      }
    }
  }

  q.Sort();
  while(q.Count > 0 && workers.Add(new InProgress(q[0], until(q[0])))) {
    q.RemoveAt(0);
  }

  if(workers.Done() && q.Count == 0)
    break;
}


if(arguments["part"] == "1") {
  Console.WriteLine(order);
} else {
  Console.WriteLine(t);
}

