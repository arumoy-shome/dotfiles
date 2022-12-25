-- settings {{{
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.opt.belloff = 'all'
vim.opt.shortmess = vim.opt.shortmess + 'A'
vim.opt.shortmess = vim.opt.shortmess + 'I'
vim.opt.shortmess = vim.opt.shortmess + 'O'
vim.opt.shortmess = vim.opt.shortmess + 'T'
vim.opt.shortmess = vim.opt.shortmess + 'W'
vim.opt.shortmess = vim.opt.shortmess + 'a'
vim.opt.shortmess = vim.opt.shortmess + 'c'
vim.opt.shortmess = vim.opt.shortmess + 'o'
vim.opt.shortmess = vim.opt.shortmess + 's'
vim.opt.shortmess = vim.opt.shortmess + 't'
vim.opt.backspace = 'indent,start,eol'
vim.opt.clipboard = vim.opt.clipboard + 'unnamed'
vim.opt.autoindent = true
vim.opt.autowrite = true
vim.opt.autoread = true
vim.opt.backupcopy = 'yes'
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.joinspaces = false
vim.opt.swapfile = false
vim.opt.sidescrolloff = 3
vim.opt.scrolloff = 3
vim.opt.shiftround = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.switchbuf = 'usetab'
vim.opt.textwidth = 70
vim.opt.wildmenu = true
vim.opt.wildoptions = 'pum'
vim.opt.wildmode = 'longest:full,full'
vim.opt.fillchars = {
	diff = '∙', -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
	eob = ' ', -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
	fold = '·', -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
	vert = '┃', -- BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
}
vim.opt.foldlevelstart = 99
vim.opt.linebreak = true
vim.opt.breakindent = false
vim.opt.smarttab = true
vim.opt.formatoptions = vim.opt.formatoptions + 'n'
vim.opt.formatoptions = vim.opt.formatoptions + '1'
vim.opt.formatoptions = vim.opt.formatoptions + 'j'
vim.opt.formatoptions = vim.opt.formatoptions + 'p'
vim.opt.modelineexpr = true
vim.opt.concealcursor = vim.opt.concealcursor + 'i'
vim.opt.concealcursor = vim.opt.concealcursor + 'n'
vim.opt.concealcursor = vim.opt.concealcursor + 'c'
vim.opt.cursorline = true
vim.opt.ruler = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.infercase = true
vim.opt.expandtab = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = -1
vim.opt.termguicolors = true
vim.opt.spellfile = '~/.vim/spell/en.utf-8.add'
vim.opt.spelllang = 'en'
vim.opt.mouse = 'a'
vim.opt.completeopt = vim.opt.completeopt + 'menu'
vim.opt.completeopt = vim.opt.completeopt + 'menuone'
vim.opt.completeopt = vim.opt.completeopt + 'noselect'
vim.opt.list = true
vim.opt.listchars = {
	nbsp = '⦸',
	extends = '»',
	precedes = '«',
	tab = '▷⋯',
	trail = '•',
}
-- end settings }}}

-- keybindings {{{
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
-- FIXME this does not work
vim.keymap.set('n', '<leader>so', ':source $MYVIMRC<cr>')
-- end keybindings }}}

-- packer {{{
local use = require('package').use
require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	-- use {'nvim-telescope/telescope.nvim', tag = '0.1.0', requires
	-- = {{'nvim-lua/plenary.nvim'}}}
	use 'junegunn/fzf.vim'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'
	use 'nvim-lualine/lualine.nvim'
	use 'RRethy/nvim-base16'
	use 'tpope/vim-fugitive'
	use 'tpope/vim-rsi'
	use 'tpope/vim-commentary'
	use 'tpope/vim-apathy'
	use 'tpope/vim-unimpaired'
	use 'tpope/vim-surround'
	use 'tpope/vim-eunuch'
	use 'tpope/vim-sleuth'
	use 'tpope/vim-vinegar'
	use 'tpope/vim-dispatch'
	use 'lervag/vimtex'
	use 'lukas-reineke/indent-blankline.nvim'
	use 'wincent/loupe'
	use 'folke/zen-mode.nvim'
	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	}
end)
-- end packer }}}

-- plugins {{{1
-- nvim-cmp {{{2
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
-- End nvim-cmp 2}}}

-- lualine 2{{{
require('lualine').setup {
	options = {
		icons_enabled = false,
		theme = 'ayu',
		component_separators = '',
		section_separators = '',
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {{'filename', path = 3 }}, -- relative path
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
-- End lualine 2}}}

-- lsp {{{2
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
-- End lsp 2}}}

-- telescope {{{2
-- local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>fd', builtin.fd, {})
-- vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
-- vim.keymap.set('n', '<leader>fl', builtin.current_buffer_fuzzy_find, {})
-- vim.keymap.set('n', '<leader>b', builtin.buffers, {})
-- vim.keymap.set('n', '<leader>hh', builtin.help_tags, {})
-- vim.keymap.set('n', '<leader>hm', builtin.man_pages, {})
-- vim.keymap.set('n', '<leader>.', builtin.current_buffer_tags, {})
-- End telescope 2}}}

-- fzf {{{
vim.opt.rtp = vim.opt.rtp + "/usr/local/opt/fzf"
vim.keymap.set('n', '<leader>p', ":Files<cr>")
vim.keymap.set('n', '<leader>b', ":Buffers<cr>")
vim.keymap.set('n', '<leader>.', ":BTags<cr>")
vim.keymap.set('n', '<leader>l', ":Lines<cr>")
vim.keymap.set('n', '<leader>h', ":Helptags<cr>")
-- }}}

-- zen-mode {{{2
require("zen-mode").setup{}
-- End zen-mode 2}}}

-- treesitter {{{
require'nvim-treesitter.configs'.setup{
	ensure_installed = "all",
	highlight = {
		enable = true,
	},
}

vim.api.nvim_create_autocmd({'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter'}, {
	group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
	callback = function()
		vim.opt.foldmethod = 'expr'
		vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
	end
})
-- end treesitter }}}
-- end plugins }}}

-- highlights {{{
vim.cmd.colorscheme('lunaperche')
-- end highlights }}}

-- vim: foldmethod=marker
