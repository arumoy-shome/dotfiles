install:
	brew install git zsh zsh-syntax-highlighting zsh-autosuggestions zsh-history-substring-search stow make fd fzf node pandoc glow pure starship tldr tmux tree coreutils

install-cask:
	brew instal --cask 1password karabiner-elements alfred logitech-camera-settings logitech-options firefox nordvpn pdf-expert font-source-code-pro spotify transmission hammerspoon iterm2-beta vlc

stow:
	stow -v --ignore tags --ignore Makefile --ignore bin --ignore .gitmodules -S .

restow:
	stow -v --ignore tags --ignore Makefile --ignore bin --ignore .gitmodules -R .

delete:
	stow -v --ignore tags --ignore Makefile --ignore bin --ignore .gitmodules -D .

all: stow

ctags:
	find . -type f -not -path '*git*' | ctags --tag-relative=yes -L -

lint: .bash_profile .bashrc .bashrc.dumb .bashrc.xterm .zshrc
	shellcheck $<

.PHONY: stow restow delete ctags install install-cask
