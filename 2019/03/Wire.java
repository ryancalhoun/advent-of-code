import java.util.stream.Collectors;

public class Wire {
  java.util.List<Point> points;

  public void load(String path) {
    
    points = new java.util.ArrayList<Point>();
    points.add(new Point());

    for(String step : path.split(",")) {
      Point p = points.get(points.size() - 1);

      char d = step.charAt(0);
      int n = Integer.parseInt(step.substring(1));

      if(d == 'R')
        points.add(new Point(p.x + n, p.y));
      else if(d == 'L')
        points.add(new Point(p.x - n, p.y));
      else if(d == 'U')
        points.add(new Point(p.x, p.y + n));
      else if(d == 'D')
        points.add(new Point(p.x, p.y - n));
    }
  }

  private static interface EachSegment {
    int call(Path wire);
  }

  private int eachSegment(EachSegment e) {
    int result = -1;

    Path path = new Path();

    Point p0 = points.get(0);
    for(Point p1 : points.subList(1, points.size())) {
      path.add(new Line(p0, p1));

      int value = e.call(path);
      if(result == -1 || (value != -1 && value < result))
        result = value;

      p0 = p1;
    }
    return result;
  }

  public static interface EachIntersect {
    int call(Path a, Path b, Point p);
  }

  public int intersects(Wire w, EachIntersect e) {
    return eachSegment((a) -> {
      return w.eachSegment((b) -> {
        Point p = a.intersects(b);

        if(p == null || p.manhattan() == 0)
          return -1;

        return e.call(a, b, p);

        //return p.manhattan();

        //return a.length(p) + b.length(p);
      });
    });
  }

  public String toString()
  {
    return "[" + points.stream().map(Point::toString).collect(Collectors.joining(",")) + "]";
  } 

}
