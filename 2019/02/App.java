import java.io.BufferedReader;
import java.util.Arrays;

public class App {
  public static void main(String [] args) {

    int part = Integer.parseInt(System.getenv("PART"));
    BufferedReader in = new BufferedReader(new java.io.InputStreamReader(System.in));

    App app = null;
    try {
      app = new App(new IntCode(in.readLine()));
    } catch(java.io.IOException e) {}

    if(part == 1) {
      int noun = Integer.parseInt(System.getenv("NOUN"));
      int verb = Integer.parseInt(System.getenv("VERB"));

      System.out.println(app.runWithDefaults(noun, verb));
    } else {
      int target = Integer.parseInt(System.getenv("TARGET"));

      System.out.println(app.findTargetValue(target));
    }
  }

  private IntCode computer;
  App(IntCode computer) {
    this.computer = computer;
  }

  int runWithDefaults(int noun, int verb) {
    return computer.run(noun, verb);
  }

  int findTargetValue(int target) {
    for(int noun = 0; noun < 100; ++noun) {
      for(int verb = 0; verb < 100; ++verb) {
        try {
          if(computer.run(noun, verb) == target) {
            return noun * 100 + verb;
          }
        } catch(RuntimeException e) {}
      }
    }

    return -1;
  }
}
