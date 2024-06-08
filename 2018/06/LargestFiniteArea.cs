class LargestFiniteArea : IGridVisitor<int> {
  IList<Point> points;
  int [] area;
  int xmin, xmax, ymin, ymax;

  public LargestFiniteArea(IList<Point> points) {
    this.points = points;
    this.area = new int[points.Count];

    this.xmin = points.Min(p => p.x);
    this.ymin = points.Min(p => p.y);
    this.xmax = points.Max(p => p.x);
    this.ymax = points.Max(p => p.y);
  }

  public void Visit(int x, int y) {
    Dictionary<int,List<int>> d = new Dictionary<int,List<int>>();
    for(int i = 0; i < points.Count; ++i) {
      int distance = points[i].Distance(x, y);

      if(! d.ContainsKey(distance))
        d.Add(distance, new List<int>());
      d[distance].Add(i);
    }

    List<int> closest = d.MinBy(v => v.Key).Value;
    if(closest.Count == 1) {
      if(x == xmin || x == xmax || y == ymin || y == ymax) {
        area[closest[0]] = -1;
      } else if(area[closest[0]] > -1) {
        ++area[closest[0]];
      }
    }
  }

  public int Value() {
    return area.Max();
  }
}
