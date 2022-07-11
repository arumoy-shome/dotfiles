# Dotfiles

A set of files that begin with a dot and are updated quite frequently.

# Principles

+ Must be fast. All tools & their corresponding configurations must be
  fast.
+ Balance between functionality & customisability. I choose the
  minimum subset of tools that gets the job done. For instance,
  instead of relying on several plugins which may or may not be
  available to me on all systems, I choose to develop a deeper
  understanding of the shell (used to be zsh for a long time, its been
  bash for a while now) itself.
+ Tools & configuration must be cross-{shell,terminal,platform}. They
  should work irrespective of the shell (posix compliant; bash or
  zsh), terminal emulator (iTerm2, kitty, alacritty or wezterm) and
  operating system (unix like).
+ Keep high churn configurations in separate, untracked files. I keep
  the colorscheme & font configuration in separate files since
  I change them often.
+ Stick as close to "bare metal" as possible. This means avoid
  additional plugins and external dependencies as much as
  possible. Instead opt to implement the feature/functionality
  yourself. The idea is to thoroughly vet plugins and dependencies
  before adding them but be smart about it.

# Dependencies

Following are the packages & software that must be installed on the
system. I do this manually using Homebrew.

+ git: my preferred vcs
+ vim: my preferred editor; used to be emacs for a while.
+ bash: my preferred shell; used to be zsh
+ pandoc: file format conversion cli; plays a cental role in my
  information management & publication system
+ stow: symlink management cli; required to manage files in this repo
+ starship: cross-shell prompt; I additionally remove all the emojis
  and make it look like the pure prompt (optional)
+ fzf: general purpose fuzzy finder; I also use it within vim (optional)
+ ripgrep: user-friendly alternative to grep; although I choose grep
  most of the time for its portability (optional)
+ fd: user-friendly alternative to find; this one I use more
  frequently because find's syntax is non-intuitive (optional)
+ bat: alternative to cat (optional)
+ glow: pretty-print markdown cli (optional)
+ aspell: spell checker (optional)
+ bib-tool: bibliography management cli (optional)
+ csvkit: csv manipulation cli (optional)
+ dvc: machine learning data & pipeline vcs (optional)
+ htop: alternative to top (optional)
+ tig: git tui; although most of the time I use vim-fugitive (optional)
+ tldr: cli cheatsheet (optional)
+ tmux: terminal multiplexer (optional)
+ tree: pretty-print directory structure (optional)

Following are the GUI applications I use. I install them manually
using Homebrew Cask.

+ 1password: password manager
+ alfred: spotlight alternative
+ dash: documentation reader
+ hammerspoon: osx automation; primarily (under)utilised for window management
+ firefox: web browser of choice
+ font-jetbrains-mono: proportional font of choice
+ karabiner-elements: keyboard manipulation; space cadet shifts, hyper
  key, capslock as control & the likes
+ mactex: full latex distribution for osx
+ logitech-camera-settings: for logitech webcam
+ logitech-options: for logitech mouse
+ nordvpn: vpn of choice
+ pdf-expert: pdf reader of choice; adds much needed split views which
  Preview does not have
+ spotify: music streaming service of choice
+ transmission: torrent client of choice
+ wezterm: terminal emulator of choice
+ docker: container management; I often use it to isolate my
  development environments (optional)
+ font-ibm-plex-serif: non-proportional font of choice (optional)
+ font-source-code-pro: ex proportional font of choice (optional)

# Installation

I use [stow] to symlink the configuration files in their respective
locations. The directory structure of this repo mimics that of $HOME
such that files & folder in this repo will be mapped 1:1 under $HOME
for instance:

    .
    ├── .config	     ~> $HOME/.config
    ├── .git
    ├── .hammerspoon ~> $HOME/.hammerspoon
    ├── .local	     ~> $HOME/.local
    ├── .vim	     ~> $HOME/.vim
    └── bin

    6 directories

[stow]: https://www.gnu.org/software/stow/

