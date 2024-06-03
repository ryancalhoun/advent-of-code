public class AnyTwoRepeat implements Code.If {
  public boolean call(int [] digits) {
    for(int i = 1; i < digits.length; ++i) {
      if(digits[i] == digits[i-1])
        return true;
    }
    return false;
  }
}
