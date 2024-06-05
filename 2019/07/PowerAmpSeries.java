import java.util.function.Consumer;

public class PowerAmpSeries {
  private PowerAmp [] series;
  private int power;

  public PowerAmpSeries(int n, String code) {
    series = new PowerAmp[n];

    while(n-- > 0) {
      final int i = n;
      series[i] = new PowerAmp(code, value -> output(i, value));
    }
  }

  public int run(int [] phases) {
    power = 0;

    for(int i = 0; i < series.length; ++i) {
      series[i].reset(phases[i]);
    }

    while(!series[0].complete()) {
      series[0].signal(power);
    }

    return power;
  }

  private void output(int i, int value) {
    if(i+1 < series.length)
      series[i+1].signal(value);
    else
      power = value;
  }
}
