import java.util.function.Consumer;
import java.util.Set;
import java.util.HashSet;

public class Game implements Consumer<Long> {
  IntCode computer;

  Long x, y;
  long score;

  Set<Point> blocks = new HashSet<Point>();
  Point ball;
  Point paddle;

  public Game(String code) {
    computer = new IntCode(code, this);
  }

  public int countBlocks() {
    return blocks.size();
  }

  public long score() {
    return score;
  }

  public void play() {
    while(! computer.complete()) {
      long joystick = ball.x - paddle.x;
      blocks.remove(ball);
      computer.signal(joystick);
    }
  }

  public void accept(Long val) {
    if(x == null) {
      x = val;
    } else if(y == null) {
      y = val;
    } else {

      if(val == 2) {
        blocks.add(new Point(x, y));
      }

      if(val == 3) {
        paddle = new Point(x, y);
      }

      if(val == 4) {
        ball = new Point(x, y);
      }

      if(x == -1 && y == 0) {
        score = val;
      }

      x = null;
      y = null;
    }
  }
}
