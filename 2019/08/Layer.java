public class Layer {
  private int width;
  private int height;
  private int [] pixels;
  private int i;

  public Layer(int width, int height) {
    this.width = width;
    this.height = height;
    pixels = new int[width*height];
  }

  public void add(int p) {
    pixels[i++] = p;
  }

  public int get(int i) {
    return pixels[i];
  }

  public void set(int i, int p) {
    pixels[i] = p;
  }

  public boolean complete() {
    return i == pixels.length;
  }

  public int count(int v) {
    int z = 0;
    for(int p : pixels)
      if(p == v)
        ++z;

    return z;
  }

  public String toString() {
    String s = "";
    for(int j = 0; j < height; ++j) {
      for(int i = 0; i < width; ++i) {
        s += pixels[j*width + i] == 1 ? '#' : ' ';
      }
      s += "\n";
    }
    return s;
  }
}
