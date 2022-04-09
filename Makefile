stow:
	stow -v --ignore tags --ignore Makefile --ignore bin -S .

restow:
	stow -v --ignore tags --ignore Makefile --ignore bin -R .

delete:
	stow -v --ignore tags --ignore Makefile --ignore bin -D .

all: stow

.PHONY: stow restow delete
