import { WordCount } from './WordCount.js';
import { AnagramCount } from './AnagramCount.js';

let valid = 0;
const counter = process.env.PART == "1" ? WordCount : AnagramCount;

let prev = '';
process.stdin.on('readable', () => {
  for(let chunk; (chunk = process.stdin.read()) != null; ) {
    const lines = (prev + chunk).split(/\r?\n/);
    prev = lines.pop();

    for(const i in lines) {
      if(validate(lines[i], new counter()))
        ++valid;
    }
  }
});

process.stdin.on('end', () => {
  process.stdout.write(`${valid}\n`);
});

function validate(passphrase, counter) {
  const words = passphrase.split(/\s+/);

  for(const i in words) {
    if(counter.count(words[i]) > 1)
      return false;
  }
  return true;
}
