import java.util.function.Consumer;
import java.util.function.Supplier;

public class IntCode {

  private String source;
  private Consumer<Integer> output;

  java.util.Map<Integer,Supplier<Boolean>> op = new java.util.HashMap<Integer,Supplier<Boolean>>();

  private Integer input;
  private int [] code;
  private int i;

  public IntCode(String source, Consumer<Integer> output) {
    this.source = source;
    this.output = output;

    loadInstructions();
    reset();
  }

  public void reset() {
    code = java.util.Arrays.stream(source.split(",")).mapToInt(Integer::parseInt).toArray();
    i = 0;

    signal(null);
  }

  public void signal(Integer input) {
    this.input = input;

    while(!complete() && op.get((int)code[i] % 100).get());
  }

  public boolean complete() {
    return code != null && i == code.length;
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
  }

  private boolean add() {
    code[(int)code[i+3]] = get(1) + get(2);
    i += 4;

    return true;
  }
  private boolean multiply() {
    code[(int)code[i+3]] = get(1) * get(2);
    i += 4;

    return true;
  }
  private boolean input() {
    if(this.input == null)
      return false;

    code[(int)code[i+1]] = this.input;
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
    code[(int)code[i+3]] = get(1) < get(2) ? 1 : 0;
    i += 4;

    return true;
  }
  private boolean equalTo() {
    code[(int)code[i+3]] = get(1) == get(2) ? 1 : 0;
    i += 4;

    return true;
  }
  private boolean halt() {
    i = code.length;

    return false;
  }

  private int get(int p) {
    int m = (int)code[i] / 100;
    int v = code[i+p];

    while(--p > 0)
      m /= 10;
    m %= 10;

    if(m == 0) {
      return code[(int)v];
    } else {
      return v;
    }
  }
}
