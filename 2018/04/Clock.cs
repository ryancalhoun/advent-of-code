class Clock {
  int [] minutes;

  public Clock() {
    minutes = new int[60];
  }

  public void Count(int start, int stop) {
    for(int i = start; i < stop; ++i)
      ++minutes[i];
  }

  public int Max() {
    return minutes.Max();
  }

  public int MostFrequent() {
    return Array.IndexOf(minutes, Max());
  }
}
