" settings
set laststatus=2          " always show statusline
set guioptions-=e         " disable gui tabline in favour of plain text version
if has ('textprop')
  set completeopt+=popup  " use popup instead of preview window
endif
set belloff=all           " do not ring the bell for any reason
set shortmess=A           " avoid all hit-enter prompts
set shortmess+=I
set shortmess+=O
set shortmess+=T
set shortmess+=W
set shortmess+=a
set shortmess+=c
set shortmess+=o
set shortmess+=s
set shortmess+=t
set backspace=indent      " allow backspacing over autoindent
set backspace+=start      " allow backspaceing over the start of insert
set backspace+=eol        " allow backspacing over line breaks
set clipboard+=unnamed    " always use the * register for yank/put/delete
set number                " show line number
set relativenumber        " show relative line number
set autoindent            " copy indent from previous line for new line
set autowrite             " auto write buffers when jumping
set list                  " show whitespace
set listchars=nbsp:⦸      " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
set listchars+=tab:▷┅     " WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
set listchars+=extends:»  " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=precedes:« " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:•    " BULLET (U+2022, UTF-8: E2 80 A2)
set nobackup              " do not create root owned files
set nowritebackup         " do not create root owned files
set nojoinspaces          " insert one space when joining spaces
set noswapfile            " do not create root owned files
set sidescrolloff=3       " same as scrolloff, but for columns
set scrolloff=3           " start scrolling 3 lines before edge of viewport
set shell=sh              " shell to use for `!`, `:!`, `system()` etc.
set shiftround            " always indent by multiple of shiftwidth
set splitbelow            " horizontal splits open below
set splitright            " vertical splits open right
set switchbuf=usetab      " reuse windows/tabs when switching buffers
set textwidth=78          " hardwrap lines at 78 characters by default, override in ftplugin/
set wildignore=*.o        " patterns to ignore while file navigation
set wildignore+=*.obj
set wildignore+=*.rbc
set wildignore+=*.pyc
set wildignore+=*/__pycache__/
set wildignore+=.git
set wildignore+=*/node_modules/*
set wildignore+=*/venv/*
if has('wildmenu')
  set wildmenu            " enhanced command line completion with <Tab>
endif
set wildmode=longest:full " shell like autocomplete to unambiguous portion
set wildmode+=full
if has('folding')
  set fillchars=diff:∙    " BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
  set fillchars+=fold:·   " MIDDLE DOT (U+00B7, UTF-8: C2 B7)
  set fillchars+=vert:┆   " from Yggdroot/indentLine
endif
set foldmethod=indent
set foldlevelstart=1      " start unfolded, override per ft (or file using modeline)
if has ('linebreak')
  set linebreak           " wrap long lines at characters in 'breakat'
  set nobreakindent       " do not indent wrapped lines
endif
set smarttab              " <tab>/<bs> indent/dedent in leading whitespace
set formatoptions+=n      " options when formatting text
set formatoptions+=1
set formatoptions+=j
set formatoptions+=p
set modelineexpr          " allow expressions to be set in modeline
if has('conceal')
  set concealcursor=i     " use `V` (linewise-visual) to see concealed characters
  set concealcursor+=n
  set concealcursor+=c
endif
if has('cmdline_info')
  set ruler               " show line and column number
endif
set tags+=./.git/tags     " read tags file inside .git directory
set ignorecase            " case insensitive search
set smartcase             " unless case present in search
set infercase             " adjust case during ins-completion
set path=.,**             " search relative to file, cwd and recursively
set cursorline            " highlight the current line
set spell

" indent by 2 spaces by default, later overriden by vim-sleuth
set expandtab      " use spaces instead of tabs
set tabstop=2      " spaces per tab
set shiftwidth=2   " spaces per tab (when shifting)
set softtabstop=-1 " use 'shiftwidth' for tab/bs at eol
