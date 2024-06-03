public class ExactlyTwoRepeat implements Code.If {
  public boolean call(int [] digits) {
    int [] count = new int[10];

    for(int d : digits) {
      ++count[d];
    }

    for(int c : count) {
      if(c == 2)
        return true;
    }

    return false;
  }
}
