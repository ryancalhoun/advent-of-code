import java.util.List;
import java.util.ArrayList;

public class Moon {

  int [] pos;
  int [] vel = new int[]{ 0, 0, 0 };

  List<int[]> history = new ArrayList<int[]>();

  long period = -1;

  CommonMultiple cm = new CommonMultiple(3);

  public Moon(int [] pos) {
    this.pos = pos;
  }

  public Moon(Moon m) {
    this.pos = m.pos.clone();
    this.vel = m.vel.clone();
  }

  public boolean equals(Moon m) {
    for(int i = 0; i < pos.length; ++i)
      if(pos[i] != m.pos[i] || vel[i] != m.vel[i])
        return false;
    return true;
  }

  public void gravity(Moon m) {
    for(int i = 0; i < pos.length; ++i) {
      if(pos[i] > m.pos[i]) {
        --vel[i];
        ++m.vel[i];
      } else if(pos[i] < m.pos[i]) {
        ++vel[i];
        --m.vel[i];
      }
    }
  }

  public void velocity() {
    history.add(pos.clone());
    findPeriod();

    for(int i = 0; i < pos.length; ++i) {
      pos[i] += vel[i];
    } 
  }

  public long period() {
    return period;
  }

  public long totalEnergy() {
    return e(pos) * e(vel);
  }

  long e(int v) {
    return Math.abs(v);
  }

  long e(int [] a) {
    int e = 0;
    for(int x : a)
      e += e(x);

    return e;
  }

  void findPeriod() {
    if(period > -1 || history.size() < 2)
      return;

    for(int i = 0; i < pos.length; ++i) {
      if(cm.seen(i))
        continue;

      int p = history.size() / 2;
      for(int j = 0; j < p; ++j) {
        if(history.get(j)[i] != history.get(j+p)[i]) {
          p = -1;
          break;
        }
      }
      if(p > -1) {
        cm.mul(i, p);
      }
    }

    if(cm.count() == 3) {
      period = cm.value();
    }
  }

  public String toString() {
    return "<pos x=" + pos[0] + " y=" + pos[1] + " z=" + pos[2] +
         "/><vel x=" + vel[0] + " y=" + vel[1] + " z=" + vel[2] + "/>";
  }
}
