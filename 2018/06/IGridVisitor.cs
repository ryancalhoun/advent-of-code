interface IGridVisitor<T>
{
  public void Visit(int x, int y);
  public T Value();
}
