class InProgress : IComparable<InProgress> {
  public char step { get; }
  public int until { get; }

  public InProgress(char step, int until) {
    this.step = step;
    this.until = until;
  }

  public int CompareTo(InProgress? p) {
    return until.CompareTo(p!.until);
  }
}

