public class Bitwise {

  public short evaluate(String [] e) {
    try {
      if(e.length == 1) {
        return value(e[0]);
      } else if(e.length == 2) {
        return (short)this.getClass().getMethod(e[0], short.class).invoke(this, value(e[1]));
      } else if(e.length == 3) {
        return (short)this.getClass().getMethod(e[1], short.class, short.class).invoke(this, value(e[0]), value(e[2]));
      }
    } catch(NoSuchMethodException ex) {
      ex.printStackTrace();
    } catch(IllegalAccessException ex) {
      ex.printStackTrace();
    } catch(java.lang.reflect.InvocationTargetException ex) {
      ex.printStackTrace();
    }

    return 0;
  }

  public short value(String s) {
    return (short)Integer.parseInt(s);
  }

  public short AND(short x, short y) {
    return (short)(x & y);
  }

  public short OR(short x, short y) {
    return (short)(x | y);
  }

  public short LSHIFT(short x, short y) {
    return (short)(x << y);
  }

  public short RSHIFT(short x, short y) {
    return (short)(x >> y);
  }

  public short NOT(short x) {
    return (short)~x;
  }
}
