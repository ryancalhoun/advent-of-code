const checksum = process.env.PART == '1' ? minmax : divby;

const rows = [];

let prev = '';
process.stdin.on('readable', () => {
  for(let chunk; (chunk = process.stdin.read()) != null; ) {
    const lines = (prev + chunk).split(/\r?\n/);
    prev = lines.pop();

    for(const i in lines) {
      rows.push(lines[i].split(/\s/).map(n => parseInt(n)));
    }
  }
});
process.stdin.on('end', () => {
  process.stdout.write(`${checksum(rows)}\n`);
});

function minmax(rows) {
  let total = 0;
  for(const i in rows) {
    total += (Math.max.apply(null, rows[i]) - Math.min.apply(null, rows[i]));
  }

  return total;
}

function divby(rows) {
  let total = 0;
  for(const i in rows) {
    const row = rows[i].sort((a,b) => a - b);
    for(let j = 0; j < row.length-1; ++j) {
      for(let k = j + 1; k < row.length; ++k) {
        if(row[k] % row[j] == 0)
          total += (row[k] / row[j]);
      }
    }
  }

  return total;
}
