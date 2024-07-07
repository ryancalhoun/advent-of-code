import java.util.Iterator;

public class SlopesFor implements Iterable<Point> {
  public final int size;

  public SlopesFor(int size) {
    this.size = size;
  }

  public Iterator<Point> iterator() {
    return new EachSlope(size);
  }

  class EachSlope implements Iterator<Point> {
    int x, y;
    int inc;
    private boolean skip[][];

    EachSlope(int size) {
      this.x = 1;
      this.y = 0;
      this.inc = 1;
      this.skip = new boolean[size][size];
    }

    public boolean hasNext() {
      return y > -size;
    }
    public Point next() {
      Point p = new Point(x, y);

      if(y == 0) {
        x = 0;
        y = 1;
      } else {

        if(x > 0 && y > 0) {
          for(int m = 2; x*m <= size && y*m <= size; ++m) {
            skip[x*m-1][y*m-1] = true;
          }
        }

        for(;;) {
          if(++x == size) {
            x = 1;
            y += inc;
          }
          if(y == size) {
            inc = -1;
            y = -1;
          }
          if(y == -size || !skip[x-1][y*inc-1])
            break;
        }
      }

      return p;
    }
  }
}
