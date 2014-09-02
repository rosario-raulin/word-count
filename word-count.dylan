module: word-count

define function split-by-word (input :: <string>) => (words :: <list>)
  let output :: <list> = #();

  let start :: <integer> = 0;
  let curr :: <integer> = 0;
  for (c :: <character> in input)
    if (whitespace?(c))
      if (curr = start)
        start := start + 1;
        curr := curr + 1;
      else
        output := add!(output, copy-sequence(input, start: start, end: curr));
        start := curr + 1;
        curr := start;
      end
    else
      curr := curr + 1;
    end;
  end;

  if (start < size(input))
    output := add!(output, copy-sequence(input, start: start));
  end;

  output;
end;

define function count-words (table :: <string-table>, words :: <list>)
  for (word :: <string> in words)
    table[word] := element(table, word, default: 0) + 1;
  end;
end;

define function sort-word-map (word-map :: <table>) => (sorted :: <list>)
  let values :: <list>
    = map(method (key) pair(key, word-map[key]) end, key-sequence(word-map));
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
