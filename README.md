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
  zsh), terminal emulator (currently ghostty) and operating system
  (unix like).
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
system. `make install-core` installs them; it uses Homebrew on macOS and
apt on Ubuntu, picked automatically from `uname`.

Everything below `stow` is optional. The shell config gates on
`command -v` and degrades quietly: `bat` falls back to `cat`, `fd` to
`find`, and the prompt to zsh's built-in `walters`. On Debian
derivatives `fd` and `bat` install as `fdfind` and `batcat`; the shell
config aliases them back rather than relying on symlinks in
`~/.local/bin`. `starship` is not in apt and must be installed by hand
on Ubuntu.

+ git: my preferred vcs
+ vim: editor of choice
+ zsh: preferred shell of choice
+ bash: backup shell; I keep the config around for remote servers
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
+ aspell: spell checker (optional)
+ bib-tool: bibliography management cli (optional)
+ tldr: cli cheatsheet (optional)
+ tmux: terminal multiplexer (optional)
+ tree: pretty-print directory structure (optional)

Following are the GUI applications I use. I install them manually
using Homebrew Cask; macOS only (`make install-cask`).

+ ghostty: terminal emulator of choice
+ dash: documentation reader
+ karabiner-elements: keyboard manipulation; space cadet shifts, hyper
  key, capslock as control & the likes
+ font-sauce-code-pro-nerd-font: font of choice
+ pdf-expert: pdf reader of choice; adds much needed split views which
  Preview does not have
+ spotify: music streaming service of choice
+ transmission: torrent client of choice
+ vlc: media player

# Installation

I use [stow] to symlink the configuration files in their respective
locations. `files/` holds three stow packages, and `make stow` installs
`common` plus the one matching the current platform:

    files/
    ├── common  always stowed
    ├── macos   stowed on Darwin
    └── linux   stowed everywhere else

Within a package the directory structure mimics that of $HOME, so files
& folders map 1:1 under $HOME:

    files/common/
    ├── .config     ~> $HOME/.config
    ├── .local      ~> $HOME/.local
    ├── .vim        ~> $HOME/.vim
    └── .zshrc      ~> $HOME/.zshrc

`macos` holds the things that only exist there: the ghostty config
along with its font settings, and gvimrc. Under WSL2 the terminal is a
Windows-side application, so neither applies.

Stow folds the packages together, so `common` and `macos` can both
contribute files to a shared directory such as `~/.vim`.

    make stow      # symlink common + $platform
    make restow    # after adding or moving files
    make delete    # remove the symlinks
    make simulate  # dry run

[stow]: https://www.gnu.org/software/stow/

