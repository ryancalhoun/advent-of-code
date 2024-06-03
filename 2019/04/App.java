import java.io.BufferedReader;

public class App {
  public static void main(String [] args) {

    int part = Integer.parseInt(System.getenv("PART"));
    BufferedReader in = new BufferedReader(new java.io.InputStreamReader(System.in));

    Code code = null;

    try {
      String [] v = in.readLine().split("-");

      int min = Integer.parseInt(v[0]);
      int max = Integer.parseInt(v[1]); 

      code = new Code(min, max);

    } catch(java.io.IOException e) {}

    System.out.println(code.count(part == 1 ? new AnyTwoRepeat() : new ExactlyTwoRepeat()));
  }
}
