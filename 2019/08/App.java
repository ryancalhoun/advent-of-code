import java.io.InputStreamReader;

public class App {
  public static void main(String [] args) {

    int part = Integer.parseInt(System.getenv("PART"));
    int width = Integer.parseInt(System.getenv("WIDTH"));
    int height = Integer.parseInt(System.getenv("HEIGHT"));

    SpaceImage image = new SpaceImage(width, height);

    InputStreamReader in = new InputStreamReader(System.in);

    for(int p = 0;;) {
      try { p = in.read(); }
      catch(java.io.IOException e) {}

      p -= '0';

      if(p < 0 || p > 9)
        break;

      image.add(p);
    }

    if(part == 1) {
      System.out.println(image.check());
    } else {
      System.out.println(image.flatten());
    }
  }
}
