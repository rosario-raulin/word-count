# Word counting problem in Dylan

## Introduction

The word counting problem is one of my favourite simple problems that involves
a lot of common tasks (I/O, working with strings and regex, exploring basic
data structured such as maps and lists, sorting) and is a great way to explore
a new language.

## The Task

Here's the problem/algorithm:
* Read line-by-line from stdin.
* Count how often every word occurs.
* print this statistics out sorted descending by the number of occurrences.

A "word" is a sequence of characters that does *not* contain any whitespace
characters (perl regex: "\w+").

## Implementation notes

So I tried my best to come up with an efficient implementation in Dylan.
Compared to common other languages such as C or Java the performance is pretty
bad... Sure, instead of using regex I could split the strings manually but I
don't expect that to be the point.

## How to use

Compile with
```
dylan-compiler -build word-count.lid
```

Run with
```
_build/bin/word-count
```

Benchmark with
```
time cat big.txt | _build/bin/word-count > result.txt
```
