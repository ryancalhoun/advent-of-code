class MostDenseArea : IGridVisitor<int> {
  IList<Point> points;
  int limit;
  int size;

  public MostDenseArea(IList<Point> points, int limit) {
    this.points = points;
    this.limit = limit;
  }

  public void Visit(int x, int y) {
    if((from p in points select p.Distance(x, y)).Sum() < limit)
      ++size;
  }

  public int Value() {
    return size;
  }
}
