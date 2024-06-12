#!/bin/bash

dir=$(printf %02d $1)

if [[ ! -d $dir ]]; then
  mkdir $dir
fi

cd $dir

if [[ ! -f README.md ]]; then
cat > README.md <<END
# Day $1: ${@:2}

[Full info here](https://adventofcode.com/2017/day/$1)

END
fi

if [[ ! -f app.js ]]; then
cat > app.js <<END
let prev = '';
process.stdin.on('readable', () => {
  for(let chunk; (chunk = process.stdin.read()) != null; ) {
    const lines = (prev + chunk).split(/\r?\n/);
    prev = lines.pop();

    for(const i in lines) {


    }
  }
});
END
fi

if [[ ! -f package.json ]]; then
cat > package.json <<END
{
  "scripts": {
    "all": "npm run sample1 && npm run sample2 && npm run part1 && npm run part2",
    "sample1": "PART=1 node app.js < sample.txt",
    "sample2": "PART=2 node app.js < sample.txt",
    "part1": "PART=1 node app.js < full.txt",
    "part2": "PART=2 node app.js < full.txt"
  },

  "main": "app.js"
}
END
fi
