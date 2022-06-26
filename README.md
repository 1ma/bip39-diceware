# BIP-39 Diceware

Everything you need to generate BIP-39 mnemonic sentences with dice.

## Overview

This repo mainly consists of these parts:

* A LaTeX document that turns the BIP-39 English wordlist into a printer-friendly set of [Diceware] lists.
* A `checksum.sh` Bash script that calculates the last word of any BIP-39 sentence.
* A `coinflips.sh` Bash script to get the full mnemonic from a series of coin flips.

## Diceware list

Download [the last version of the PDF] from the [Releases page], verify the [signature] with my [GitHub GPG key] and follow the instructions from the document.

You can instead build the PDF yourself.
To build it you need a Linux machine with Bash, GNU Make, wget and latexmk.
On Ubuntu you can satisfy all these requirements by running `sudo apt install make latexmk`, then run `make` to generate the PDF.

## checksum.sh

When used to generate a "real" mnemonic this script should be run in an airgapped device with no internet connectivity whatsoever.
If having a dedicated airgapped computer is too much, a happy compromise is to boot a Linux OS from a Live USB.

The script has been written in Bash and relies just on basic UNIX utilities to strive for maximum compatibility.

### Sample output

```
$ ./checksum.sh

WARNING: Don't run this script on an internet-enabled device unless you are just trying it out with fake data

Enter desired number of words for your mnemonic seed.
The BIP-39 spec allows 12, 15, 18, 21 or 24: 12

Select 11 random words from the diceware lists and type in each one. Select the words using the procedure described in the document.
Enter word 1/11: abandon
Enter word 2/11: abandon
Enter word 3/11: abandon
Enter word 4/11: abandon
Enter word 5/11: abandon
Enter word 6/11: abandon
Enter word 7/11: abandon
Enter word 8/11: abandon
Enter word 9/11: abandon
Enter word 10/11: abandon
Enter word 11/11: abandon

11 words encode 121 bits of entropy out of the 128 bits required for a 12-word mnemonic.
You now need to manually generate 7 additional bits of entropy to get up to 128. A 'bit' is simply either a 1 or a 0.
Use coin tosses or the same dice you've been using, where an even roll = 0 and an odd roll = 1.

Enter bit 1/7: 0
Enter bit 2/7: 0
Enter bit 3/7: 0
Enter bit 4/7: 0
Enter bit 5/7: 0
Enter bit 6/7: 0
Enter bit 7/7: 0

ENT (128 bits):
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
SHA256 of ENT: 374708FFF7719DD5979EC875D56CD2286F6D3CF7EC317A3B25632AAB28EC37BB
CS (first 4 bits of SHA256(ENT)): 0011
ENT+CS (132 bits):
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011
last 11 bits of ENT+CS (binary): 00000000011
last 11 bits of ENT+CS (decimal): 3

Your last word is 'about'
```

## coinflips.sh

The idea for this script came after hearing an amusing thought experiment from [@dergigi] where he notes that anyone can generate a BIP-39 mnemonic while locked in a bathroom with just a coin.
Like `checksum.sh`, `coinflips.sh` also calculates the checksum bits on your behalf but instead of doing it from the first words of the mnemonic it reads a series of coin flips and then outputs the full BIP-39 mnemonic.

This approach is more minimalistic as it doesn't even need the Diceware list, plus in my opinion it's also easier to understand what's going on.
However, keep in mind that doing even just the minimum of 128 coin flips is really tedious and takes much longer than rolling dice.

### Sample output

```
$ ./coinflips.sh

WARNING: Don't run this script on an internet-enabled device unless you are just trying it out with fake data

Enter desired number of bits of entropy for your seed.
The BIP-39 spec allows 128, 160, 192, 224 or 256: 128

Do 128 coin flips and enter them one by one using 0 or 1. Have fun.

Enter bit 1/128: 0
Enter bit 2/128: 0
Enter bit 3/128: 0
Enter bit 4/128: 0
...
Enter bit 126/128: 0
Enter bit 127/128: 0
Enter bit 128/128: 0

ENT (128 bits):
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
SHA256 of ENT: 374708FFF7719DD5979EC875D56CD2286F6D3CF7EC317A3B25632AAB28EC37BB
CS (first 4 bits of SHA256(ENT)): 0011
ENT+CS (132 bits):
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011

Your 12 word mnemonic is:

    abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about
```

## Links of interest

* The [BIP-39 specification] and the [English wordlist] that I used in my document.
* [BIP-39 test vectors] from the TREZOR project that helped me catch a bunch of bugs in my script.
* [Arman the Parman's DIY Private Key project] helped me better understand how the checksum calculation works.
* As far as I can tell [Sarpulhu] came up with the method to perfectly map the Diceware procedure to a set of 2048 elements (Diceware usually uses lists of 7776 words).
* [Ian Coleman's well known HTML tool] can be used to double-check the last word of a mnemonic if a hardware wallet is not available.

[Diceware]: https://en.wikipedia.org/wiki/Diceware
[the last version of the PDF]: https://github.com/1ma/bip39-diceware/releases/latest/download/bip39-diceware.pdf
[Releases page]: https://github.com/1ma/bip39-diceware/releases
[signature]: https://github.com/1ma/bip39-diceware/releases/latest/download/bip39-diceware.pdf.asc
[GitHub GPG key]: https://github.com/1ma.gpg
[@dergigi]: https://twitter.com/dergigi
[BIP-39 specification]: https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki
[English wordlist]: https://github.com/bitcoin/bips/blob/master/bip-0039/english.txt
[BIP-39 Test vectors]: https://github.com/trezor/python-mnemonic/blob/master/vectors.json
[Arman the Parman's DIY Private Key project]: https://bitcoinmagazine.com/culture/diy-bitcoin-private-key-project
[Sarpulhu]: https://github.com/sarpulhu/dicebip39
[Ian Coleman's well known HTML tool]: https://iancoleman.io/bip39/
