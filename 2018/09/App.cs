using System.IO;
using System.Text.RegularExpressions;

IDictionary<string,string> arguments =
  args.Select(arg => arg.Split('=')).ToDictionary(s => s[0], s => s[1]);

string pattern = @"(\d+) players; last marble is worth (\d+) points";
using (StreamReader file = new StreamReader(arguments["file"])) {
  for(string? line; (line = file.ReadLine()) != null;) {
    Match m = Regex.Match(line, pattern);
    int players = Int32.Parse(m.Groups[1].Value);
    int marble = Int32.Parse(m.Groups[2].Value);

    if(arguments["part"] == "2")
      marble *= 100;

    MarbleGame game = new MarbleGame(players);
    Console.WriteLine(game.PlayTo(marble));
  }
}
