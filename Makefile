SHELL:= $(shell which bash)
XDG_CONFIG_HOME:= $(HOME)/.config
XDG_DATA_HOME:= $(HOME)/.local/share
XDG_DATA_BIN:= $(HOME)/.local/bin

GIT_TARGET:= $(XDG_CONFIG_HOME)/git
ZSH_TARGET:= $(XDG_CONFIG_HOME)/zsh
VIM_TARGET:= $(HOME)/.vim
NVIM_TARGET:= $(XDG_CONFIG_HOME)/nvim
PANDOC_TARGET:= $(XDG_DATA_HOME)/pandoc
HAMMERSPOON_TARGET:= $(HOME)/.hammerspoon
KITTY_TARGET:= $(XDG_CONFIG_HOME)/kitty

$(GIT_TARGET):
	mkdir -p $(GIT_TARGET)

$(ZSH_TARGET):
	mkdir -p $(ZSH_TARGET)

$(NVIM_TARGET):
	mkdir -p $(NVIM_TARGET)

$(VIM_TARGET):
	mkdir -p $(VIM_TARGET)

$(PANDOC_TARGET):
	mkdir -p $(PANDOC_TARGET)

$(HAMMERSPOON_TARGET):
	mkdir -p $(HAMMERSPOON_TARGET)

$(KITTY_TARGET):
	mkdir -p $(KITTY_TARGET)

$(XDG_DATA_BIN):
	mkdir -p $(XDG_DATA_BIN)

git: $(shell find git -type f) | $(GIT_TARGET)
	stow -v -t $(GIT_TARGET) -R $@

zsh: $(shell find zsh -type f) | $(ZSH_TARGET)
	stow -v -t $(ZSH_TARGET) -R $@

bash: $(shell find bash -type f)
	stow -v -t $(HOME) -R $@

vim: $(shell find vim -type f) | $(VIM_TARGET) $(NVIM_TARGET)
	stow -v -t $(VIM_TARGET) -R $@
	stow -v -t $(NVIM_TARGET) -R nvim

tmux: $(shell find tmux -type f)
	stow -v -t $(HOME) -R $@

pandoc: $(shell find pandoc -type f) | $(PANDOC_TARGET)
	stow -v -t $(PANDOC_TARGET) -R $@

hammerspoon: $(shell find hammerspoon -type f) | $(HAMMERSPOON_TARGET)
	stow -v -t $(HAMMERSPOON_TARGET) -R $@

kitty: $(shell find kitty -type f) | $(KITTY_TARGET)
	stow -v -t $(KITTY_TARGET) -R $@

bin: $(shell find bin -type f) | $(XDG_DATA_BIN)
	stow -v -t $(XDG_DATA_BIN) -R $@

shell: git zsh kitty bin

all: git zsh vim tmux pandoc vim hammerspoon

.PHONY: git zsh bash vim tmux pandoc hammerspoon kitty bin
