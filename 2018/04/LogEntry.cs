using System.Text.RegularExpressions;

class LogEntry : IComparable<LogEntry> {
  int year;
  int month;
  int day;
  int hour;
  public int minute { get; }
  public int? id { get; }
  public bool asleep { get; }

  //enum 

  static Regex entry = new Regex(
    @"\[(?<year>\d{4})\-(?<month>\d{2})\-(?<day>\d{2}) (?<hour>\d{2}):(?<minute>\d{2})\] (?<message>.+)"
  );
  static Regex begin = new Regex(@"Guard #(?<id>\d+) begins shift");

  public LogEntry(string log) {
    Match m = entry.Match(log);

    year = Int32.Parse(m.Groups["year"].Value);
    month = Int32.Parse(m.Groups["month"].Value);
    day = Int32.Parse(m.Groups["day"].Value);
    hour = Int32.Parse(m.Groups["hour"].Value);
    minute = Int32.Parse(m.Groups["minute"].Value);

    asleep = m.Groups["message"].Value == "falls asleep";

    m = begin.Match(m.Groups["message"].Value);
    if(m.Success)
      id = Int32.Parse(m.Groups["id"].Value);

  }

  public int CompareTo(LogEntry? e) {
    if(e == null)
      return 1;

    if(year != e.year)
      return year - e.year;
    if(month != e.month)
      return month - e.month;
    if(day != e.day)
      return day - e.day;
    if(hour != e.hour)
      return hour - e.hour;
    return minute - e.minute;
  }
}
