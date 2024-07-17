public class Space {
  int [][] space;
  int x, y;

  final int [] reverse = { 2, 1, 4, 3 };

  public Space(int width, int height) {
    space = new int[width][height];
  }

  public int find(Droid d) {
    return find(d, (space.length-1)/2, (space[0].length-1)/2);
  }

  public int flood() {
    return flood(x, y, 0);
  }

  boolean unknown(int x, int y) {
    return space[x][y] == 0;
  }

  void wall(int x, int y) {
    space[x][y] = -1;
  }

  void open(int x, int y) {
    space[x][y] = -2;
  }

  void found(int x, int y) {
    this.x = x;
    this.y = y;
    open(x, y);
  }

  int find(Droid d, int x, int y) {
    return
      move(d, 1, x, y-1) +
      move(d, 2, x, y+1) +
      move(d, 3, x-1, y) +
      move(d, 4, x+1, y);
  }

  int move(Droid d, int move, int x, int y) {
    if(! unknown(x, y))
      return 0;

    int r = d.move(move);
    if(r == 0) {
      wall(x, y);
      return 0;
    }

    int v = 0;

    if(r == 1) {
      open(x, y);
      v = find(d, x, y);
      if(v > 0)
        v += 1;
    } else {
      found(x, y);
      find(d, x, y);
      v = 1;
    }

    d.move(reverse[move-1]);

    return v;
  }

  int flood(int x, int y, int t) {
    if(space[x][y] == -1)
      return 0;

    if(space[x][y] > 0 && space[x][y] < t)
      return 0;

    space[x][y] = t;

    int v = t;

    v = Math.max(v, flood(x-1, y, t+1));
    v = Math.max(v, flood(x+1, y, t+1));
    v = Math.max(v, flood(x, y-1, t+1));
    v = Math.max(v, flood(x, y+1, t+1));

    return v;
  }
}
