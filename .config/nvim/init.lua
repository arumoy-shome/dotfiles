-- settings {{{
vim.opt.hlsearch = false
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
vim.opt.undofile = true
vim.opt.sidescrolloff = 3
vim.opt.scrolloff = 3
vim.opt.shiftround = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.switchbuf = 'usetab'
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
-- NOTE I now use editorconfig to set the following settings
-- automatically across all editors
-- vim.opt.textwidth = 70 -- hardwrap sentences at given length
-- vim.opt.expandtab = true -- use spaces to indent (not tabs)
-- vim.opt.tabstop = 2 -- width of a tab
-- vim.opt.shiftwidth = 2 -- width when shifting text
-- vim.opt.softtabstop = -1
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
vim.wo.signcolumn = 'yes'
-- end settings }}}

-- keybindings {{{
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.keymap.set('n', '<leader>so', ':source $MYVIMRC<cr>')
vim.keymap.set('n', '<leader><tab>', 'zA')

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- end keybindings }}}

-- packer {{{

-- install packer
-- local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
-- local is_bootstrap = false
-- if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
--   is_bootstrap = true
--   vim.fn.system {
--     'git',
--     'clone',
--     '--depth', '1',
--     'https://github.com/wbthomason/packer.nvim', install_path
--   }
--   vim.cmd [[packadd packer.nvim]]
-- end
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- Fuzzy Finder (files, lsp, etc)
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    cond = vim.fn.executable 'make' == 1,
  }
  -- use 'junegunn/fzf.vim'
  use { -- LSP config and plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      -- useful status updates for LSP
      'j-hui/fidget.nvim',
      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    }
  }
  -- DAP
  use 'mfussenegger/nvim-dap'
  use { -- autocompletion
    'hrsh7th/nvim-cmp',
    requires = {
      use 'hrsh7th/cmp-nvim-lsp',
      use 'hrsh7th/cmp-buffer',
      use 'hrsh7th/cmp-path',
      use 'hrsh7th/cmp-cmdline',
      use 'saadparwaiz1/cmp_luasnip',
      -- snippets
      use 'L3MON4D3/LuaSnip',
      use 'rafamadriz/friendly-snippets',
    }

  }
  use 'nvim-lualine/lualine.nvim'
  use 'RRethy/nvim-base16'
  use 'navarasu/onedark.nvim' -- Theme inspired by Atom
  use 'tpope/vim-fugitive'
  -- use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-rsi'
  use 'tpope/vim-commentary'
  use 'tpope/vim-apathy'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-surround'
  use 'tpope/vim-eunuch'
  -- use 'tpope/vim-sleuth'
  use 'gpanders/editorconfig.nvim'
  use 'tpope/vim-vinegar'
  use 'tpope/vim-dispatch'
  -- use 'lervag/vimtex'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'wincent/loupe'
  use 'folke/zen-mode.nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }
  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }
  use "fladson/vim-kitty"

  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  -- if is_bootstrap then
  --   require('packer').sync()
  -- end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
-- if is_bootstrap then
--   print '=================================='
--   print '    Plugins are being installed'
--   print '    Wait until Packer completes,'
--   print '       then restart nvim'
--   print '=================================='
--   return
-- end

-- Automatically source and re-compile packer whenever you save this init.lua
-- local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
-- vim.api.nvim_create_autocmd('BufWritePost', {
--   command = 'source <afile> | PackerCompile',
--   group = packer_group,
--   pattern = vim.fn.expand '$MYVIMRC',
-- })

-- end packer }}}

-- plugins {{{1
-- nvim-cmp {{{2
-- Set up nvim-cmp.

local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
-- End nvim-cmp 2}}}

-- luasnip {{{2
require("luasnip.loaders.from_vscode").lazy_load()
-- }}}

-- lualine {{{2
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'onedark',
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { { 'filename', path = 3 } }, -- relative path
    lualine_c = {},
  },
  tabline = {
    lualine_a = { 'branch' },
    lualine_b = { 'diff' },
    lualine_c = { 'diagnostics' },
    lualine_x = { 'hostname' },
    lualine_y = {},
    lualine_z = { 'tabs' },
  }
}
-- End lualine 2}}}

-- diagnostics {{{2
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
-- }}}

-- lsp {{{2
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},

  sumneko_lua = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- Turn on lsp status information
require('fidget').setup()
-- End lsp 2}}}

-- telescope {{{2
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = '[G]it [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- End telescope 2}}}

-- fzf {{{
-- vim.opt.rtp = vim.opt.rtp + "/usr/local/opt/fzf"
-- vim.keymap.set('n', '<leader>p', ":Files<cr>")
-- vim.keymap.set('n', '<leader>b', ":Buffers<cr>")
-- vim.keymap.set('n', '<leader>.', ":BTags<cr>")
-- vim.keymap.set('n', '<leader>l', ":Lines<cr>")
-- vim.keymap.set('n', '<leader>h', ":Helptags<cr>")
-- }}}

-- zen-mode {{{2
require("zen-mode").setup {}
-- End zen-mode 2}}}

-- treesitter {{{
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = {
    'c',
    'cpp',
    'go',
    'lua',
    'python',
    'rust',
    'typescript',
    'help',
    'latex'
  },

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- TODO treesitter folds dont work that well yet...
-- vim.api.nvim_create_autocmd({'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter'}, {
--  group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
--  callback = function()
--    vim.opt.foldmethod = 'expr'
--    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
--  end
-- })
-- end treesitter }}}
-- end plugins }}}

-- highlights {{{
-- vim.cmd.colorscheme('onedark')
require('onedark').setup {
  style = 'darker',
  toggle_style_key = '<leader>t',
  toggle_style_list = {'darker', 'light'}
}
require('onedark').load()
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
-- end highlights }}}

-- vim: foldmethod=marker
