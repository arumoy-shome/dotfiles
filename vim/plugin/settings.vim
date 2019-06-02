filetype plugin indent on

set autowrite
set complete+=kspell
set diffopt+=vertical
set expandtab
set list
set listchars=nbsp:⦸
set listchars+=tab:▷┅
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=trail:•
set nobackup
set nocompatible
set nojoinspaces
set nonumber
set noswapfile
set nowritebackup
set numberwidth=5
set path +=**
set scrolloff=5
set shiftround
set shiftwidth=2
set showcmd
set spellfile=$HOME/.vim-spell-en.utf-8.add
set splitbelow
set splitright
set tabstop=2
set textwidth=80
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
set wildmode=list:longest,list:full
set wildmode=list:longest,list:full
set noshowmode
set clipboard=unnamed
set foldmethod=indent
set foldlevelstart=99
set termguicolors
set fillchars=vert:┃
set fillchars+=fold:·
set fillchars+=eob:\ 
set inccommand=nosplit
set linebreak
set smarttab
set cursorline
set foldtext=aru#autoloads#foldtext()
set history=50

let &showbreak='↳ '
let &l:colorcolumn='+' . join(range(0, 254), ',+')

language en_US
language messages en_US
