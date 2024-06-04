import java.io.BufferedReader;

public class App {
  public static void main(String [] args) {

    int part = Integer.parseInt(System.getenv("PART"));
    BufferedReader in = new BufferedReader(new java.io.InputStreamReader(System.in));

    Orbit orb = new Orbit();

    try {
      for(String line; (line = in.readLine()) != null;) {
        String [] s = line.split("\\)");

        orb.body(s[0]).add(s[1]);
      }
    } catch(java.io.IOException e){}

    int answer = part == 1 ? orb.countDepthsFrom("COM") : orb.countTransfersBetween("YOU", "SAN");

    System.out.println(answer);
  }
}
