import java.io.BufferedReader;
import java.util.Collections;
import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;

public class App {
  public static void main(String [] args) {

    int part = Integer.parseInt(System.getenv("PART"));
    BufferedReader in = new BufferedReader(new java.io.InputStreamReader(System.in));

    Map<Point,List<Point>> asteroids = new HashMap<Point,List<Point>>();
    int size = 0;

    try {
      for(String line; (line = in.readLine()) != null; ++size) {
        for(int x = 0; x < line.length(); ++x) {
          if(line.charAt(x) == '#') {
            asteroids.put(new Point(x, size), new ArrayList<Point>());
          }
        }
      }
    } catch(java.io.IOException e){}

    for(Point slope : new SlopesFor(size)) {
      for(Line line : new Field(size, slope)) {

        Point last = null;
        for(Point p : line) {
          List<Point> i = asteroids.get(p);

          if(i != null) {
            if(last != null) {
              List<Point> j = asteroids.get(last);
              i.add(last);
              j.add(p);
            }

            last = p;
          }
        }
      }
    }

    Map.Entry<Point,List<Point>> best = Collections.max(asteroids.entrySet(), (e1, e2) -> e1.getValue().size() - e2.getValue().size());

    if(part == 1) {
      System.out.println(best.getValue().size());
    } else {
      Point b = best.getKey();

      List<Circular> closest = new ArrayList<Circular>();

      for(Point p : best.getValue()) {
        int vx = p.x - b.x;
        int vy = b.y - p.y;

        double a = (Math.atan2(vx,vy) % (Math.PI*2) + Math.PI*2) % (Math.PI*2);
        closest.add(new Circular(p, a));
      }

      Collections.sort(closest, (c1, c2) -> Double.compare(c1.a, c2.a));

      Point t = closest.get(199).p;
      System.out.println(t.x * 100 + t.y);
    }
  }
}
