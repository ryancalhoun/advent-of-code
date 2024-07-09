import java.util.Objects;

public class Point implements Comparable<Point> {
  public final int x;
  public final int y;

  public Point(int x, int y) {
    this.x = x;
    this.y = y;
  }

  public Point(long x, long y) {
    this((int)x, (int)y);
  }

  public int compareTo(Point p) {
    int dy = this.y - p.y;

    if(dy == 0)
      return this.x - p.x;

    return dy;
  }

  @Override
  public boolean equals(Object p) {
    return this.x == ((Point)p).x && this.y == ((Point)p).y;
  }

  @Override
  public int hashCode() {
    return Objects.hash(x, y);
  }

  public String toString() {
    return x + "," + y;
  }
}
