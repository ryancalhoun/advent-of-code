const solve = process.env.PART == '1' ? consecutive : halfway;

let prev = '';
process.stdin.on('readable', () => {
  for(let chunk; (chunk = process.stdin.read()) != null; ) {
    const lines = (prev + chunk).split(/\r?\n/);
    prev = lines.pop();

    for(const i in lines) {
      process.stdout.write(`${solve(lines[i])}\n`);
    }
  }
});

function consecutive(line) {
  let total = 0;

  for(let i = 0; i < line.length-1; ++i) {
    if(line[i] == line[i+1])
      total += parseInt(line[i]);
  }
  if(line[0] == line[line.length-1]) {
    total += parseInt(line[0]);
  }

  return total;
}

function halfway(line) {
  let total = 0;

  for(let i = 0; i < line.length/2; ++i) {
    if(line[i] == line[i+line.length/2])
      total += parseInt(line[i]) * 2;
  }

  return total;
}
