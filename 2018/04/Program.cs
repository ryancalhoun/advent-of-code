void Coorelate(IList<LogEntry> log, IDictionary<int, Guard> guards) {
  Guard? guard = null;

  foreach(LogEntry e in log) {
    if(e.id != null) {
      int id = (int)e.id;
      if(guards.ContainsKey(id))
        guard = guards[id];
      else
        guards.Add(id, guard = new Guard(id));
    } else {
      guard!.Add(e);
    }
  }
}

List<LogEntry> log = new List<LogEntry>();

for(string? line; (line = Console.ReadLine()) != null;) {
  log.Add(new LogEntry(line));
}

log.Sort();

Dictionary<int,Guard> guards = new Dictionary<int,Guard>();
Coorelate(log, guards);

Guard? guard = null;
Clock? clock = null;

if(Environment.GetEnvironmentVariable("PART") == "1") {
  guard = guards.Values.MaxBy(g => g.TotalMinutesAsleep())!;
  clock = guard!.CountSleep();
} else {
  Dictionary<int,Clock> sleep = new Dictionary<int,Clock>();
  foreach(Guard g in guards.Values) {
    sleep.Add(g.id, g.CountSleep());
  }
  int id = sleep.MaxBy(s => s.Value.Max()).Key;

  guard = guards[id];
  clock = sleep[id];
}

Console.WriteLine(guard.id * clock.MostFrequent());
