# Attic

Config and scripts removed from this repo. Nothing is lost — git still has
every one of them. To bring one back:

    git show <sha>:<path> > <path>

The sha recorded here is the **last commit that still contained the file**, so
no `^` arithmetic is needed. To see it before restoring:

    git show <sha>:<path>

| what | why | sha |
|---|---|---|
| `files/macos/.config/kitty/` | uninstalled; ghostty replaced it. 2,121 lines, almost all the upstream default dump | `92445a1` |
| `files/macos/.config/alacritty/` | uninstalled; its `import` of `current-theme.toml` had been broken for a while | `92445a1` |
| `bin/yob` | light/dark toggle for kitty; guarded on `$TERM` matching kitty so it refused to run at all | `92445a1` |
| `aru#update_colors()` in `.vim/autoload/aru.vim` | read the light/dark hint `yob` wrote; pinned vim to `darkblue` once that file went stale | `92445a1` |
| `files/macos/.aerospace.toml` | uninstalled weeks after being added; was the stock upstream config verbatim | `ebdefa4` |
| `files/macos/.hammerspoon/` | app still installed, but the config launched Kitty, Firefox and Emacs, none of which are on this machine | `ebdefa4` |
| `files/common/.config/helix/` | not installed | `e9ca427` |
| `files/common/.config/gitui/` | not installed; superseded by lazygit | `e9ca427` |
| `files/common/.config/marksman/` | not installed | `e9ca427` |
| `bin/bib2key` | body duplicated verbatim in `.local/share/aims/paper` | `045b3d4` |
| `bin/mytags` | needs universal-ctags; only the Xcode BSD stub is on PATH | `045b3d4` |
| `bin/scratch` | three lines, added once, never used | `045b3d4` |
| `bin/rename` | `match` had no `case "y"`, so it rejected the only sensible answer; worked only with `--force` | `045b3d4` |
| `.local/share/rename/stopwords-en.txt` | 1,297 lines, only consumer was `bin/rename` | `045b3d4` |
| `bin/mdgrep` | unused; carried a `count()` nothing called | `045b3d4` |
| `bin/today` | unused; backslash in an f-string expression, a SyntaxError before Python 3.12 | `045b3d4` |
| `.local/share/quarto/custom.scss` | never the copy being used — quarto resolves `theme:` relative to the `.qmd` | `045b3d4` |
| `.local/share/pandoc/templates/private.html` | no references anywhere; `public.html` has three and stays | `045b3d4` |
| `.local/share/llm/` + `make llm-system-prompt` | `llm` not installed; nothing else read the prompts | `045b3d4` |
| `.vim/spell/en.utf-8.add` | topically stale — vimwiki, zettel, hadoop | `c7f8a56` |
| `make install-markdown` | glow (a formula, not a cask) and marksman; neither installed | `e9ca427` |

## Earlier removals, before this file existed

Note these predate the stow package split, so their paths are `files/.config/…`
rather than `files/common/.config/…`.

| what | why | sha |
|---|---|---|
| `bin/doi2bib` | moved to its own repo; succeeded by `bs` from `~/code/bibshelf` | `e33adc3` |
| `files/.config/nvim/` | retired in favour of vim | `93d939c` |
| `files/.config/karabiner/` | app still installed, config no longer tracked here | `74f2860` |
| `.wezterm.lua` | terminal replaced | `f50561c` |
| `.config/git/template/hooks/` incl. `ctags` | git hooks, dropped | `d71dea3` |
