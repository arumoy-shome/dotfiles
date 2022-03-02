---
title: Aru's Information Management System (AIMS)
date: [2022-02-28 Mon 03:27]
author: Arumoy Shome
---

AIMS or Aru's Information Management System is a collection of
shellscripts to manage information in plaintext. It is inspired by
[org-mode](orgmode.org/), and tries to replicate a subset of its
functionalities which I frequently use. AIMS is completely tuned
towards my workflow as a researcher and how I manage my digital notes.

Although org-mode is great, the primary motivation behind AIMs is
because I was feeling a lot of resistance when trying to tune it to my
workflow, primarily because of Elisp.

You can find the latest version of the script on my [dotfiles
repo](https://github.com/arumoy-shome/dotfiles/blob/master/bin/aims),
below is the script as it stands on [2022-02-28 Mon 03:33].

```bash
#!/usr/bin/env bash

# aims: Aru's Information Management System

# A set of unix shellscripts to manage information. This is tuned
# specifically for my workflow as a researcher.

NOTESDIR="$HOME/org"
INBOX="$NOTESDIR/inbox.md"
TEMPLATESDIR="$XDG_DATA_HOME/aims"
[[ ! -e "$INBOX" ]] && touch "$INBOX"

__capture() {
  # Capture incoming info quickly. All items are appended to INBOX
  # which defaults to `inbox.md' in NOTESDIR. Optionally a template
  # can be specified using the --template| -t flag.
  local TEMPLATE="$TEMPLATESDIR/default"

  while [[ "$1" =~ ^-+.* && ! "$1" == "--" ]]; do
    case "$1" in
      --template | -t)
        shift
        TEMPLATE="$TEMPLATESDIR/$1"
        ;;
      *)
        echo "Error: unknown option $1."
        return 1
        ;;
    esac; shift
  done

  local ITEM=$(mktemp)
  if [[ -e "$TEMPLATE" && -x "$TEMPLATE" ]]; then
    eval "$TEMPLATE $ITEM"
  fi

  if eval "$EDITOR -c 'set ft=markdown' $ITEM"; then
    [[ "$1" && -e "$NOTESDIR/$1" ]] && INBOX="$NOTESDIR/$1"
    cat "$ITEM" >> "$INBOX"
    echo "Info: captured in $INBOX."
  fi

  echo "Info: cleaning up $(rm -v "$ITEM")"
}

__capture "$@"
```

For the time being, it only provides the capture functionality. What I
find really neat is the templating system. An arbitrary name for a
template can be passed to `aims` using the `--template` (or `-t` for
short) flag. `aims` looks for a shellscript with the same name in the
`$XDG_DATA_HOME/aims` directory and executes it if it exists. The
beauty of this design is in its simplicity. Since templates are
shellscripts, it gives us the full expressiveness of the shell. This
is best demonstrated with some examples. Here is my `default` template
as of [2022-02-28 Mon 03:40] which is used when no template is
specified.

```bash
#!/usr/bin/env bash

[[ -z "$1" ]] && return 1

echo >> "$1"
echo "# [$(date +'%Y-%m-%d %a %H:%M')]" >> $1
```

It simply adds a level 1 markdown header followed by a timestamp. Here
is another for capturing research papers.

```bash
#!/usr/bin/env bash

[[ -z "$1" ]] && return 1

echo >> "$1"

BIBKEY=$(pbpaste | grep '^@.*' | sed 's/^@.*{\(.*\),/\1/')
if [[ -n "$BIBKEY" ]]; then
  echo "# [$(date +'%Y-%m-%d %a %H:%M')] $BIBKEY" >> $1
else
  echo "# [$(date +'%Y-%m-%d %a %H:%M')]" >> $1
fi

echo >> "$1"
echo '+ **Problem Statement:**' >> "$1"
echo '+ **Solution**' >> "$1"
echo '+ **Results**' >> "$1"
echo '+ **Limitations**' >> "$1"
echo '+ **Remarks**' >> "$1"
echo >> "$1"
echo '```bibtex' >> "$1"

if [[ -n "$BIBKEY" ]]; then
  pbpaste | sed '/^$/d' >> "$1" # remove empty lines
  pbcopy <(echo "$BIBKEY")
fi

echo '```' >> "$1"
```

This one is a bit more involved but highlights the power of using
shellscripts for templating. Given that a bibentry is copied in the
clipboard, this template adds a level 1 markdown header with a
timestamp and the bibkey. It adds some prompts for later when I write
my notes and sticks the bibentry at the bottom.

A temporary file is used to compose the text first. Upon successful
completion, the contents of the temporary file are appended to the
default INBOX file if no other files are specified.
