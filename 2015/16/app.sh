#!/bin/bash

if [[ -z $PART ]]; then
  echo >&2 "Run: PART=1 $0 < full.txt"
  echo >&2 " or  PART=2 $0 < full.txt"
  exit
fi

ruby -rjson <<END
$(awk < data.txt -F: '{ printf "def %s(v);v==%d;end\n", $1,$2}' | ([[ $PART = 1 ]] && cat || sed 's/\(\(cats\|trees\).\+\)==/\1>/;s/\(\(pomeranians\|goldfish\).\+\)==/\1</'))
DATA.each_line.with_index do |line,i|
  JSON.parse(line, symbolize_names: true).tap do |aunt|
    puts i+1 if aunt.all? {|k,v| self.send(k, v)}
  end
end
__END__
$(cut -d: -f2- | sed 's/\([a\-z]\+\)/"\1"/g' | awk '{print "{", $0, "}"}')
END
