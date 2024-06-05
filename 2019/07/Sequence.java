public class Sequence {
  private int start;
  private int n;

  public Sequence(int start, int n) {
    this.start = start;
    this.n = n;
  }

  public void permutations(java.util.function.Consumer<int []> each) {

    int [] s = new int[n];
    for(int i = 0; i < n; ++i)
      s[i] = start + i;

    Sequence.permutations(each, s, 0);
  }

  private static void permutations(java.util.function.Consumer<int []> each, int [] s, int i) {
    if(i == s.length) {
      each.accept(s);
      return;
    }

    permutations(each, s.clone(), i + 1);

    for(int j = i + 1; j < s.length; ++j) {
      int t = s[j];
      s[j] = s[i];
      s[i] = t;

      permutations(each, s.clone(), i + 1);
    }
  }
}
