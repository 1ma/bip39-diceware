.PHONY: all

all:
	bash ./genlist.sh
	latexmk -quiet -pdf diceware.tex
	latexmk -c diceware.tex
	rm list-a.txt list-b.txt
