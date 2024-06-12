class WordCount {
  constructor() {
    this.h = {};
  }

  count(w) {
    this.h[w] ||= 0;
    return ++this.h[w];
  }
}

export { WordCount };
