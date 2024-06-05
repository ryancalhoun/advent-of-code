import java.io.BufferedReader;

public class App {
  public static void main(String [] args) {

    int part = Integer.parseInt(System.getenv("PART"));
    BufferedReader in = new BufferedReader(new java.io.InputStreamReader(System.in));

    try {
      for(String line; (line = in.readLine()) != null; ){
        System.out.println(optimalPowerFor(part == 1 ? 0 : 5, line));
      }
    } catch(java.io.IOException e) {}

  }

  public static int optimalPowerFor(int phaseStart, String code) {
    PowerAmpSeries series = new PowerAmpSeries(5, code);

    Sequence s = new Sequence(phaseStart, 5);
    Maximal<int[]> max = new Maximal<int[]>(v -> { return series.run(v); });

    s.permutations(max::add);

    return max.get();
  }
}
