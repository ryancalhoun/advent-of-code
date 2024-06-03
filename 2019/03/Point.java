public class Point {
  public int x, y;

  public Point() {
    this(0, 0);
  }

  public Point(int x, int y) {
    this.x = x;
    this.y = y;
  }

  public String toString() {
    return "(" + x + "," + y + ")";
  }

  public int manhattan() {
    return Math.abs(x) + Math.abs(y);
  }
}
