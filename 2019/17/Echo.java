public class Echo implements Robotic {

  long value;

  public void accept(Long val) {
    value = val;
  }

  public Long get( ){
    return value;
  }
}
