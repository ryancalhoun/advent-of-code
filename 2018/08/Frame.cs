class Frame<T> {
  public T Value { get; }
  public int i { get; set; }

  public Frame(T Value) {
    this.Value = Value;
  }
}
