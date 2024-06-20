function countReplacements(machine, molecule) {
  const replacements = {};

  for(const k in machine) {
    for(const j in machine[k]) {
      const v = machine[k][j];
      for(let begin = 0, i = 0; (i = molecule.indexOf(k, begin)) != -1; begin = i + 1) {
        const r = `${molecule.substr(0, i)}${v}${molecule.substr(i+k.length)}`;
        replacements[r] = true;
      }
    }
  }

  return Object.keys(replacements).length;
}

function countFabrication(machine, molecule) {
  function count(s) {
    let c = 0;
    for(let i = 0, begin = 0; (i = molecule.indexOf(s, begin)) != -1; begin = i + 1, ++c);
    return c;
  }
  return molecule.replace(/[a-z]/g, '').length - count('Rn')*2 - count('Y')*2 - 1;
}

exports.countReplacements = countReplacements;
exports.countFabrication = countFabrication;
