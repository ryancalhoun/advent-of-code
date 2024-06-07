class Guard {
  List<LogEntry> log = new List<LogEntry>();

  public int id { get; }

  public Guard(int id) {
    this.id = id;
  }

  public void Add(LogEntry log) {
    this.log.Add(log);
  }

  public int TotalMinutesAsleep() {
    int asleep = 0;
    SleepTimes((int start, int end) => asleep += (end - start));
    return asleep;
  }

  public Clock CountSleep() {
    Clock clock = new Clock();
    SleepTimes((int start, int end) => {
      clock.Count(start, end);
    });
    return clock;
  }

  void SleepTimes(Action <int, int> f) {
    LogEntry? start = null;

    foreach(LogEntry e in log) {
      if(e.asleep) {
        start = e;
      } else {
        f(start!.minute, e.minute);
      }
    }
  }
}
