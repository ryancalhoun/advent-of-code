public class Compound {
  String name;
  long quantity;

  public Compound(String name, long quantity) {
    this.name = name;
    this.quantity = quantity;
  }

  public Compound(String compound) {
    int i = compound.indexOf(' ');
    if(i > 0) {
      this.name = compound.substring(i+1);
      this.quantity = Integer.parseInt(compound.substring(0, i));
    } else {
      this.name = compound;
    }
  }

  public String name() {
    return name;
  }
  public long quantity() {
    return quantity;
  }

  public String toString() {
    return name + "(" + quantity + ")";
  }
}
