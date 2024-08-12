import java.io.BufferedReader;

public class App {
  public static void main(String [] args) {

    int part = Integer.parseInt(System.getenv("PART"));
    BufferedReader in = new BufferedReader(new java.io.InputStreamReader(System.in));

    String code = null;
    try {
      code = in.readLine();
    } catch(java.io.IOException e) {}

    code = "" + part + code.substring(1);

    Robotic handler = part == 1 ? new Calibration() : new Echo();
    IntCode i = new IntCode(code, handler);

    if(part == 2) {
      for(char c : new Driver())
        i.signal((long)c);
    }

    System.out.println(handler.get());
  }
}
