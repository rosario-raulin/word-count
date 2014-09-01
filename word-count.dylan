module: word-count

define constant $whitespace-regex :: <regex> = compile-regex("\\s+");

define function split-by (regex :: <regex>, input :: <string>)
  => (_splitted :: <list>)
  let splitted :: <list> = #();
  let start :: <integer> = 0;

  while (start < size(input))
    let match = regex-search(regex, input, start: start);

    if (match)
      let (_, _end, new_start) = match-group(match, 0);
      let part :: <string> = copy-sequence(input, start: start, end: _end);
      splitted := add!(splitted, part);
      start := new_start;
    else
      let part :: <string> = copy-sequence(input, start: start);
      splitted := add!(splitted, part);
      // break cause no other match exists
      start := size(input);
    end;
  end;

  splitted
end;

define function trim-left (input :: <string>) => (trimmed :: <string>)
  let start :: <integer> = 0;
  while (start < size(input) & whitespace?(input[start]))
    start := start + 1;
  end;
  copy-sequence(input, start: start);
end;

define function split-by-word (input :: <string>) => (words :: <list>)
  split-by($whitespace-regex, trim-left(input));
end;

define function count-words (table :: <string-table>, words :: <list>)
  for (word in words)
    table[word] := element(table, word, default: 0) + 1;
  end;
end;

define function sort-word-map (word-map :: <table>) => (sorted :: <list>)
  let values = map(method (key) pair(key, word-map[key]) end, key-sequence(word-map));
  sort!(values, test: method(p1, p2) p2.tail < p1.tail end)
end;

define function main ()
  let word-map :: <string-table> = make(<string-table>);
  let line :: false-or(<string>)
    = read-line(*standard-input*, on-end-of-stream: #f);

  while (line)
    count-words(word-map, split-by-word(line));
    line := read-line(*standard-input*, on-end-of-stream: #f);
  end;

  let sorted = sort-word-map(word-map);
  for (p in sorted)
    format-out("%d %s\n", p.tail, p.head);
  end;
end;

main();
