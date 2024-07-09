import java.io.BufferedReader;

public class App {
  public static void main(String [] args) {

    int part = Integer.parseInt(System.getenv("PART"));
    BufferedReader in = new BufferedReader(new java.io.InputStreamReader(System.in));

    String code = null;

    try {
      code = in.readLine();
    } catch(java.io.IOException e){}

    if(part == 1) {
      Game game = new Game(code);
      System.out.println(game.countBlocks());
    } else {
      Game game = new Game("2" + code.substring(1));
      game.play();
      System.out.println(game.score());
    }
  }
}
