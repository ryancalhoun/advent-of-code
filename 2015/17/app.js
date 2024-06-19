var cap = require('./build/Release/capacity');

const containers = [];

let prev = '';
process.stdin.on('readable', () => {
  for(let chunk; (chunk = process.stdin.read()) != null;) {
    const lines = (prev + chunk).split(/\r?\n/);
    prev = lines.pop();

    for(const i in lines) {
      containers.push(parseInt(lines[i]));
    }
  }
});

process.stdin.on('end', () => {
  const ways = [];
  cap.ways(parseInt(process.env.TARGET), containers, (way) => ways.push(way));

  if(process.env.PART == '1') {
    process.stdout.write(`${ways.length}\n`);
  } else {
    const min = Math.min(...ways.map((x) => x.length));
    process.stdout.write(`${ways.filter((e) => e.length == min).length}\n`);
  }
});

