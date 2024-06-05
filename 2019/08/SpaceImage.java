public class SpaceImage {
  private int width;
  private int height;

  java.util.List<Layer> layers = new java.util.ArrayList<Layer>();

  public SpaceImage(int width, int height) {
    this.width = width;
    this.height = height;
  }

  public void add(int p) {
    top().add(p);
  }

  private Layer top() {
    if(layers.size() > 0) {
      Layer layer = layers.get(layers.size() - 1);
      if(! layer.complete())
        return layer;
    }

    Layer layer = new Layer(width, height);
    layers.add(layer);

    return layer;
  }

  public int check() {
    Layer min = null;
    for(Layer layer : layers)
      if(min == null || layer.count(0) < min.count(0))
        min = layer;

    return min.count(1) * min.count(2);
  }

  public Layer flatten() {
    Layer flat = new Layer(width, height);
    while(! flat.complete())
      flat.add(2);

    for(Layer layer : layers) {
      for(int i = 0; i < width * height; ++i) {
        if(flat.get(i) == 2)
          flat.set(i, layer.get(i));
      }
    }

    return flat;
  }
}
