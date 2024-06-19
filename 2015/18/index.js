const express = require('express');
const app = express();

app.use(express.json());

app.post('/', (req, res) => {
  res.json(playGameOfLife(req.body));
});

app.listen(8080, () => {
  console.log('listening on port 8080');
});

function onNeighbors(last, i, j) {
  let on = 0;
  for(let m = -1; m <= 1; ++m) {
    for(let n = -1; n <= 1; ++n) {
      if((m != 0 || n != 0) && i+m >= 0 && i+m < last.length && j+n >=0 && j+n < last[i+m].length) {
        if(last[i+m][j+n]) {
          ++on;
        }
      }
    }
  }
  return on;
}

function playGameOfLife(last) {
  const next = [];

  for(let i = 0; i < last.length; ++i) {
    next[i] = [];
    for(let j = 0; j < last[i].length; ++j) {
      const n = onNeighbors(last, i, j);
      next[i][j] = n == 3 || (last[i][j] && n == 2) ? 1 : 0;
    }
  }

  return next;
}
