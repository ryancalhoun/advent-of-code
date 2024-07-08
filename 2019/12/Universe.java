import java.util.List;
import java.util.ArrayList;

public class Universe {
  List<Moon> moons = new ArrayList<Moon>();

  public void add(Moon m) {
    moons.add(m);
  }

  public void step() {
    for(int i = 0; i < moons.size() - 1; ++i)
      for(int j = i + 1; j < moons.size(); ++j)
        moons.get(i).gravity(moons.get(j));

    for(Moon m : moons)
      m.velocity();
  }

  public long totalEnergy() {
    long total = 0;
    for(Moon m : moons)
      total += m.totalEnergy();
    return total;
  }

  public long stepsUntilRepeat() {

    CommonMultiple cm = new CommonMultiple(moons.size());

    List<Moon> initial = new ArrayList<Moon>();
    for(Moon m : moons)
      initial.add(new Moon(m));

    for(long step = 1; cm.count() < 4; ++step) {
      step();

      for(int i = 0; i < moons.size(); ++i) {
        Moon m = moons.get(i);
        if(m.period() > -1)
          cm.mul(i, m.period());
      }
    }

    return cm.value();
  }
}
