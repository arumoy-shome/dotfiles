UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
  PLATFORM := macos
else
  PLATFORM := linux
endif

STOW := stow -v --adopt --dir=files --target=${HOME}
PACKAGES := common $(PLATFORM)

install-core:
	brew install git zsh stow make fd ripgrep fzf pandoc tldr tmux tree coreutils aspell vim neovim universal-ctags

install-cask:
	brew instal --cask 1password karabiner-elements alfred pdf-expert font-sauce-code-pro-nerd-font spotify transmission hammerspoon vlc

install-python:
	brew install ruff python-language-server

install-latex:
	brew install bib-tool texlive texlab

install-sh:
	brew install shellcheck

install-markdown:
	brew install --cask glow
	brew install marksman

stow:
	$(STOW) -S $(PACKAGES)

restow:
	$(STOW) -R $(PACKAGES)

delete:
	$(STOW) -D $(PACKAGES)

simulate:
	$(STOW) --no -S $(PACKAGES)

llm-system-prompt:
	llm -s "$(shell cat files/common/.local/share/llm/git-commit.txt)" --save git-commit
	llm -s "$(shell cat files/common/.local/share/llm/git.txt)" --save git
	llm -s "$(shell cat files/common/.local/share/llm/prompting.txt)" --save prompting
	llm -s "$(shell cat files/common/.local/share/llm/python.txt)" --save python

all:
	stow
	install-core
	install-python
	install-latex
	install-sh
	install-markdown
	install-cask

.PHONY: stow restow delete simulate ctags install install-cask
