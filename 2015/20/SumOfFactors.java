import java.io.BufferedReader;
import java.io.InputStreamReader;

public class SumOfFactors {
  static int [] primes = { 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71 };

  static int [] split(String s) {
    return java.util.Arrays.stream(s.split(" ")).mapToInt(Integer::parseInt).toArray();
  }

  static String join(int [] a) {
    return String.join(" ", java.util.Arrays.stream(a).mapToObj(String::valueOf).toArray(String[]::new));
  }

  static int [] factors(int [] powers) {
    int [][] div = {{ }};

    for(int i = 0; i < powers.length; ++i) {
      int A = div.length;
      int B = powers[i] + 1;

      int [][] product = new int[A*B][i+1];

      for(int j = 0, v = 1; j < B; ++j, v *= primes[i]) {

        for(int k = 0; k < A; ++k) {
          int q = k * B + j;
          int n = j * A + k;

          for(int l = 0; l < div[k].length; ++l) {
            product[n][l] = div[n / B][l];
          }
          product[q][div[k].length] = v;
        }
      }
      div = product;
    }

    int [] f = new int[div.length];
    for(int i = 0; i < div.length; ++i) {
      f[i] = 1;
      for(int j = 0; j < div[i].length; ++j) {
        f[i] *= div[i][j];
      }
    }

    java.util.Arrays.sort(f);
    return f;
  }

  static int sumLast(int [] factors, int limit) {
    int s = 0;
    int n = factors[factors.length-1];

    for(int i = 0; i < factors.length; ++i) {
      if(limit < 0 || factors[i]*limit > n)
        s += factors[i];
    }

    return s;
  }

  public static void main(String [] args) {
    int limit = -1;

    String s = System.getenv("LIMIT");
    if(s != null)
      limit = Integer.parseInt(s);

    BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
    try {
      for(String line; (line = in.readLine()) != null;) {
        int [] powers = split(line);

        int [] f = factors(powers);

        System.out.println(f[f.length-1] + " " + sumLast(f, limit));
      }
    } catch(java.io.IOException e) {}
  }
}
