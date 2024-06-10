using System.IO;

IDictionary<string,string> arguments =
  args.Select(arg => arg.Split('=')).ToDictionary(s => s[0], s => s[1]);

List<int> numbers;
using (StreamReader file = new StreamReader(arguments["file"])) {
  numbers = file.ReadLine()!.Split(' ').Select(n => Int32.Parse(n)).ToList();
}

Node root = new Node();
Stack<Frame<Node>> s = new Stack<Frame<Node>>();
s.Push(new Frame<Node>(root));

Func<int[], IList<int>, int> nodeValue = arguments["part"] == "1" ?
  (children, meta) => meta.Sum() + children.Sum() :
  (children, meta) => children.Length > 0 ? 
    (from m in meta where m > 0 && m <= children.Length select children[m-1]).Sum() :
    meta.Sum();

int i = 0;
do {
  Node top = s.Peek().Value; 

  if(s.Peek().i < top.children) {
    Node child = new Node(s.Peek().i++, numbers[i], numbers[i+1]);

    s.Push(new Frame<Node>(child));
    i += 2;
  } else {
    s.Pop();
    s.Peek().Value.values[top.child] = nodeValue(top.values, numbers.GetRange(i, top.meta));

    i += top.meta;
  }
} while(s.Count > 1);

Console.WriteLine(root.values[0]);

