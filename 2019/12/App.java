import java.io.BufferedReader;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class App {
  public static void main(String [] args) {

    int part = Integer.parseInt(System.getenv("PART"));
    int steps = Integer.parseInt(System.getenv("STEPS"));
    BufferedReader in = new BufferedReader(new java.io.InputStreamReader(System.in));

    Universe u = new Universe();

    try {
      Pattern p = Pattern.compile("-?\\d+");
      for(String line; (line = in.readLine()) != null;) {
        Matcher m = p.matcher(line);
        int [] pos = m.results().map(r -> r.group()).mapToInt(Integer::parseInt).toArray();

        u.add(new Moon(pos));
      }
    } catch(java.io.IOException e){}

    if(part == 1) {
      for(int t = 0; t < steps; ++t)
        u.step();
      System.out.println(u.totalEnergy());
    } else {
      System.out.println(u.stepsUntilRepeat());
    }
  }
}
