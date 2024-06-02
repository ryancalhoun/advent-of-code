public class Fuel {
  private int total;

  public Fuel() {
  }

  public int addMass(int mass) {
    int r = mass / 3 - 2;

    if(r > 0)
      total += r;

    return r;
  }

  public int getTotal() {
    return total;
  }
}
