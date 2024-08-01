public class Triangle implements Phase {
  int [] signal;

  public Triangle(String signal) {
    int offset = Integer.parseInt(signal.substring(0, 7));

    this.signal = new int[signal.length()*10000 - offset];

    for(int i = 0; i < this.signal.length; ++i) {
      int j = (offset + i) % signal.length();
      int v = Integer.parseInt(signal.substring(j, j+1));
      this.signal[i] = v;
    }
  }

  Triangle(int [] signal) {
    this.signal = signal;
  }

  public Phase phase() {
    int [] output = new int[signal.length];

    for(int i = 0; i < output.length; ++i) {
      int j = output.length - i - 1;
      output[j] = signal[j];
      if(i > 0)
        output[j] += output[j+1];

      output[j] = Math.abs(output[j] % 10);
    }

    return new Triangle(output);
  }

  public int get(int i) {
    return signal[i];
  }
}
