public class Maximal<T> {

  private java.util.function.Function<T, Integer> each;
  private int max;

  public Maximal(java.util.function.Function<T, Integer> each) {
    this.each = each;
  }

  public void add(T t) {
    int result = each.apply(t);
    if(result > max)
      max = result;
  }

  public int get() {
    return max;
  }
}
