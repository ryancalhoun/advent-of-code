class WorkQueue<T> {
  List<T> workers;
  int max;

  public WorkQueue(int max) {
    this.max = max;
    this.workers = new List<T>();
  }

  public void Sort() {
    workers.Sort();
  }

  public T? Done(Func<T,bool> f) {
    if(workers.Count == 0 || ! f(workers[0]))
      return default(T);

    T work = workers[0];
    workers.RemoveAt(0);

    return work;
  }

  public bool Add(T work) {
    if(Full())
      return false;

    workers.Add(work);
    return true;
  }

  public bool Full() {
    return workers.Count == max;
  }

  public bool Done() {
    return workers.Count == 0;
  }
}
