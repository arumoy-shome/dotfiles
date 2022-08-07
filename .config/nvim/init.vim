set runtimepath^=~/.vim
set runtimepath+=~/.vim/after

let &packpath = &runtimepath

source ~/.vim/vimrc

call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'neovim/nvim-lspconfig'
call plug#end()

lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    sync_install = false,
    auto_install = true,
    highlight = {
	enable = true,
	additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
	enable = true,
    },
    indent = {
	enable = true,
    },
}
EOF
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" lua <<EOF
" require'lspconfig'.pyright.setup{}
" EOF
