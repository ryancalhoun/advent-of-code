public class Code {
  private int min, max;
  private int [] digits = { 0, 0, 0, 0, 0, 0 };

  public Code(int min, int max) {
    this.min = min;
    this.max = max;    

    initialize();
  }

  private void initialize() {
    for(int i = digits.length-1, v = this.min; i >= 0; --i, v /= 10) {
      digits[i] = v % 10;
    }

    for(int i = 1; i < digits.length; ++i) {
      if(digits[i] < digits[i-1]) {
        roll(i);
        break;
      }
    }
  }

  private int value() {
    int v = 0;
    for(int d : digits) {
      v *= 10;
      v += d;
    }

    return v;
  }

  private void roll(int i) {
    for(; i < digits.length; ++i)
      digits[i] = digits[i-1];
  }

  public interface If {
    public boolean call(int [] digits);
  }

  public int count(If f) {
    return count(f, 0);
  }

  private int count(If f, int i) {
    if(i == digits.length) {
      return f.call(digits) ? 1 : 0;
    }

    int sum = 0;

    while(digits[i] < 10) {
      sum += count(f, i+1);

      ++digits[i];
      roll(i+1);

      if(value() > max)
        break;
    }

    return sum;
  }
}
