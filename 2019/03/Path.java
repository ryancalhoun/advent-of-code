public class Path {
  private Line current;
  private int length;

  void add(Line line) {
    if(current != null)
      length += current.length();
    current = line;
  }

  public Point intersects(Path path) {
    return current.intersects(path.current);
  }

  public int length(Point to) {
    return this.length + current.length(to);
  }
}
