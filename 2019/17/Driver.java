public class Driver implements Iterable<Character> {

  String prog = "A,C,A,C,B,B,C,A,C,B\nL,10,R,10,L,10,L,10\nR,12,L,12,R,6\nR,10,R,12,L,12\nn\n";

  public java.util.Iterator<Character> iterator() {
    return prog.chars().mapToObj(c -> (char)c).iterator();
  }
}
