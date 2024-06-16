let n = 1;
let p;

function seesay(a) {
  for(const v of a.values()) {
    const c = String.fromCharCode(v);

    if(p) {
      if(c == p) {
        ++n;
      } else {
        process.stdout.write(`${n}${p}`);
        n = 1;
      }
    }

    p = c;
  }
}

process.stdin.on('readable', () => {
  for(let chunk; (chunk = process.stdin.read()) != null; ) {
    seesay(chunk);
  }
});

process.stdin.on('end', () => {
  process.stdout.write(`\n`);
});

