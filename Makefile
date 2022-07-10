stow:
	stow -v --ignore tags --ignore Makefile --ignore bin --ignore .gitmodules -S .

restow:
	stow -v --ignore tags --ignore Makefile --ignore bin --ignore .gitmodules -R .

delete:
	stow -v --ignore tags --ignore Makefile --ignore bin --ignore .gitmodules -D .

all: stow

ctags:
	find . -type f -not -path '*git*' | ctags --tag-relative=yes -L -

.PHONY: stow restow delete ctags
