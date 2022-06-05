bip39-diceware.pdf: bip39-diceware.tex list-a.txt list-b.txt
	latexmk -quiet -pdf bip39-diceware.tex
	latexmk -c bip39-diceware.tex

list-a.txt list-b.txt:
	bash ./aux/genlists.sh

.PHONY: clean
clean:
	rm -f bip39-diceware.pdf list-a.txt list-b.txt
