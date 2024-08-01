import java.io.BufferedReader;

public class App {
  public static void main(String [] args) {

    int part = Integer.parseInt(System.getenv("PART"));
    BufferedReader in = new BufferedReader(new java.io.InputStreamReader(System.in));

    String data = null;

    try {
      data = in.readLine();
    } catch(java.io.IOException e){}

    Phase p = null;
    if(part == 1) {
      p = new Signal(data);
    } else {
      p = new Triangle(data);
    }

    for(int i = 0; i < 100; ++i) {
      p = p.phase();
    }

    for(int i = 0; i < 8; ++i) {
      System.out.print(p.get(i) + " ");
    }
  }
}
