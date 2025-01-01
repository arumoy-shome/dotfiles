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
	stow -v --adopt --dir=files --target=${HOME} -S .

restow:
	stow -v --adopt --dir=files --target=${HOME} -R .

delete:
	stow -v --adopt --dir=files --target=${HOME} -D .

simulate:
	stow --no --adopt -v --dir=files --target=${HOME} -S .

llm-system-prompt:
	llm -s "$(shell cat files/.local/share/llm/git-commit.txt)" --save git-commit
	llm -s "$(shell cat files/.local/share/llm/git.txt)" --save git
	llm -s "$(shell cat files/.local/share/llm/prompting.txt)" --save prompting
	llm -s "$(shell cat files/.local/share/llm/python.txt)" --save python
	llm -s "$(shell cat files/.local/share/llm/social.txt)" --save social

all:
	stow
	install-core
	install-python
	install-latex
	install-sh
	install-markdown
	install-cask

.PHONY: stow restow delete simulate ctags install install-cask
