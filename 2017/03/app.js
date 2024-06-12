import * as spiral from './spiral.js';
const result = process.env.PART == '1' ? spiral.distance : spiral.sum;

let prev = '';
process.stdin.on('readable', () => {
  for(let chunk; (chunk = process.stdin.read()) != null; ) {
    const lines = (prev + chunk).split(/\r?\n/);
    prev = lines.pop();

    for(const i in lines) {
      process.stdout.write(`${result(parseInt(lines[i]))}\n`);

    }
  }
});
