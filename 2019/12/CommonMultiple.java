public class CommonMultiple {
  long val = 1;
  int n;
  boolean [] seen;

  public CommonMultiple(int n) {
    this.n = n;
    this.seen = new boolean[n];
  }

  public void mul(int i, long a) {
    if(seen[i])
      return;
    seen[i] = true;

    if(val == 1 || val == a) {
      val = a;
      return;
    }

    long gcd = 1;
    for(long j = 1; j <= a && j <= val; ++j)
      if(a % j == 0 && val % j == 0)
        gcd = j;

    val = (a*val) / gcd;
  }

  public int count() {
    int c = 0;
    for(boolean b : seen) {
      if(b)
        ++c;
    }
    return c;
  }

  public boolean seen(int i) {
    return seen[i];
  }

  public long value() {
    return val;
  }
}
