stow:
	stow -v --ignore tags --ignore Makefile --ignore bin --ignore .gitmodules -S .

restow:
	stow -v --ignore tags --ignore Makefile --ignore bin --ignore .gitmodules -R .

delete:
	stow -v --ignore tags --ignore Makefile --ignore bin --ignore .gitmodules -D .

all: stow

.PHONY: stow restow delete
