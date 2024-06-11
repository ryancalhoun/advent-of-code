import java.io.BufferedReader;

public class App {
  public static void main(String [] args) {

    int part = Integer.parseInt(System.getenv("PART"));
    BufferedReader in = new BufferedReader(new java.io.InputStreamReader(System.in));

    try {
      for(String line; (line = in.readLine()) != null; ){
        run(part, line);
      }
    } catch(java.io.IOException e) {}
  }

  public static void run(long part, String code) {
    IntCode computer = new IntCode(code, (out -> System.out.println(out)));
    computer.signal(part);
  }
}
