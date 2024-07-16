import java.io.BufferedReader;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

import java.util.Map;
import java.util.HashMap;
import java.util.Queue;
import java.util.ArrayDeque;

public class App {
  public static void main(String [] args) {

    int part = Integer.parseInt(System.getenv("PART"));
    BufferedReader in = new BufferedReader(new java.io.InputStreamReader(System.in));

    Map<String,Reaction> reactions = new HashMap<String,Reaction>();

    try {
      Pattern p = Pattern.compile("\\d+ \\w+");
      for(String line; (line = in.readLine()) != null;) {
        Matcher m = p.matcher(line);

        Reaction r = new Reaction();

        while(m.find()) {
          Compound c = new Compound(m.group());

          if(m.end() < line.length()) {
            r.inputs.add(c);
          } else {
            r.result = c;
            reactions.put(c.name(), r);
          }
        }
      }

    } catch(java.io.IOException e) {}

    long ore = produce(new Compound("FUEL", 1), reactions);

    if(part == 1) {
      System.out.println(produce(new Compound("FUEL", 1), reactions));
    } else {

      final long limit = 1000000000000l;

      long fuel = 1;
      long max = 1;

      for(;;) {
        ore = produce(new Compound("FUEL", fuel), reactions);

        if(ore < limit) {
          max = Math.max(max, fuel);
        }

        if(Math.abs(limit - ore) > 1000000) {
          fuel = fuel * limit / ore;
        }

        if(ore < limit) {
          ++fuel;
        } else if(ore > limit) {
          if(--fuel == max) {
            break;
          }
        }
      }

      System.out.println(max);
    }
  }

  static long produce(Compound target, Map<String,Reaction> reactions) {

    Map<String,Long> consumed = new HashMap<String,Long>();
    Map<String,Long> leftover = new HashMap<String,Long>();

    Queue<Compound> q = new ArrayDeque<Compound>();
    q.add(target);

    for(Compound c; (c = q.peek()) != null; q.remove()) {
      Reaction r = reactions.get(c.name());

      Long used = consumed.get(c.name());
      if(used == null)
        used = 0l;

      Long have = leftover.get(c.name());
      if(have == null)
        have = 0l;

      if(have > c.quantity()) {
        leftover.put(c.name(), have - c.quantity());
        continue;
      }

      long need = c.quantity() - have;
      long rq = r == null ? 1 : r.result.quantity();

      long times = need / rq;
      if(rq * times + have < c.quantity())
        ++times;

      long rem = rq * times + have - c.quantity();
      leftover.put(c.name(), rem);

      consumed.put(c.name(), c.quantity() + used);

      if(r != null) {
        for(Compound i : r.inputs) {
          q.add(new Compound(i.name(), i.quantity() * times));
        }
      }
    }
    return consumed.get("ORE");
  }
}
