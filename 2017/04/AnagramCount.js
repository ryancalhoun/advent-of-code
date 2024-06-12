import { WordCount } from './WordCount.js';

class AnagramCount extends WordCount {
  count(w) {
    return super.count(w.split('').sort().join(''));
  }
}

export { AnagramCount };
