#!/usr/bin/env bash

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euo pipefail

WORDLIST=$(wget --quiet -O - https://raw.githubusercontent.com/bitcoin/bips/master/bip-0039/english.txt)

echo -n "" > list-a.txt
echo -n "" > list-b.txt

INDEX=0
for A in {1..4}
do
  for B in {1..4}
  do
    for C in {1..4}
    do
      for D in {1..4}
      do
        for E in {1..4}
        do
          WORD=$(echo "$WORDLIST" | sed "$((INDEX+1))q;d")
          echo "$A$B$C$D$E $INDEX $WORD" >> list-a.txt
          INDEX=$((INDEX+1))
        done
      done
    done
  done
done

for A in {1..4}
do
  for B in {1..4}
  do
    for C in {1..4}
    do
      for D in {1..4}
      do
        for E in {1..4}
        do
          WORD=$(echo "$WORDLIST" | sed "$((INDEX+1))q;d")
          echo "$A$B$C$D$E $INDEX $WORD" >> list-b.txt
          INDEX=$((INDEX+1))
        done
      done
    done
  done
done
