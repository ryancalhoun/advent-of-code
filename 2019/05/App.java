import java.io.BufferedReader;

public class App {
  public static void main(String [] args) {

    int part = Integer.parseInt(System.getenv("PART"));
    BufferedReader in = new BufferedReader(new java.io.InputStreamReader(System.in));

    String line = null;
    try {
      line = in.readLine();
    } catch(java.io.IOException e) {}

    IntCode computer = new IntCode(
      () -> { return Integer.parseInt(System.getenv("PARAMETER")); },
      (x) -> System.out.println(x));

    if(part == 2)
      computer.loadExtendedInstructions();

    computer.run(line);
    

  }
}
