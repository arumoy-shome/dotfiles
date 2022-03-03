# [2022-03-03 Thu 19:46] zsh autoloaded functions
Snippet to load autoloaded functions in zsh.

```zsh
# Autoloads {{{
fpath=("$ZDOTDIR/functions" $fpath)

# NOTE: (double)quotes don't work here, probably because it's a glob pattern?
for f in $ZDOTDIR/functions/*; do autoload -U ${f:t}; done
# End Autoloads }}}
```

# [2022-03-03 Thu 19:32] zsh paper script
Keeping for future reference.

```zsh
# vim: filetype=zsh foldmethod=marker
# helper function for scientific papers.

# Init {{{
local PAPERDIR="$HOME/Documents/papers"
local NOTESDIR="$HOME/org"
local GREPPRG=rg
# }}}

# Browse {{{
__browse() {
  emulate -L zsh

  if [[ -n "$1" ]]; then
    pushd $PAPERDIR
    if [[ -e "$1" ]]; then
      open $1
    else
      echo "Error: $1 does not exist."
      return 1
    fi
    popd
  else
    echo "Error: No paper provided."
    return 1
  fi
}
# }}}

# Get Bibs {{{
__get_bibs() {
  emulate -L zsh

  local NOTESFMT=md
  local BIBRX='^```bibtex\n((.+\n)+)```$'
  local BIBPRUNERX="^\d+-\d+-\d+--paper--(\w+)\.$NOTESFMT:\s+(.+)"

  $GREPPRG --type $NOTESFMT --max-depth 1 --multiline $BIBRX | \
    $GREPPRG $BIBPRUNERX -r '$1:$2'
}
# }}}

# Get Titles {{{
__get_titles() {
  emulate -L zsh

  local TITLERX='\w+:title=\{.+\}'
  __get_bibs | $GREPPRG $TITLERX
}
# }}}

# Get Authors {{{
__get_authors() {
  emulate -L zsh

  local AUTHORRX='\w+:author=\{.+\}'
  __get_bibs | $GREPPRG $AUTHORRX
}
# }}}

# Get Sources {{{
__get_sources() {
  emulate -L zsh

  local SOURCERX='\w+:(booktitle|journal)=\{.+\}'
  __get_bibs | $GREPPRG $SOURCERX
}
# }}}

# Get Years {{{
__get_years() {
  emulate -L zsh

  local YEARRX='\w+:year=\{.+\}'
  __get_bibs | $GREPPRG $YEARRX
}
# }}}

# Grep {{{
__grep() {
  emulate -L zsh
  pushd $NOTESDIR

  while [[ "$1" =~ - && ! "$1" == "--" ]]; do
    case "$1" in
      --help | -h)
        echo "grep: search for pattern in bibtex entries."
        echo "--title -t: search for pattern in title field."
        echo "--author -a: restrict search to the author field."
        echo "--source -s: restrict search to the publication source field."
        echo "--year -y: restrict search to the year field."
        echo "without any flags search all fields."
        return 0
        ;;
      --title | -t)
        shift
        local QUERY=$1
        if [[ -z "$QUERY" ]]; then
          echo "Error: title cannot be empty."
          return 1
        fi
        __get_titles | $GREPPRG --smart-case $QUERY
        ;;
      --author | -a)
        shift
        local QUERY=$1
        if [[ -z "$QUERY" ]]; then
          echo "Error: author cannot be empty."
          return 1
        fi
        __get_authors | $GREPPRG --smart-case $QUERY
        ;;
      --source | -s)
        shift
        local QUERY=$1
        if [[ -z "$QUERY" ]]; then
          echo "Error: source cannot be empty."
          return 1
        fi
        __get_sources | $GREPPRG --smart-case $QUERY
        ;;
      --year | -y)
        shift
        local QUERY=$1
        if [[ -z "$QUERY" ]]; then
          echo "Error: year cannot be empty."
          return 1
        fi
        __get_years | $GREPPRG --smart-case $QUERY
        ;;
      *)
        if [[ -z "$1" ]]; then
          echo "Error: query cannot be empty."
          return 1
        fi
        __get_bibs | $GREPPRG --smart-case $1
        ;;
    esac; shift; done
    popd
}
# }}}

# Main {{{
case "$1" in
  browse | bro | b)
    __browse "${@:2}"
    ;;
  grep | rg | g)
    __grep "${@:2}"
    ;;
  *)
    echo "Error: unknown command $1."
    return 1
    ;;
esac
# }}}

```

# [2022-03-03 Thu 19:24] zsh completion piggyback
Following snippet can be used to piggyback off of existing commands to
complete custom commands.

```zsh
#compdef g
compdef g=git
```

# [2022-03-03 Thu 15:27] zsh pub script
The original `pub` autoloaded zsh function

```zsh
# vim: filetype=zsh foldmethod=marker
# helper function for publishing content.

# Init {{{
local PUBPRG=pandoc
local SRCFMT="md"
local PUBFMT="html"
local SRCDIR="$HOME/org"
local PUBDIR="$SRCDIR/docs"
local SRCFILES="/tmp/src.txt"
local PUBFILES="/tmp/pub.txt"
# }}}

# get_template {{{
  emulate -L zsh
__get_template() {
  # taken from https://github.com/jgm/pandoc/issues/1958#issuecomment-81978951
  # extract the template from the SCRFILE else use default template
  sed -n 's/^template:[ ][ ]*\(.*\)/\1/p' $SRCDIR/$1.$SRCFMT | sed 's/^\(..*\)$/\1/'
}
# }}}

# sync {{{
__sync() {
  emulate -L zsh

  local FILESRX='^\d+-\d+-\d+--\w+--\w+'
  fd --extension $SRCFMT $FILESRX $SRCDIR --exec echo {/.} | sort > $SRCFILES
  fd --extension $PUBFMT $FILESRX $PUBDIR --exec echo {/.} | sort > $PUBFILES
}
# }}}

# ls {{{
__ls() {
  emulate -L zsh

  if [[ -n "$1" ]]; then
    local NAME="${1:t:r}"
    if [[ -e "$PUBDIR/$NAME.$PUBFMT" ]]; then
      echo "$1 is published."
    else
      echo "$1 is unpublished."
    fi
  else
    __sync
    # print all published files
    comm -12 $SRCFILES $PUBFILES | column
  fi
}
# }}}

# all {{{
__all() {
  emulate -L zsh

  __sync
  echo -n "Info: publish $(cat $PUBFILES | wc -l) files? [y/n]: "
  read ANS
  [[ "${ANS:l}" != "y" ]] && return 1

  for SRCNAME in $(comm -12 $SRCFILES $PUBFILES); do # published files
    __publish $SRCNAME
  done
}
# }}}

# browse {{{
__browse() {
  emulate -L zsh

  if [[ -n "$1" ]]; then
    local NAME="${1:t:r}"
    if [[ -e "$PUBDIR/$NAME.$PUBFMT" ]]; then
      open "https://arumoy.me/org/$NAME"
    else
      echo "Info: $1 is not published."
      return 1
    fi
  else
    open 'https://arumoy.me/org'
  fi
}
# }}}

# __publish {{{
__publish() {
  local TEMPLATE=$(__get_template $1)
  if [[ -z "$TEMPLATE" ]]; then
    echo "Error: $1.$SRCFMT does not specify a template."
    echo "To publish, specify a template in the header."
    return 1
  fi

  echo "Info: publishing $1.$SRCFMT as $PUBDIR/$1.$PUBFMT with template $TEMPLATE"
  $PUBPRG ${@:2} --template=$TEMPLATE --output $PUBDIR/$1.$PUBFMT $SRCDIR/$1.$SRCFMT
}
# }}}

# Main {{{
case "$1" in
  ls )
    __ls "${@:2}"
    ;;
  browse )
    __browse "${@:2}"
    ;;
  all )
    __all "${@:2}"
    ;;
  * )
    if [[ -e "$SRCDIR/$1" ]]; then
      local SRCNAME="${1:t:r}" # only the name
      __publish $SRCNAME
    fi
    ;;
esac
# }}}

```

# [2022-03-03 Thu 02:31] basename
This script was rarely used as a zsh autoloaded function, and the
optimisation isn't that useful since I rarely use `basename` from the
shell itself (I generally use it within scripts).

```bash
# vim:filetype=zsh
# No arguments: `basename $PWD`
# With arguments: acts like `basename`

if [[ $# -gt 0 ]]; then
  command basename "$@"
else
  command basename "$PWD"
fi
```

# base16-* config
I used to use base16-vim along with base16-shell to sync the
colorschemes between my shell & vim. However, I have since switched to
the Kitty terminal which has built-in functionality to switch between
schemes from the command-line. On the vim end, I am happy with the
default scheme which (for the most part) inherits from the scheme I set
on the terminal. Here I document my prior configuration for reference
purpose.

The following function is autoloaded.

``` vimscript
function aru#colorscheme() abort
  let s:config_file = expand('~/.vim/.background')

  if filereadable(s:config_file)
    let s:config = readfile(s:config_file, '', 2)
    execute 'set background=' . s:config[1]
    execute 'colorscheme ' . s:config[0]
  else " default
    set background=dark
    colorscheme base16-default-dark
  endif
endfunction
```

And the following snippet should be in somewhere in the after/
directory.

``` vimscript
call aru#colorscheme()
```

# Unix knowledge management system
I tried writing an org clone for the shell, alas it didn\'t work as
well.

``` shell
# vim: filetype=zsh foldmethod=marker
# knowledge management using unix tools.

# Init {{{
local GREPPRG=rg
local FINDPRG=fd
local CATPRG=bat
local AUTHOR="Arumoy Shome"
[[ -z $NOTESFORMAT ]] && local NOTESFORMAT="md"
[[ -z $NOTESDIR ]] && local NOTESDIR="$HOME/org"
[[ -z $TEMPLATEDIR ]] && local TEMPLATEDIR="$NOTESDIR/.templates"
[[ ! -d $NOTESDIR ]]  && mkdir -p $NOTESDIR
# }}}

# Agenda {{{
__agenda () {
  emulate -L zsh

  # 1: type
  # 2: project (optional)
  # 3: file name
  # 4: title
  local AGENDAKW='todo|capture|idea'
  local PRETTYRX="($AGENDAKW)@(.+)--(.+)\.$NOTESFORMAT:#+\s(.+)$"
  local PRETTYPRINT='$1|$2|$3|$4'
  local QUERYRX='^#.+'
  local GREPCMD='__grep'
  local CMD="--no-heading --no-line-number --with-filename"

  while [[ "$1" =~ - && ! "$1" == "--" ]]; do
    case "$1" in
      --help | -h)
        echo "agenda: pretty print markdown headers."
        echo "--type -t: limit to files matching specified type."
        echo "--project -p: limit to files matching specified project."
        ;;
      --type | -t)
        shift
        GREPCMD="$GREPCMD --type ${1:l}" # lowercase
        ;;
      --project | -p)
        shift
        GREPCMD="$GREPCMD --project ${1:l}" # lowercase
        ;;
      *)
        # NOTE: similar to grep and find, assume that the rest of the
        # args are to be passed along to grep and/or find.
        break
        ;;
    esac; shift
  done

  CMD="$GREPCMD '$QUERYRX' $CMD"

  eval $CMD | \
    $GREPPRG $PRETTYRX -r $PRETTYPRINT | \
    column -t -s '|'

}
# end Agenda }}}

# Grep {{{
__grep () {
  emulate -L zsh

  local CMD="$GREPPRG --smart-case --max-depth 1 --type $NOTESFORMAT"
  local FINDCMD='__find'

  while [[ "$1" =~ - && ! "$1" == "--" ]]; do
    case "$1" in
      --help | -h )
        echo "grep: grep wrapper for notes files."
        echo "--type -t: limit to files matching specified type."
        echo "--project -p: limit to files matching specified project."
        echo "All additional arguments are passed to $GREPPRG verbatim."
        return 0
        ;;
      --type | -t)
        shift
        local TYPEFLAG=1
        FINDCMD="$FINDCMD --type ${1:l}" # lowercase
        ;;
      --project | -p)
        shift
        local PROJECTFLAG=1
        FINDCMD="$FINDCMD --project ${1:l}" #lowercase
        ;;
      --query | -q)
        shift
        CMD="$CMD '$1'"
        ;;
      *)
        # NOTE: similar to what we do in find, assume that the rest of
        # the args are to be passed along to GREPPRG.
        break
        ;;
    esac; shift
  done

  if [[ "$TYPEFLAG" || "$PROJECTFLAG" ]]; then
    CMD="$FINDCMD --exec-batch $CMD"
  fi

  # pass any additional args
  [[ "$@" ]] && CMD="$CMD $@"

  eval $CMD
}
# end Grep }}}

# Find {{{
__find() {
  emulate -L zsh

  # Show Tags {{{
  __show_tags () {
    $FINDPRG --max-depth 1 --extension $NOTESFORMAT | \
      $GREPPRG $1 -r '$1' | \
      sort | \
      uniq -c | \
      sort --reverse | \
      column
  }
  # end Show Tags }}}

  local SHOWTYPESRX='^(\w+)@\w+--.+'
  local SHOWPROJECTSRX='^\w+@(\w+)--.+'
  local CMD="$FINDPRG --max-depth 1 --extension $NOTESFORMAT"
  local TYPE='\w+'
  local PROJECT='(\w+)?'

  while [[ "$1" =~ - && ! "$1" == "--" ]]; do
    case "$1" in
      --help | -h )
        echo "find: find files matching a specific type or project."
        echo "--type -t: find files matching the specified type."
        echo "--project -p: find files matching the specified project."
        echo "--edit -e: edit matching files with $EDITOR."
        echo "--show-types: print types."
        echo "--show-projects: print projects."
        echo "All additional arguments are passed to $FINDPRG verbatim."
        return 0
        ;;
      --type | -t)
        shift
        local TYPEFLAG=1
        local TYPE="${1:l}" # lowercase
        ;;
      --project | -p)
        shift
        local PROJECTFLAG=1
        local PROJECT="${1:l}" # lowercase
        ;;
      --edit | -e)
        local EDITFLAG=1
        ;;
      --show-types)
        __show_tags $SHOWTYPESRX
        return 0
        ;;
      --show-projects)
        __show_tags $SHOWPROJECTSRX
        return 0
        ;;
      *)
        # NOTE: assume that we are done with our args and the rest are
        # to be passed to FINDPRG verbatim.
        break
    esac; shift
  done

  if [[ "$TYPEFLAG" || "$PROJECTFLAG" ]]; then
    local QUERYRX="^${TYPE}@${PROJECT}--[\w-]+"
    CMD="$CMD '$QUERYRX'"
  fi

  # pass any additional args
  [[ "$@" ]] && CMD="$CMD $@"

  # handle --edit flag
  [[ "$EDITFLAG" ]] && CMD="$CMD --exec-batch $EDITOR"

  eval $CMD
}
# end Find }}}

# New {{{
__new() {
  emulate -L zsh

  # Insert Type Template {{{
  __insert_type_template () {
    local TEMPLATEFILE="$TEMPLATEDIR/$TYPE"
    if [[ -e "$TEMPLATEFILE" ]]; then
      if [[ -x "$TEMPLATEFILE" ]]; then
        $TEMPLATEFILE $RESULT
      elif [[ -s "$TEMPLATEFILE" ]]; then
        cat $TEMPLATEFILE > $RESULT
      fi
    fi
  }
  # End Insert Type Template }}}

  # Insert Default Template {{{
  __insert_default_template () {
    echo "---" > $RESULT
    echo "title: $NAME" >> $RESULT
    echo "date: [$(date +'%Y-%m-%d')]" >> $RESULT
    echo "author: $AUTHOR" >> $RESULT
    echo "---" >> $RESULT
  }
  # End Insert Default Template }}}

  # Uuid {{{
  __uuid () {
    local UUID=$(uuidgen)
    UUID=${UUID:l} # lowercase
    UUID=${UUID: -12} # last 12 chars
    echo $UUID
  }
  # End Uuid }}}

  local TYPE='capture'
  local NAME=$(__uuid)

  while [[ "$1" =~ - && ! "$1" == "--" ]]; do
    case "$1" in
      --help | -h)
        echo "new: create a new note file."
        echo "--no-edit -x: just create the file, don't open it."
        echo "--type -t: specify the type, defaults to 'capture'."
        echo "--project -p: specify a project."
        echo "--name -n: specify the title, defaults to a 12 char uuid."
        return 0
        ;;
      --type | -t)
        shift
        TYPE=$1
        ;;
      --project | -p)
        shift
        local PROJECT="${1:l}" # lowercase
        ;;
      --name | -n )
        shift
        local NAME="$1"
        NAME=${NAME:l} # lowercase words
        NAME=${NAME// /-} # substitute spaces with hyphens
        ;;
      --no-edit | -x )
        local NOEDITFLAG=1
        ;;
      *)
        echo "Error: unknown option $1."
        return 1
        ;;
    esac; shift
  done

  # NOTE: we build the file name outside the while loop above because
  # the arguments may be passed in random order however we want to
  # construct the name in a specific order.
  local RESULT="$TYPE"
  [[ "$PROJECT" ]] && RESULT="$RESULT@$PROJECT"
  RESULT="$RESULT--$NAME.$NOTESFORMAT"

  if [[ ! -e "$RESULT" ]]; then
    echo "Info: $RESULT does not exist, creating file."
    touch $RESULT

    __insert_default_template
    __insert_type_template
  fi

  [[ ! "$NOEDITFLAG" ]] && __edit + $RESULT
}
# End New }}}

# Link {{{
__link() {
  emulate -L zsh

  # Backward Links {{{
  __backward_links() {
    emulate -L zsh

    echo "Info: backward links."
    $GREPPRG --max-depth 1 --files-with-matches --type $NOTESFORMAT "\($1\)" | \
      $GREPPRG --no-line-number --only-matching "^(.+)\.$NOTESFORMAT" -r '$1'
  }
  # }}}

  # Forward Links {{{
  __forward_links() {
    emulate -L zsh

    echo "Info: forward links."
    $GREPPRG '\((\d+-\d+-\d+--\w+--[\w-]+)\)' $1 --no-line-number \
      --only-matching --replace '$1'
  }
  # }}}

  while [[ "$1" =~ - && ! "$1" == "--" ]]; do
    case "$1" in
      --help | -h )
        echo "link: show links for note."
        echo "--forward -f: show notes that given note links to."
        echo "--backward -b: show notes which link to given note."
        echo "--unlinked -u: show unlinked notes."
        return 0
        ;;
      --forward | -f )
        shift
        local FORWARDFLAG=1
        ;;
      --backward | -b )
        shift
        local BACKWARDFLAG=1
        ;;
      *)
        local NAME=${1:t:r} # file name without extension and absolute path
        break
        ;;
    esac
  done

  if [[ -z "$1" || ! -e "$1" ]]; then
    echo "Error: no or unexisting file specified."
    return 1
  fi

  if [[ -n "$FORWARDFLAG" ]]; then
    __forward_links $1
  elif [[ -n "$BACKWARDFLAG" ]]; then
    __backward_links $NAME
  else
    __forward_links $1
    __backward_links $NAME
  fi
}
# }}}

# Standup {{{
__standup() {
  emulate -L zsh

  local CAPTUREGLOB="capture@*.$NOTESFORMAT"
  local PERIOD='1w'

  [[ "$1" ]] && PERIOD=$1

  echo "Info: showing notes changed within $PERIOD."
  $FINDPRG --max-depth 1 --changed-within $PERIOD --extension $NOTESFORMAT \
    --exclude $CAPTUREGLOB
}
# }}}

# Edit {{{
__edit() {
  emulate -L zsh

  $EDITOR $@
}
# }}}

# Main {{{
if [[ "$PWD" != "$NOTESDIR" ]]; then
  pushd $NOTESDIR
  local PUSHDFLAG=1
fi

if [[ "$#" -eq 0 ]]; then
  __agenda
else
  case "$1" in
    help)
      echo "z: knowledge management using standard unix tools."
      echo "grep: $GREPPRG wrapper for notes files. See z grep --help for more info."
      echo "find: $FINDPRG for notes files. See z find --help for more info."
      echo "new: create new note file. See z new --help for more info."
      echo "link: show links for note. See z link --help for more info."
      echo "agenda: pretty print markdown headers. See z agenda --help for more info."
      echo "standup: show latest modified notes."
      echo "cd: change current directory to $NOTESDIR."
      echo "mv: mv wrapper for notes files."
      echo "cat: $CATPRG wrapper for notes files."
      return 0
      ;;
    grep | rg | g)
      __grep "${@:2}"
      ;;
    find | fd | f)
      __find "${@:2}"
      ;;
    new | n)
      __new "${@:2}"
      ;;
    cd)
      return 0 # already in NOTESDIR
      ;;
    mv)
      mv "${@:2}"
      ;;
    cat)
      $CATPRG "${@:2}"
      ;;
    rm | mv)
      rm "${@:2}"
      ;;
    link | l)
      __link "${@:2}"
      ;;
    standup | stand | s)
      __standup "${@:2}"
      ;;
    agenda | age | a)
      __agenda "${@:2}"
      ;;
    *)
      __edit "$@"
      ;;
  esac
fi

if [[ "$PUSHDFLAG" ]]; then
  popd
fi
# }}}
```

And here are the accompanying capture templates.

``` shell
# idea,todo,capture
#!/usr/bin/env zsh

[[ -z "$1" ]] && return
echo >> $1
echo "# [$(date +'%Y-%m-%d %a %H:%M')]" >> $1

# paper
#!/usr/bin/env zsh

[[ -z "$1" ]] && return
echo >> $1
echo '# Problem Statement' >> $1
echo >> $1
echo '# Solution' >> $1
echo >> $1
echo '# Results' >> $1
echo >> $1
echo '# Limitations' >> $1
echo >> $1
echo '# Remarks' >> $1
echo >> $1
echo '```bibtex' >> $1
local BIBKEY=$(pbpaste | rg '^@\w+\{([\w\d]+),' -r '$1')
if [[ -n "$BIBKEY" ]]; then
  pbpaste | sed '/^$/d' >> $1 # remove empty lines
  echo $BIBKEY | pbcopy
fi
echo '```' >> $1
```

# Vim blur window
Following are the configuration I used earlier to distinguish between
the focused & unfocused windows. The following are autoloaded functions.

``` vimscript
function! aru#blur_window() abort
  setlocal nocursorline
endfunction

function! aru#focus_window() abort
  setlocal cursorline
endfunction
```

And the following autocmd needs to be placed somewhere in the plugin/
directory.

``` vimscript
autocmd BufWinEnter,BufEnter,FocusGained,VimEnter,WinEnter * call aru#focus_window()
autocmd FocusLost,WinLeave * call aru#blur_window()
```

# Zsh scheme script
This is the script I stole from wincent/wincent to change the
base16-shell colorscheme from the command-line.

``` shell
# vim:filetype=zsh
# switch to specifid theme or else a default dark theme.

# Takes a hex color in the form of "RRGGBB" and outputs its luma (0-255, where
# 0 is black and 255 is white).
#
# Based on: https://github.com/lencioni/dotfiles/blob/b1632a04/.shells/colors
__luma() {
    emulate -L zsh

    local COLOR_HEX=$1

    if [ -z "$COLOR_HEX" ]; then
    echo "Missing argument hex color (RRGGBB)"
    return 1
    fi

    # Extract hex channels from background color (RRGGBB).
    local COLOR_HEX_RED=$(echo "$COLOR_HEX" | cut -c 1-2)
    local COLOR_HEX_GREEN=$(echo "$COLOR_HEX" | cut -c 3-4)
    local COLOR_HEX_BLUE=$(echo "$COLOR_HEX" | cut -c 5-6)

    # Convert hex colors to decimal.
    local COLOR_DEC_RED=$((16#$COLOR_HEX_RED))
    local COLOR_DEC_GREEN=$((16#$COLOR_HEX_GREEN))
    local COLOR_DEC_BLUE=$((16#$COLOR_HEX_BLUE))

    # Calculate perceived brightness of background per ITU-R BT.709
    # https://en.wikipedia.org/wiki/Rec._709#Luma_coefficients
    # http://stackoverflow.com/a/12043228/18986
    local COLOR_LUMA_RED=$((0.2126 * $COLOR_DEC_RED))
    local COLOR_LUMA_GREEN=$((0.7152 * $COLOR_DEC_GREEN))
    local COLOR_LUMA_BLUE=$((0.0722 * $COLOR_DEC_BLUE))

    local COLOR_LUMA=$(($COLOR_LUMA_RED + $COLOR_LUMA_GREEN + $COLOR_LUMA_BLUE))

    echo "$COLOR_LUMA"
}

__scheme() {
    emulate -L zsh

    local SCHEME="base16-$1"
    local SCRIPT="$BASE/$SCHEME.sh"

    if [[ -e "$SCRIPT" ]]; then
    local BG=$(grep color_background= "$SCRIPT" | cut -d \" -f2 | sed -e 's#/##g')
    local LUMA=$(__luma "$BG")
    local LIGHT=$((LUMA > 127.5))
    local BACKGROUND=dark
    if [ "$LIGHT" -eq 1 ]; then
        BACKGROUND=light
    fi

    [[ -d "$XDG_DATA_HOME/base16" ]] || mkdir -p "$XDG_DATA_HOME/base16"
    ln -sf $SCRIPT $XDG_DATA_HOME/base16/current-theme.sh
    # let vim know what theme to use
    echo -e "$SCHEME\n$BACKGROUND" >  "$HOME/.vim/.background"
    # finally, set the theme
    sh "$XDG_DATA_HOME/base16/current-theme.sh"
    else
    echo "Scheme $SCRIPT does not exist."
    return 1
    fi
}

local BASE="$ZDOTDIR/base16-shell/scripts"

case "$1" in
    ls)
    find "$BASE" -name 'base16-*.sh' | \
        sed -E 's|.+/base16-||' | \
        sed -E 's/\.sh//' | \
        column
    ;;
    *)
    __scheme "$1"
    ;;
esac
```

And following is the completion.

``` shell
#compdef scheme

_values 'schemes' $(scheme ls) ls
```
