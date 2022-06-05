#!/usr/bin/env bash

# genarray.sh: generates the BIP39_LIST array in checksum.sh from the official BIP-39 English wordlist

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euo pipefail

WORDLIST=$(wget --quiet -O - https://raw.githubusercontent.com/bitcoin/bips/master/bip-0039/english.txt)

BASE=0
while [ "$BASE" -lt 2048 ]
do
  printf "  \"%s\"" "$(echo "$WORDLIST" | sed "$((BASE+1))q;d")"
  OFFSET=1
  while [ "$OFFSET" -lt 16 ]
  do
    printf " \"%s\"" "$(echo "$WORDLIST" | sed "$((BASE+OFFSET+1))q;d")"
    OFFSET=$((OFFSET+1))
  done

  printf "\n"

  BASE=$((BASE+16))
done
