public class IntCode {
  private int [] code;

  public IntCode(int [] code) {
    this.code = code;
  }

  public IntCode(String code) {
    this(java.util.Arrays.stream(code.split(",")).mapToInt(Integer::parseInt).toArray());
  }

  public int size() {
    return this.code.length;
  }

  public int run() {
    return run(code[1], code[2]);
  }

  public int run(int noun, int verb) {

    int [] code = this.code.clone();
    code[1] = noun;
    code[2] = verb;
 
    for(int i = 0; i < code.length && code[i] != 99; i += 4) {
      if(code[i] == 1) {
        code[code[i+3]] = code[code[i+1]] + code[code[i+2]];
      } else if(code[i] == 2) {
        code[code[i+3]] = code[code[i+1]] * code[code[i+2]];
      }
      else {
        throw new RuntimeException("unknown code");
      }
    }

    return code[0];
  }
}
