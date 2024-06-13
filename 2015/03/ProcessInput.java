public class ProcessInput {
  static java.util.Map<Character,String> d = new java.util.HashMap<Character,String>() {{
    put('<', "-1 0");
    put('>', "1 0");
    put('^', "0 -1");
    put('v', "0 1");
  }};

  public static void main(String [] args) {
    for(;;) {
      try {
        int c = System.in.read();
        if(c == -1)
          break;

        String s = d.get((char)c);
        if(s != null)
          System.out.println(s);

      } catch(java.io.IOException e){}
    }
  }
}
