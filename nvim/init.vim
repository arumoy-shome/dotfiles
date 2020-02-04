" we only need to explicitly mention the after dir here, the rest are
" automatically loaded by vim. see :h runtimepath.
set runtimepath^=~/.vim
set runtimepath+=~/.vim/after
set runtimepath+=~/zettel

let &packpath = &runtimepath
let g:python3_host_prog = "/Users/aru/.vim/venv/bin/python"
let g:python_host_prog = "/Users/aru/.vim/venv2/bin/python"

source ~/.vim/vimrc
