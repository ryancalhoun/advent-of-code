class Body {
  private String name;
  private java.util.List<String> children = new java.util.ArrayList<String>();

  public Body(String name) {
    this.name = name;
  }

  public String name() {
    return name;
  }

  public void add(String child) {
    children.add(child);
  }

  public void each(java.util.function.Consumer<String> child) {
    for(String c : children)
      child.accept(c);
  }

  public String toString() {
    return "(" + name + "):" + children;
  }
}
