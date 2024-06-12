function distance(v) {
  v -= 1;

  let depth = 1;

  for(; v > 8*depth; ++depth) {
    v -= 8*depth;
  }

  if(v == 0)
    return 0;

  return Math.abs((8*depth - v) % (2*depth) - depth) + depth;
}

function sum(v) {
  let filled = [1];

  for(let depth = 1; ; ++depth) {
    const working = [];
    for(let i = 0, j = -1; i < 8*depth; ++i) {
      const p = (8*depth - i - 1) % (2*depth);

      working[i] = 0;

      if(i > 0) {
        working[i] += working[i-1];
        if(p == 2*depth - 1)
          working[i] += working[i-2];
        if(i > 8*depth - 3)
          working[i] += working[0];
      }

      working[i] += filled[j < 0 ? filled.length-1 : j];

      if(depth > 1) {
        if(p > 0 && p < 2*depth - 1)
          working[i] += filled[j == 0 ? filled.length-1 : j-1];
        if(p > 1)
          working[i] += filled[j++ + 1];
      }

      if(working[i] > v)
        return working[i];
    }

    filled = working;
  }
}

export { distance, sum, };
