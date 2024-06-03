import java.io.BufferedReader;

public class App {
  public static void main(String [] args) {

    int part = Integer.parseInt(System.getenv("PART"));
    BufferedReader in = new BufferedReader(new java.io.InputStreamReader(System.in));

    Wire.EachIntersect each = part == 1 ?
      (m, n, p) -> { return p.manhattan(); } :
      (m, n, p) -> { return m.length(p) + n.length(p); };

    Wire a = new Wire();
    Wire b = new Wire();
    try {
      for(String line; (line = in.readLine()) != null; ) {
        a.load(line);
        b.load(in.readLine());

        System.out.println(a.intersects(b, each));
      }
    } catch(java.io.IOException e){}

  }
}
