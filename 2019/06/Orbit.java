public class Orbit {
  java.util.Map<String,Body> bodies = new java.util.HashMap<String,Body>();

  public Body body(String name) {
    Body b = bodies.get(name);

    if(b == null) {
      b = new Body(name);
      bodies.put(name, b);
    }

    return b;
  }

  public int countDepthsFrom(String start) {
    java.util.Queue<String> q = new java.util.ArrayDeque<String>();
    q.add(start);

    java.util.Map<String,Integer> d = new java.util.HashMap<String,Integer>();
    d.put(start, 0);

    for(String s; (s = q.poll()) != null;) {
      int depth = d.get(s);

      Body b = bodies.get(s);
      if(b != null) {
        b.each(child -> {
          q.add(child);
          d.put(child, depth+1);
        });
      }
    }

    int total = 0;
    for(int depth : d.values())
      total += depth;

    return total;
  }

  public int countTransfersBetween(String start, String end) {
    java.util.Map<String,String> parents = new java.util.HashMap<String,String>();

    for(Body b : bodies.values()) {
      b.each(child -> {
        parents.put(child, b.name());
      });
    }

    java.util.Map<String,Integer> hops = new java.util.HashMap<String,Integer>();

    for(String begin : java.util.Arrays.asList(start, end)) {
      for(String s = begin; (s = parents.get(s)) != null; ) {
        hops.put(s, hops.getOrDefault(s, 0) + 1);
      }
    }

    int total = 0;
    for(int h : hops.values()) {
      if(h == 1)
        ++total;
    }

    return total;
  }

  public String toString() {
    return bodies.toString();
  }
}
