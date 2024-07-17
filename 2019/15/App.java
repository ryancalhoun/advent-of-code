import java.io.BufferedReader;

public class App {
  public static void main(String [] args) {

    int part = Integer.parseInt(System.getenv("PART"));
    BufferedReader in = new BufferedReader(new java.io.InputStreamReader(System.in));

    Droid d = null;

    try {
      d = new Droid(in.readLine());
    } catch(java.io.IOException e){}

    Space s = new Space(50, 50);

    int moves = s.find(d);

    if(part == 1) {
      System.out.println(moves);
    } else {
      System.out.println(s.flood());
    }
  }
}
