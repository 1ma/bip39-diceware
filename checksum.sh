#!/usr/bin/env bash

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euo pipefail

echo
echo "WARNING: Don't run this script on an internet-enabled device unless you are just trying it out with fake data"
echo

echo "Enter desired number of words for your mnemonic seed."
echo -n "The BIP-39 spec allows 12, 15, 18, 21 or 24: "
read -r MNEMONIC_LENGTH

if [[ ! $MNEMONIC_LENGTH =~ ^[0-9]{2}$ || ($MNEMONIC_LENGTH -ne 12 && $MNEMONIC_LENGTH -ne 15 && $MNEMONIC_LENGTH -ne 18 && $MNEMONIC_LENGTH -ne 21 && $MNEMONIC_LENGTH -ne 24) ]];
then
  echo "Invalid input, GFY"
  exit 1
fi

echo
echo "Select $((MNEMONIC_LENGTH-1)) random words from the diceware lists and type in each associated number. Select the words using the procedure described in the document."
ENT_BITS=""
COUNTER=1
while [ "$COUNTER" -lt "$MNEMONIC_LENGTH" ]
do
  echo -n "Enter number $COUNTER/$((MNEMONIC_LENGTH-1)): "
  read -r NUMBER

  if [[ ! $NUMBER =~ ^[0-9]+$ || $NUMBER -lt 0 || $NUMBER -gt 2047 ]];
  then
    echo "Wrong input. This is really not a good time to fuck around, WAKE UP MF."
    exit 1
  fi

  NUMBER_BITS=$(printf "%011d" "$(echo "obase=2;${NUMBER}" | bc)")
  ENT_BITS="$ENT_BITS$NUMBER_BITS"
  COUNTER=$((COUNTER+1))
done

ENT_LENGTH=$((MNEMONIC_LENGTH*11 - (MNEMONIC_LENGTH/3)))
CS_LENGTH=$((ENT_LENGTH/32))
REMAINDER=$((11-CS_LENGTH))

echo
echo "$((MNEMONIC_LENGTH-1)) numbers encode $(((MNEMONIC_LENGTH-1)*11)) bits of entropy out of the $ENT_LENGTH bits required for a $MNEMONIC_LENGTH-word mnemonic.";
echo "You now need to manually generate $REMAINDER additional bits of entropy to get up to $ENT_LENGTH. A 'bit' is simply either a 1 or a 0."
echo "Use coin tosses or the same dice you've been using, where an even roll = 0 and an odd roll = 1."
echo

FINAL_ENT_BITS=""
COUNTER=1
while [ "$COUNTER" -le "$REMAINDER" ]
do
  echo -n "Enter bit $COUNTER/$REMAINDER: "
  read -r BIT

  if [[ ! $BIT =~ ^[0-1]{1}$ ]];
  then
    echo "Wrong input. This is really not a good time to fuck around, WAKE UP MF."
    exit 1
  fi

  FINAL_ENT_BITS="$FINAL_ENT_BITS$BIT"
  COUNTER=$((COUNTER+1))
done

ENT_BITS="$ENT_BITS$FINAL_ENT_BITS"
ENT_HASH=$(echo "$ENT_BITS" | shasum -a 256 -0 | cut -d" " -f1 | tr a-f A-F)
CS_BITS=$(printf "%08d" "$(echo "$ENT_HASH" | cut -c1-2 | cat <(echo -n "ibase=16;obase=2;") - | bc)" | cut -c1-"$CS_LENGTH")
LAST_NUMBER=$(echo "ibase=2;$FINAL_ENT_BITS$CS_BITS" | bc)

echo
echo "ENT ($ENT_LENGTH bits):"
echo "$ENT_BITS"
echo "SHA256 of ENT: $ENT_HASH"
echo "CS (first $CS_LENGTH bits of SHA256(ENT)): $CS_BITS"
echo "ENT+CS:"
echo "$ENT_BITS$CS_BITS"
echo "last 11 bits of ENT+CS (binary): $FINAL_ENT_BITS$CS_BITS"
echo "last 11 bits of ENT+CS (decimal): $LAST_NUMBER"
echo
echo "Look up word number $LAST_NUMBER in the lists, that's your ${MNEMONIC_LENGTH}th word."
echo
