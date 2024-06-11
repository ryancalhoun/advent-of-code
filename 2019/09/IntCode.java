import java.util.function.Consumer;
import java.util.function.Supplier;

public class IntCode {

  private String source;
  private Consumer<Long> output;

  java.util.Map<Integer,Supplier<Boolean>> op = new java.util.HashMap<Integer,Supplier<Boolean>>();

  private Long input;
  java.util.Map<Integer,Long> code = new java.util.HashMap<Integer,Long>();

  private int i = -1;
  private int base;

  public IntCode(String source, Consumer<Long> output) {
    this.source = source;
    this.output = output;

    loadInstructions();
    reset();
  }

  public void reset() {
    for(String v : source.split(","))
      code.put(++i, Long.parseLong(v));

    i = 0;

    signal(null);
  }

  public void signal(Long input) {
    this.input = input;

    while(!complete() && op.get(instruction()).get());
  }

  public boolean complete() {
    return i < 0;
  }

  private void loadInstructions() {
    op.put(1,  this::add);
    op.put(2,  this::multiply);
    op.put(3,  this::input);
    op.put(4,  this::output);
    op.put(99, this::halt);
    op.put(5,  this::jumpTrue);
    op.put(6,  this::jumpFalse);
    op.put(7,  this::lessThan);
    op.put(8,  this::equalTo);
    op.put(9,  this::relative);
  }

  private boolean add() {
    set(3, get(1) + get(2));
    i += 4;

    return true;
  }
  private boolean multiply() {
    set(3, get(1) * get(2));
    i += 4;

    return true;
  }
  private boolean input() {
    if(this.input == null)
      return false;

    set(1, this.input);
    this.input = null;

    i += 2;

    return true;
  }
  private boolean output() {
    output.accept(get(1));
    i += 2;

    return true;
  }
  private boolean jumpTrue() {
    if(get(1) != 0)
      i = (int)get(2);
    else
      i += 3;

    return true;
  }
  private boolean jumpFalse() {
    if(get(1) == 0)
      i = (int)get(2);
    else
      i += 3;

    return true;
  }
  private boolean lessThan() {
    set(3, get(1) < get(2) ? 1 : 0);
    i += 4;

    return true;
  }
  private boolean equalTo() {
    set(3, get(1) == get(2) ? 1 : 0);
    i += 4;

    return true;
  }
  private boolean relative() {
    base += get(1);
    i += 2;

    return true;
  }
  private boolean halt() {
    i = -1;

    return false;
  }

  private int instruction() {
    return (int)(code.get(i) % 100);
  }

  private long get(int p) {
    long m = code.get(i) / 100;
    long v = code.get(i+p);

    while(--p > 0)
      m /= 10;
    m %= 10;

    if(m == 1) {
      return v;
    } else if(m == 2) {
      return code.getOrDefault((int)v + base, 0l);
    } else {
      return code.getOrDefault((int)v, 0l);
    }
  }

  private void set(int p, long val) {
    long m = code.get(i) / 100;
    long v = code.get(i+p);

    while(--p > 0)
      m /= 10;
    m %= 10;

    if(m == 2) {
      code.put((int)v + base, val);
    } else {
      code.put((int)v, val);
    }
  }
}
