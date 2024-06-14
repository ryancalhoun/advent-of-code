using System.Runtime.InteropServices;

int nice = 0;
for(string? line; (line = Console.ReadLine()) != null;)
{
  if(string_scan(line) > 0)
    ++nice;
}

Console.WriteLine(nice);

[DllImport($"rules")]
static extern int string_scan(string s);
