using System.Diagnostics;
using System.IO;
using System.Text.Json;
using System.Net.Http.Headers;

IDictionary<string,string> arguments =
  args.Select(arg => arg.Split('=')).ToDictionary(s => s[0], s => s[1]);

IList<IList<int>> grid = new List<IList<int>>();
using (StreamReader file = new StreamReader(arguments["file"])) {
  for(string? line; (line = file.ReadLine()) != null;) {
    grid.Add((from c in line select c == '#' ? 1 : 0).ToList());
  }
}
if(arguments["part"] == "2") {
  stuckCorners(grid);
}

using (var server = new Server()) {
  var http = new HttpClient() {
    BaseAddress = new Uri("http://localhost:8080")
  };

  for(int i = 0; i < Int32.Parse(arguments["iterations"]); ++i) {
    using(var res = await http.PostAsync("/", postBody(grid))) {
      grid = JsonSerializer.Deserialize<IList<IList<int>>>(await res.Content.ReadAsStringAsync()!)!;
    }
    if(arguments["part"] == "2") {
      stuckCorners(grid);
    }
  }

  Console.WriteLine((from row in grid select row.Sum()).Sum());
}

HttpContent postBody<T>(T grid) {
  return new StringContent(JsonSerializer.Serialize(grid), new MediaTypeHeaderValue("application/json"));
}

void stuckCorners(IList<IList<int>> grid) {
  int r = grid.Count - 1;
  int c = grid[0].Count - 1;
  grid[0][0] = grid[0][c] = grid[r][0] = grid[r][c] = 1;
}

class Server: IDisposable {
  Process? p;
 
  public Server() {
    ProcessStartInfo si = new ProcessStartInfo();
    si.FileName = "node";
    si.Arguments = "index.js";
    si.RedirectStandardOutput = true;

    p = Process.Start(si);
    if(p != null) {
      using (StreamReader sr = p.StandardOutput) {
        string? line = sr.ReadLine();
      }
    }
  }
  public void Dispose() {
    if(p != null) {
      p.Kill(true);
      p.Dispose();
      p = null;
    }
  }
}
