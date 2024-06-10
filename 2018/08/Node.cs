class Node {
  public int child { get; }
  public int children { get; }
  public int meta { get; }

  public int [] values;

  public Node() {
    children = 1;
    values = new int[1];
  }

  public Node(int child, int children, int meta) {
    this.child = child;
    this.children = children;
    this.meta = meta;

    values = new int[children];
  }
}
