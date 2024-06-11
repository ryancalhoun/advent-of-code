using System.IO;

IDictionary<string,string> arguments =
  args.Select(arg => arg.Split('=')).ToDictionary(s => s[0], s => s[1]);

int Checksum(List<string> IDs) {
  int two = 0;
  int three = 0;

  foreach(string ID in IDs) {
    var g = from c in ID group c by c into w select w.Count();

    if(g.Contains(2)) {
      ++two;
    }
    if(g.Contains(3)) {
      ++three;
    }
  }
  return two * three;
}

string FindClosest(List<string> IDs) {
  for(int i = 0; i + 1 < IDs.Count; ++i) {
    for(int j = i + 1; j < IDs.Count; ++j) {
      string common = "";

      for(int k = 0; k < IDs[i].Length; ++k) {
        if(IDs[i][k] == IDs[j][k])
          common += IDs[i][k];
      }

      if(common.Length + 1 == IDs[i].Length)
        return common;
    }
  }
  throw new IndexOutOfRangeException("no match");
}

List<string> IDs = new List<string>();
using (StreamReader file = new StreamReader(arguments["file"])) {
  for(string? line; (line = file.ReadLine()) != null;) {
    IDs.Add(line);
  }
}

if(arguments["part"] == "1") {
  Console.WriteLine(Checksum(IDs));
} else {
  Console.WriteLine(FindClosest(IDs));
}
