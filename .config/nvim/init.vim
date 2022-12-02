" {{{ settings
set hlsearch " highlight current search
set incsearch " highlight matches while searching
set laststatus=2          " always show statusline
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
set autoindent            " copy indent from previous line for new line
set autowrite             " auto write buffers when jumping
set autoread
set nobackup              " do not create root owned files
set nowritebackup         " do not create root owned files
set nojoinspaces          " insert one space when joining spaces
set noswapfile            " do not create root owned files
set sidescrolloff=3       " same as scrolloff, but for columns
set scrolloff=3           " start scrolling 3 lines before edge of viewport
set shiftround            " always indent by multiple of shiftwidth
set splitbelow            " horizontal splits open below
set splitright            " vertical splits open right
set switchbuf=usetab      " reuse windows/tabs when switching buffers
set textwidth=70          " hardwrap lines at 70 characters by default, override in ftplugin/
set wildmenu            " enhanced command line completion with <Tab>
set wildoptions=pum
set wildmode=longest:full " shell like autocomplete to unambiguous portion
set wildmode+=full
set fillchars=diff:∙    " BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
set fillchars+=fold:·   " MIDDLE DOT (U+00B7, UTF-8: C2 B7)
set foldlevelstart=99     " start unfolded, override per ft (or file using modeline)
set linebreak           " wrap long lines at characters in 'breakat'
set nobreakindent       " do not indent wrapped lines
set smarttab              " [default] <tab>/<bs> indent/dedent in leading whitespace
set formatoptions+=n      " options when formatting text
set formatoptions+=1
set formatoptions+=j
set formatoptions+=p
set modelineexpr          " allow expressions to be set in modeline
set concealcursor=i     " use `V` (linewise-visual) to see concealed characters
set concealcursor+=n
set concealcursor+=c
set ruler               " show line and column number
set ignorecase            " case insensitive search
set smartcase             " unless case present in search
set infercase             " adjust case during ins-completion
set noexpandtab             " use tabs
set tabstop=8             " [default]
set shiftwidth=4          " spaces per tab (when shifting)
set softtabstop=4        " use 'shiftwidth' for tab/bs at eol
set spellfile=~/.vim/spell/en.utf-8.add
set spelllang=en
set mouse=a
set completeopt=menu,menuone,noselect
" End settings }}}

" autocommands {{{
function! AruWindowAutocmds() abort
    " This function resizes all vim splits everytime the dimensions of
    " the terminal window changes. This is useful since I often bounce
    " my terminal window around. I do this using the VimResized
    " autocmd which fires the `wincmd =' command.
  augroup AruWindow
    autocmd!
    autocmd VimResized * wincmd =
  augroup END
endfunction
call AruWindowAutocmds()

function! AruHelptagsAutocmds() abort
    " This function generates helptags from all *.txt files under the
    " docs/ directories found in vim's runtimepath (:h rtp for
    " details). I do this using the VimEnter autocmd (:h VimEnter for
    " details) which fires the `helptags ALL' command.
    augroup AruHelptags
	autocmd!
	autocmd VimEnter * helptags ALL
    augroup END
endfunction
call AruHelptagsAutocmds()
" End autocommands }}}

" keybindings {{{
let mapleader = "\<Space>"
let maplocalleader="\\"
nnoremap <leader>so :source $MYVIMRC<CR>
" End keybindings }}}

" vim-plug {{{
call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'nvim-lualine/lualine.nvim'
Plug 'RRethy/nvim-base16'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-apathy'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-dispatch'
Plug 'lervag/vimtex'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'wincent/loupe'
Plug 'folke/zen-mode.nvim'
call plug#end()
" End vim-plug }}}

" plugins {{{1

" nvim-cmp {{{2
lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
EOF
" End nvim-cmp 2}}}

" nvim-treesitter 2{{{
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
" End nvim-treesitter 2}}}

" lualine 2{{{
lua <<EOF
require('lualine').setup {
  options = {
      icons_enabled = false,
      theme = 'ayu',
      component_separators = '',
      section_separators = '',
  },
  sections = {
      lualine_a = {'mode'},
      lualine_b = {'filename'},
      lualine_c = {},
  },
  tabline = {
    lualine_a = {'branch'},
    lualine_b = {'diff'},
    lualine_c = {'diagnostics'},
    lualine_x = {'hostname'},
    lualine_y = {},
    lualine_z = {'tabs'},
  }
}
EOF
" End lualine 2}}}

" lsp {{{2
lua <<EOF
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['pylsp'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}

require('lspconfig')['texlab'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}
EOF
" End lsp 2}}}

" telescope {{{2
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fd <cmd>Telescope fd<cr>
nnoremap <leader>fg <cmd>Telescope git_files<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>hh <cmd>Telescope help_tags<cr>
nnoremap <leader>hm <cmd>Telescope man_pages<cr>
nnoremap <leader>. <cmd>Telescope current_buffer_tags<cr>
" End telescope 2}}}

" zen-mode {{{2
lua << EOF
  require("zen-mode").setup{}
EOF
" End zen-mode 2}}}

" neovide {{{2
if exists("g:neovide")
    " Put anything you want to happen only in Neovide here
    let g:neovide_cursor_animation_length=0.01
endif
" End neovide 2}}}

" End plugins 1}}}

" highlights {{{
color base16-ayu-dark
hi clear VertSplit
" End highlights }}}

" vim: foldmethod=marker
