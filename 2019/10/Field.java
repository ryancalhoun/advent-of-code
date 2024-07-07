import java.util.Iterator;

class Field implements Iterable<Line> {
  int size;
  Point slope;

  public Field(int size, Point slope) {
    this.size = size;
    this.slope = slope;
  }

  public Iterator<Line> iterator() {
    return new EachLine(size, slope);
  }

  class EachLine implements Iterator<Line> {
    int size;
    Point slope;

    int x, y;
    int inc;

    EachLine(int size, Point slope) {
      this.size = size;
      this.slope = slope;

      this.x = 0;
      this.y = 0;
      this.inc = 1;

      if(slope.y < 0) {
        this.y = size-1;
        this.inc = -1;
      }
    }
    public boolean hasNext() {
      if(slope.x == 0)
        return x < size;

      if(slope.y < 0)
        return y >= 0;

      return y < size;
    }
    public Line next() {
      Line l = new Line(size, slope, new Point(x, y));

      if(slope.y == 0) {
        ++y;
      } else if(slope.x == 0) {
        ++x;
      } else if(slope.y > 0) {
        int col = y < slope.y ? size : slope.x;

        if(++x >= col) {
          x = 0;
          ++y;
        }
      } else {
        int col = y >= size+slope.y ? size : slope.x;

        if(++x >= col) {
          x = 0;
          --y;
        }
      }

      return l;
    }
  }
}
