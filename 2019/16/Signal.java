public class Signal implements Phase {
  int [] signal;

  int [] add;
  int [] sub;

  public Signal(String signal) {
    this.signal = new int[signal.length()];

    for(int i = 0; i < signal.length(); ++i) {
      int v = Integer.parseInt(signal.substring(i, i+1));
      this.signal[i] = v;
    }

    this.add = new int[this.signal.length / 4];
    this.sub = new int[this.signal.length / 4];

    for(int i = 0, j = 0; j < add.length && i < this.signal.length; i += 4, ++j)
      add[j] = i;

    for(int i = 2, j = 0; j < sub.length && i < this.signal.length; i += 4, ++j)
      sub[j] = i;

  }

  public Signal(int [] signal, int [] add, int [] sub) {
    this.signal = signal;
    this.add = add;
    this.sub = sub;
  }

  public Phase phase() {
    int [] output = new int[signal.length];

    for(int i = 0; i < output.length; ++i) {
      for(int j = 0; j < add.length; ++j) {
        int begin = add[j] * (i + 1) + i;
        if(begin >= output.length)
          break;

        for(int m = begin; m >= 0 && m < begin + i + 1 && m < output.length; ++m) {
          output[i] += signal[m];
        }
      }
      for(int j = 0; j < sub.length; ++j) {
        int begin = sub[j] * (i + 1) + i;
        if(begin >= output.length)
          break;

        for(int m = begin; m >= 0 && m < begin + i + 1 && m < output.length; ++m) {
          output[i] -= signal[m];
        }
      }
      output[i] = Math.abs(output[i] % 10);
    }

    return new Signal(output, add, sub);
  }

  public int get(int i) {
    return signal[i];
  }
}
