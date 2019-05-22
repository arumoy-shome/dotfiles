" we only need to explicitly mention the after dir here, the rest are
" automatically loaded by vim. see :h runtimepath.
set runtimepath^=~/.vim
set runtimepath+=~/.vim/after

let &packpath = &runtimepath
let g:python3_host_prog = "/Users/aru/.vim/venv/bin/python"

source ~/.vim/vimrc
