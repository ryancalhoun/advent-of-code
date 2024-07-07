import java.io.BufferedReader;
import java.util.Map;
import java.util.HashMap;

public class App {
  public static void main(String [] args) {

    int part = Integer.parseInt(System.getenv("PART"));
    BufferedReader in = new BufferedReader(new java.io.InputStreamReader(System.in));

    Robot robot = null;

    try {
       robot = new Robot(in.readLine());
    } catch(java.io.IOException e){}

    Map<Point,Boolean> panels = new HashMap<Point,Boolean>();

    for(Boolean color = part != 1; robot.read(color != null && color == true); color = panels.get(robot.pos())) {
      panels.put(robot.pos(), robot.spray());
      robot.move();
    }

    if(part == 1) {
      System.out.println(panels.size());
    } else {
      for(int i = 0; i < 6; ++i) {
        for(int j = 0; j < 40; ++j) {
          Boolean b = panels.get(new Point(j, i));
          System.out.print(b != null && b == true ? '#' : ' ');
        }
        System.out.println();
      }
    }
  }
}
