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
for(string? line; (line = Console.ReadLine()) != null;) {
  IDs.Add(line);
}

if(Environment.GetEnvironmentVariable("PART") == "1") {
  Console.WriteLine(Checksum(IDs));
} else {
  Console.WriteLine(FindClosest(IDs));
}
