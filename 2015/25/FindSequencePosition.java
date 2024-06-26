import java.io.BufferedReader;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class FindSequencePosition {
  public static void main(String [] args) {
    BufferedReader in = new BufferedReader(new java.io.InputStreamReader(System.in));

    int row = 0, col = 0;

    try {
      String line = in.readLine();
                                    
      Pattern p = Pattern.compile("row (\\d+), column (\\d+)"); 
      Matcher m = p.matcher(line);

      if(m.find()) {
        row = Integer.parseInt(m.group(1));
        col = Integer.parseInt(m.group(2));
      }

    } catch(java.io.IOException e) {}

    int pos = col * (col+1) / 2;
    for(int j = 0; j < row-1; ++j)
      pos += col + j;
    

    System.out.println(pos);
  }
}
