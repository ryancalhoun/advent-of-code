import java.util.function.Consumer;

public class PowerAmp {

  private IntCode computer;

  public PowerAmp(String code, Consumer<Integer> output) {
    this.computer = new IntCode(code, output);
  }

  public void reset(int phase) {
    computer.reset();
    computer.signal(phase);
  }

  public void signal(int input) {
    computer.signal(input);
  }

  public boolean complete() {
    return computer.complete();
  }
}
