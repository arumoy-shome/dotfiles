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
vim.opt.textwidth = 70 -- hardwrap sentences at given length
vim.opt.expandtab = true -- use spaces to indent (not tabs)
vim.opt.tabstop = 2 -- width of a tab
vim.opt.shiftwidth = 2 -- width when shifting text
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
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'",
  { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true })
-- end keybindings }}}

-- packer {{{
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- Fuzzy Finder (files, lsp, etc)
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    cond = vim.fn.executable 'make' == 1,
  }
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
      { 'glepnir/lspsaga.nvim', branch = 'main' },
    }
  }
  use {
    'mfussenegger/nvim-dap',
    requires = {
      'mfussenegger/nvim-dap-python'
    }
  }
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
  use 'RRethy/nvim-base16'
  use 'navarasu/onedark.nvim' -- Theme inspired by Atom
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rsi'
  use 'tpope/vim-commentary'
  use 'tpope/vim-apathy'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-surround'
  use 'tpope/vim-eunuch'
  use 'gpanders/editorconfig.nvim'
  use 'tpope/vim-vinegar'
  use 'tpope/vim-dispatch'
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
end)
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
require('lspsaga').init_lsp_saga({
  code_action_lightbulb = {
    enable = false,
    -- enable_in_insert = true,
    -- cache_code_action = true,
    -- sign = true,
    -- update_time = 150,
    -- sign_priority = 20,
    -- virtual_text = true,
  },
})
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
  nmap('gr', require('telescope.builtin').lsp_references,
    '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols
    , '[D]ocument [S]ymbols')
  nmap('<leader>ws',
    require('telescope.builtin').lsp_dynamic_workspace_symbols,
    '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  -- nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('K', '<cmd>Lspsaga hover_doc<CR>', 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder,
    '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder,
    '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- lspsaga
  -- vim.keymap.set("n", "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
  -- vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
  -- Diagnostic jump can use `<c-o>` to jump back
  vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>",
    { silent = true })
  vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>",
    { silent = true })
  -- Only jump to error
  vim.keymap.set("n", "[e", function()
    require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic
        .severity.ERROR })
  end, { silent = true })
  vim.keymap.set("n", "]e", function()
    require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic
        .severity.ERROR })
  end, { silent = true })

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

-- DAP {{{2
local dap = require("dap")
vim.keymap.set('n', '<F5>', function() dap.continue() end)
vim.keymap.set('n', '<F10>', function() dap.step_over() end)
vim.keymap.set('n', '<F11>', function() dap.step_into() end)
vim.keymap.set('n', '<F12>', function() dap.step_out() end)
vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<leader>B', function() dap.set_breakpoint() end)
vim.keymap.set('n', '<leader>dr', function() dap.repl.open() end)
vim.keymap.set('n', '<leader>dl', function() dap.run_last() end)
vim.keymap.set({'n', 'v'}, '<leader>dh', function()
  dap.hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  dap.preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)
require('dap-python').setup('~/.local/share/nvim/mason/packages/debugpy/venv/bin/python')
-- End DAP }}}

-- telescope {{{2
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    winblend = 10,
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
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')
vim.keymap.set('n', '<leader>?', function()
  builtin.oldfiles(themes.get_dropdown {
    previewer = false,
  })
end, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', function()
  builtin.buffers(
    themes.get_dropdown {
      previewer = false,
    })
end, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  builtin.current_buffer_fuzzy_find(themes.get_dropdown {
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', function()
  builtin.find_files(themes.get_dropdown {
    previewer = false,
  })
end, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>gf', function()
  builtin.git_files(themes.get_dropdown {
    previewer = false,
  })
end, { desc = '[G]it [F]iles' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags,
  { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string,
  { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep,
  { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics,
  { desc = '[S]earch [D]iagnostics' })

-- End telescope 2}}}

-- zen-mode {{{2
require("zen-mode").setup {}
-- End zen-mode 2}}}

-- treesitter {{{
-- See `:help nvim-treesitter`

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    revision = 'main',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  filetype = 'org',
}
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
    'latex',
    'org',
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
-- vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew',
--   'BufNewFile', 'BufWinEnter' }, {
--   group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
--   callback = function()
--     vim.opt.foldmethod = 'expr'
--     vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
--   end
-- })
-- end treesitter }}}

-- end plugins }}}

-- highlights {{{
-- minimal diagnostics icons
local signs = { Error = "!!", Warn = "!!", Hint = "!", Info = "!" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight',
  { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
-- end highlights }}}

-- vim: foldmethod=marker
