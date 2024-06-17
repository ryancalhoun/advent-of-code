public class App {
  byte [] password = new byte[8];

  public App() {
    getPassword();
  }

  public static void main(String [] args) {
    App a = new App();

    a.getNextValid();

    if(System.getenv("PART").equals("2"))
      a.getNextValid();

    System.out.println(new String(a.password));
  }

  public void getNextValid() {
    do { getNext(); } while(! isValid());
  }

  boolean isValid() {
    boolean hasStraight = false;
    int pairs = 0;
    int lastPair = -1;

    for(int i = 0; i < password.length; ++i) {
      if(password[i] == 'i' || password[i] == 'o' || password[i] == 'l')
      {
        while(i < password.length-1)
          password[++i] = 'z';
        return false;
      }

      if(i < password.length-2) {
        if(password[i] + 1 == password[i+1] && password[i+1] + 1 == password[i+2])
          hasStraight = true;
      }

      if(i < password.length-1 && i > lastPair) {
        if(password[i] == password[i+1]) {
          ++pairs;
          lastPair = i+1;
        }
      }
    }

    return hasStraight && pairs >= 2;
  }

  void getNext() {
    ProcessBuilder pb = new ProcessBuilder("./increment.sh");

    try {
      Process p = pb.start();

      java.io.OutputStream stdin = p.getOutputStream();
      stdin.write(password);
      stdin.close();

      java.io.InputStream stdout = p.getInputStream();
      for(int off = 0; off < password.length;) {
        int bytes = stdout.read(password, off, password.length - off);
        if(bytes < 0)
          break;
        off += bytes;
      }

      p.waitFor();

    } catch(java.io.IOException e) {
    } catch(InterruptedException e) {
    }
  }

  void getPassword() {
    try { System.in.read(password); }
    catch(java.io.IOException e) {}
  }
}
