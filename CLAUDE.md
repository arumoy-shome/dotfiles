# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A personal dotfiles repo managed with GNU Stow. There is no build, no test
suite, and no linter — `make` targets are the entire interface.

Removed config is listed in `ATTIC.md` with the sha to restore it from.

## Commands

    make stow      # symlink common + the current platform's package into $HOME
    make restow    # re-run after adding, moving, or deleting a tracked file
    make delete    # remove the symlinks
    make simulate  # dry run; prints the LINK/UNLINK it would perform

    make install-core   # brew on macOS, apt on Linux; dispatches on uname
    make install-cask   # GUI apps, macOS only

`make simulate` is the safe way to check a structural change. Zero `LINK:`
lines means the tree is already fully stowed.

Override the platform for testing: `make simulate PLATFORM=linux`.

## Stow layout

`files/` holds three stow packages. `make stow` installs `common` plus the one
matching `uname -s`:

| package | when            | holds                                              |
|---------|-----------------|----------------------------------------------------|
| common  | always          | shells, vim, tmux, git, and the CLI tool configs   |
| macos   | Darwin          | ghostty, gvimrc                                    |
| linux   | everything else | nothing yet                                        |

Inside a package the tree mirrors `$HOME`, so `files/common/.config/git/config`
lands at `~/.config/git/config`.

Stow *folds* packages together, so two packages can contribute to one
directory — `~/.vim` gets `vimrc` from `common` and `gvimrc` from `macos`.
Keep this in mind when moving a file between packages: the `$HOME` destination
does not change, only which platform receives it.

`files/linux/.stow-local-ignore` is a placeholder that keeps the otherwise
empty package tracked in git. Stow never installs `.stow-local-ignore`, so
do not replace it with a `.gitkeep` — that would get symlinked to `~/.gitkeep`.

`bin/` is **not** stowed. Both shells add `$HOME/dotfiles/bin` to `PATH`
directly, so scripts there are live without any restow. These scripts are
expected to migrate to their own repos over time.

## Conventions

**Guard, don't branch.** Platform differences are handled with a candidate
list plus an existence check, not with `uname`/`$OSTYPE` conditionals. Adding
a platform means adding a path to an array, and absent paths are silently
skipped. See the `paths`, `plugins` arrays in `.zshrc` and `completions` in
`.bash_profile`. Explicit OS dispatch is confined to the `Makefile` and
`bin/o`.

**Degrade, don't require.** Optional tools are gated on `command -v` /
`(( $+commands[x] ))` and fall back: no starship → zsh's `walters` prompt, no
`bat` → `cat`, no `fd` → `find`. On Debian, `fd` and `bat` install as `fdfind`
and `batcat`; the shells alias them back rather than creating symlinks in
`~/.local/bin`. `fd` is additionally resolved into `$FD` because
`FZF_DEFAULT_COMMAND` is executed by fzf via `sh -c`, where aliases do not
apply.

**zsh and bash are maintained in parallel.** The duplication between
`.zshrc` and `.bashrc` is deliberate — bash is kept working for remote servers.
A change to one usually needs the same change in the other, in that shell's
idiom.

**High-churn config lives in untracked files.** Colours and fonts change often,
so they sit in gitignored siblings — `ghostty/local`, `.vim/colors.vim` —
plus the `~/.zshrc.local` / `~/.bashrc.local` escape
hatches sourced at the end of each rc file. Put machine-specific settings
there, not in the tracked files.

## Editing stowed files

Tracked files are symlinked into `$HOME`, so editing
`files/common/.zshrc` *is* editing `~/.zshrc` — no restow needed for content
changes. Only adding, deleting, or moving a file requires `make restow`.

Because of this, verify shell edits by running the real thing:
`zsh -n ~/.zshrc`, then `zsh -i -c '...'`. Note that `zsh -i -c` prints two
harmless `can't change option: zle` warnings from fzf's init under a non-tty;
they are pre-existing and not a regression.

## Platform notes

Ubuntu support targets WSL2, where the terminal emulator is a Windows-side
application — that is why ghostty (and all font settings) lives in the
`macos` package. There is no display server, so vim's
`clipboard=unnamedplus` cannot reach the Windows clipboard on its own; that
gap is unresolved and needs OSC52 or `win32yank.exe`.

Ubuntu package names have been verified against noble. `tldr` there is only a
transitional package, so the Makefile uses `tldr-py`; Debian's fzf vim plugin
lives at `/usr/share/doc/fzf/examples`, not `/usr/share/doc/fzf`.
