import java.util.function.Consumer;

public class Droid implements Consumer<Long> {
  IntCode computer;
  Long val;

  public Droid(String code) {
    computer = new IntCode(code, this);
  }

  public int move(int d) {
    computer.signal((long)d);
    return (int)(long)val;
  }

  public void accept(Long val) {
    this.val = val;
  }
}
