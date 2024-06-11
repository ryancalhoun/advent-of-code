class MarbleGame {
  long [] score;
  LinkedList<int> marbles;
  LinkedListNode<int>? current;

  public MarbleGame(int players) {
    score = new long[players];
    marbles = new LinkedList<int>();
  }

  public long PlayTo(int marble) {
    marbles.Clear();
    marbles.AddFirst(0);
    current = marbles.First;

    for(int m = 1; m <= marble; ++m) {
      int player = (m-1) % score.Length;

      if(m % 23 == 0)
        Take(player, m);
      else
        Place(player, m);
    }

    return score.Max();
  }

  void Place(int player, int m) {
    Forward(1);
    current = marbles.AddAfter(current!, m);
  }

  void Take(int player, int m) {
    Backward(6);
    LinkedListNode<int> take = Before();

    score[player] += m + take.Value;
    marbles.Remove(take);
  }

  void Forward(int dist) {
    while(dist-- > 0) {
      current = After();
    }
  }

  void Backward(int dist) {
    while(dist-- > 0) {
      current = Before();
    }
  }

  LinkedListNode<int> After() {
    if(current!.Next != null)
      return current.Next;
    return marbles.First!;
  }

  LinkedListNode<int> Before() {
    if(current!.Previous != null)
      return current.Previous;
    return marbles.Last!;
  }
}
