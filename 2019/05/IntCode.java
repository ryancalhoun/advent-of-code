public class IntCode {

  public static interface Input {
    public int call();
  }
  public static interface Output {
    public void call(int v);
  }

  Input in;
  Output out;

  @FunctionalInterface
  interface Op {
    public int call(int [] code, int i);
  }

  java.util.Map<Integer,Op> op = new java.util.HashMap<Integer,Op>();

  public IntCode(Input in, Output out) {
    this.in = in;
    this.out = out;

    loadBasicInstructions();
  }

  private void loadBasicInstructions() {
    op.put(1,  this::add);
    op.put(2,  this::multiply);
    op.put(3,  this::input);
    op.put(4,  this::output);
    op.put(99, this::halt);
  }

  public void loadExtendedInstructions() {
    op.put(5,  this::jumpTrue);
    op.put(6,  this::jumpFalse);
    op.put(7,  this::lessThan);
    op.put(8,  this::equalTo);
  }

  public void run(String code) {
    run(java.util.Arrays.stream(code.split(",")).mapToInt(Integer::parseInt).toArray());
  }

  public void run(int [] code) {
    for(int i = 0; i < code.length;)
      i = op.get(code[i] % 100).call(code, i);
  }

  private int add(int [] code, int i) {
    int c = code[i];

    code[code[i+3]] = get(code, i, 1) + get(code, i, 2);
    return i + 4;
  }
  private int multiply(int [] code, int i) {
    code[code[i+3]] = get(code, i, 1) * get(code, i, 2);
    return i + 4;
  }
  private int input(int [] code, int i) {
    code[code[i+1]] = in.call();
    return i + 2;
  }
  private int output(int [] code, int i) {
    out.call(get(code, i, 1));
    return i + 2;
  }
  private int jumpTrue(int [] code, int i) {
    if(get(code, i, 1) != 0)
      return get(code, i, 2);
    return i + 3;
  }
  private int jumpFalse(int [] code, int i) {
    if(get(code, i, 1) == 0)
      return get(code, i, 2);
    return i + 3;
  }
  private int lessThan(int [] code, int i) {
    code[code[i+3]] = get(code, i, 1) < get(code, i, 2) ? 1 : 0;
    return i + 4;
  }
  private int equalTo(int [] code, int i) {
    code[code[i+3]] = get(code, i, 1) == get(code, i, 2) ? 1 : 0;
    return i + 4;
  }
  private int halt(int [] code, int i) {
    return code.length;
  }

  private int get(int [] code, int i, int p) {
    int m = code[i] / 100;
    int v = code[i+p];

    while(--p > 0)
      m /= 10;
    m %= 10;

    if(m == 0) {
      return code[v];
    } else {
      return v;
    }
  }
}
