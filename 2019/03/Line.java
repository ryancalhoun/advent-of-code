public class Line {
  private Point start, end;

  public Line(Point start, Point end) {
    this.start = start;
    this.end = end;
  }

  public Point min() {
    return (end.x < start.x || end.y < start.y) ? end : start;
  }
  public Point max() {
    return (end.x > start.x || end.y > start.y) ? end : start;
  }

  public Point intersects(Line line) {
    if(max().x < line.min().x || min().x > line.max().x)
      return null;
    if(max().y < line.min().y || min().y > line.max().y)
      return null;

    if(start.x == end.x)
      return new Point(start.x, line.start.y);
    else
      return new Point(line.start.x, start.y);
  }

  public int length() {
    return (max().x - min().x) + (max().y - min().y);
  }

  public int length(Point to) {
    return Math.abs(start.x - to.x) + Math.abs(start.y - to.y);
  }
}
