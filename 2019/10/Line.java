import java.util.Iterator;

public class Line implements Iterable<Point> {
  int size;
  Point slope;
  Point start;

  public Line(int size, Point slope, Point start) {
    this.size = size;
    this.slope = slope;
    this.start = start;
  }

  public String toString() {
    return "[" + start + "@" + slope + "]";
  }

  public Iterator<Point> iterator() {
    return new EachPoint(size, slope, start);
  }

  class EachPoint implements Iterator<Point> {
    int size;
    Point slope;
    Point p;

    EachPoint(int size, Point slope, Point p) {
      this.size = size;
      this.slope = slope;
      this.p = p;
    }

    public boolean hasNext() {
      return p.x < size && p.y < size && p.y >= 0;
    }

    public Point next() {
      Point q = p;
      p = new Point(q.x + slope.x, q.y + slope.y);

      return q;
    }
  }
}
