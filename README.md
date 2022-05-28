# BIP-39 Diceware

Everything you need to generate BIP-39 mnemonic sentences with dice.

## Overview

This repo mainly consists of two parts:

* A LaTeX document that turns the BIP-39 English wordlist into a printer-friendly set of [Diceware] lists.
* A `checksum.sh` Bash script that calculates the last word of any BIP-39 sentence.

## Diceware list

Download [the last version of the PDF] from the [Releases page], verify the [signature] with my [GitHub GPG key] and follow the instructions from the document.

You can instead build the PDF yourself.
To build it you need a Linux machine with Bash, GNU Make, wget and latexmk.
On Ubuntu you can satisfy all these requirements by running `sudo apt install make latexmk`, then run `make` to generate the PDF.

## checksum.sh

When used to generate a "real" mnemonic, this script should be run in an airgapped device with no internet connectivity whatsoever.
If having a dedicated airgapped computer is too much a happy compromise is to boot a Linux OS from a Live USB.

The script has been written in Bash and relies just on basic UNIX utilities to strive for maximum compatibility.

## Links of interest

* The [BIP-39 specification] and the [English wordlist] that I used in my document.
* [BIP-39 Test vectors] from the TREZOR project that helped me catch a bunch of bugs in my script.
* [Arman the Parman's DIY Private Key project] helped me better understand how the checksum calculation works.
* As far as I can tell [Sarpulhu] came up with the method to perfectly map the Diceware procedure to a set of 2048 elements (Diceware usually uses lists of 7776 words).
* [Ian Coleman's well known HTML tool] can be used to double-check the last word of a mnemonic if a hardware wallet is not available.

[Diceware]: https://en.wikipedia.org/wiki/Diceware
[the last version of the PDF]: https://github.com/1ma/bip39-diceware/releases/latest/download/bip39-diceware.pdf
[Releases page]: https://github.com/1ma/bip39-diceware/releases
[signature]: https://github.com/1ma/bip39-diceware/releases/latest/download/bip39-diceware.pdf.asc
[GitHub GPG key]: https://github.com/1ma.gpg
[BIP-39 specification]: https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki
[English wordlist]: https://github.com/bitcoin/bips/blob/master/bip-0039/english.txt
[BIP-39 Test vectors]: https://github.com/trezor/python-mnemonic/blob/master/vectors.json
[Arman the Parman's DIY Private Key project]: https://bitcoinmagazine.com/culture/diy-bitcoin-private-key-project
[Sarpulhu]: https://github.com/sarpulhu/dicebip39
[Ian Coleman's well known HTML tool]: https://iancoleman.io/bip39/
