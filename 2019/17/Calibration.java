public class Calibration implements Robotic {

  java.util.Set<Integer> previous = new java.util.HashSet<Integer>();
  java.util.Set<Integer> current = new java.util.HashSet<Integer>();
  java.util.ArrayList<Character> window = new java.util.ArrayList<Character>();

  int row;
  int col;

  long value;

  public void accept(Long val) {

    if((char)(long)val == '\n') {
      window.clear();
      col = 0;
      ++row;

      previous.clear();
      previous.addAll(current);
      current.clear();

    } else {
      window.add((char)(long)val);
      if(window.size() > 3)
        window.remove(0);

      if(window.size() == 3 && window.get(1) == '#') {
        if(window.get(0) == '.' && window.get(2) == '.') {
          current.add(col-1);
        } else if(window.get(0) == '#' && window.get(2) == '#') {
          if(previous.contains(col-1)) {
            value += row * (col-1);
          }
        }
      }

      ++col;
    }
  }

  public Long get() {
    return value;
  }
}
