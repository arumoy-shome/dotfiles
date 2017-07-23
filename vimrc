call plug#begin('~/.vim/bundle')

Plug 'Raimondi/delimitMate'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
Plug 'avh4/elm-format', { 'for': 'elm' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
Plug 'ecomba/vim-ruby-refactoring', { 'for': 'ruby' }
Plug 'elmcast/elm-vim', { 'for': 'elm' }
Plug 'godlygeek/tabular', { 'for': 'markdown' }
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'janko-m/vim-test'
Plug 'kien/ctrlp.vim'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'pbrisbin/vim-mkdir'
Plug 'scrooloose/syntastic'
Plug 'sirver/ultisnips'
Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise', { 'for': ['ruby', 'vimscript'] } 
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-liquid', { 'for': 'html' }
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails', { 'for': ['ruby', 'html', 'javascript', 'scss'] }
Plug 'tpope/vim-rake', { 'for': ['ruby'] }
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'vim-scripts/summerfruit.vim'
Plug 'w0ng/vim-hybrid'

call plug#end()

" call s:SourceConfigFilesIn('plugin')
let mapleader = " "

" vim-hybrid
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
