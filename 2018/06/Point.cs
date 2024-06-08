class Point {
  public int x { get; }
  public int y { get; }

  public Point(int x, int y) {
    this.x = x;
    this.y = y;
  }

  public Point(string p) {
    IList<int> c = p.Split(", ").Select(i => Int32.Parse(i)).ToList();
    this.x = c[0];
    this.y = c[1];
  }

  public int Distance(int x, int y) {
    return Math.Abs(this.x - x) + Math.Abs(this.y - y);
  }

  public override string ToString() {
    return $"({x},{y})";
  }
}
