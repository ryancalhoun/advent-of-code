import java.util.function.Consumer;

public class Robot implements Consumer<Long> {

  IntCode computer;
  Long color;

  Point pos;
  int [] face;

  public Robot(String code) {
    this.computer = new IntCode(code, this);

    this.pos = new Point(0, 0);
    this.face = new int[] { 0, -1 };
  }

  public boolean read(boolean in) {
    color = null;
    computer.signal(in ? 1l : 0l);

    return color != null;
  }

  public void move() {
    this.pos = new Point(pos.x + face[0], pos.y + face[1]);
  }

  public boolean spray() {
    return color == 1l;
  }

  public Point pos() {
    return pos;
  }

  public void accept(Long v) {
    if(color == null) {
      color = v;
    } else {
      this.face = v == 1l ? new int[]{ -face[1], face[0] } : new int[]{ face[1], -face[0] };
    }
  }
}
