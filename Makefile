install:
	brew install git zsh stow make fd ripgrep fzf pandoc tldr tmux tree coreutils

install-cask:
	brew instal --cask 1password karabiner-elements alfred pdf-expert font-sauce-code-pro-nerd-font spotify transmission hammerspoon vlc

stow:
	stow -v --dir=files --target=${HOME} -S .

restow:
	stow -v --dir=files --target=${HOME} -R .

delete:
	stow -v --dir=files --target=${HOME} -D .

simulate:
	stow --no -v --dir=files --target=${HOME} -S .

all:
	stow
	install
	install-cask

ctags:
	find . -type f -not -path '*git*' | ctags --tag-relative=yes -L -

.PHONY: stow restow delete simulate ctags install install-cask
