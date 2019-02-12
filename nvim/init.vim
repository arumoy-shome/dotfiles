" we only need to explicitly mention the after dir here, the rest are
" automatically loaded by vim. see :h runtimepath.
set runtimepath^=~/.vim
runtimepath+=~/.vim/after

let &packpath = &runtimepath

source ~/.vim/vimrc
