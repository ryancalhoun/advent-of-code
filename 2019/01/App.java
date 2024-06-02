import java.io.BufferedReader;

public class App {
  public static void main(String [] args) {

    final int part = Integer.parseInt(System.getenv("PART"));
    BufferedReader in = new BufferedReader(new java.io.InputStreamReader(System.in));

    Fuel f = new Fuel();

    try {
      for(String line; (line = in.readLine()) != null; ) {
        int added = f.addMass(Integer.parseInt(line));

        while(part == 2 && added > 0)
          added = f.addMass(added);
      }
    } catch(java.io.IOException e) {}

    System.out.println(f.getTotal());
  }

}
