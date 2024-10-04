-- vim: foldmethod=marker

-- settings {{{
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.opt.belloff = "all"
vim.opt.shortmess = vim.opt.shortmess + "A"
vim.opt.shortmess = vim.opt.shortmess + "I"
vim.opt.shortmess = vim.opt.shortmess + "O"
vim.opt.shortmess = vim.opt.shortmess + "T"
vim.opt.shortmess = vim.opt.shortmess + "W"
vim.opt.shortmess = vim.opt.shortmess + "a"
vim.opt.shortmess = vim.opt.shortmess + "c"
vim.opt.shortmess = vim.opt.shortmess + "o"
vim.opt.shortmess = vim.opt.shortmess + "s"
vim.opt.shortmess = vim.opt.shortmess + "t"
vim.opt.backspace = "indent,start,eol"
vim.opt.clipboard = vim.opt.clipboard + "unnamedplus"
vim.opt.autoindent = true
vim.opt.autowrite = true
vim.opt.autoread = true
vim.opt.backupcopy = "yes"
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
vim.opt.switchbuf = "usetab"
vim.opt.wildmenu = true
vim.opt.wildoptions = "pum"
vim.opt.wildmode = "longest:full,full"
vim.opt.fillchars = {
  diff = "∙", -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
  eob = " ", -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
  fold = "·", -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
  vert = "┃", -- BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
}
vim.opt.foldlevelstart = 99
vim.opt.linebreak = true
vim.opt.breakindent = false
vim.opt.smarttab = true
vim.opt.formatoptions = vim.opt.formatoptions + "n"
vim.opt.formatoptions = vim.opt.formatoptions + "1"
vim.opt.formatoptions = vim.opt.formatoptions + "j"
vim.opt.formatoptions = vim.opt.formatoptions + "p"
vim.opt.modelineexpr = true
vim.opt.concealcursor = vim.opt.concealcursor + "i"
vim.opt.concealcursor = vim.opt.concealcursor + "n"
vim.opt.concealcursor = vim.opt.concealcursor + "c"
vim.opt.cursorline = false
vim.opt.ruler = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.infercase = true
-- vim.opt.textwidth = 70   -- hardwrap sentences at given length
-- vim.opt.expandtab = true -- use spaces to indent (not tabs)
-- vim.opt.tabstop = 2      -- width of a tab
-- vim.opt.shiftwidth = 2   -- width when shifting text
vim.opt.spellfile = "~/.vim/spell/en.utf-8.add"
vim.opt.spelllang = "en_gb,nl"
vim.opt.mouse = "a"
vim.opt.completeopt = vim.opt.completeopt + "menu"
vim.opt.completeopt = vim.opt.completeopt + "menuone"
vim.opt.completeopt = vim.opt.completeopt + "noselect"
vim.opt.completeopt = vim.opt.completeopt + "popup"
vim.opt.list = false
vim.opt.listchars = {
  nbsp = "⦸",
  extends = "»",
  precedes = "«",
  tab = "▷⋯",
  trail = "•",
  space = "·",
}
vim.wo.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true
vim.g.markdown_folding = true

-- UI tweaks
vim.opt.pumblend = 10
vim.opt.pumheight = 10
vim.opt.winblend = 10
vim.opt.guifont = "SauceCodePro Nerd Font:h13"
vim.opt.termguicolors = true
-- vim.cmd.colorscheme("retrobox")
-- end settings }}}
-- keybindings {{{
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set("n", "<leader><tab>", "zA")

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Clear hlsearch with <esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
-- end keybindings }}}
-- lazy {{{1
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- which-key {{{2
  { -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    event = "VeryLazy", -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      vim.o.timeoutlen = 500
      require("which-key").setup()

      -- Document existing key chains
      require("which-key").add({
        { "<leader>c", group = "[C]ode" },
        { "<leader>d", group = "[D]ocument" },
        { "<leader>r", group = "[R]ename" },
        { "<leader>s", group = "[S]earch" },
        { "<leader>w", group = "[W]orkspace" },
      })
    end,
  },
  -- end which-key}}}
  -- devicons {{{2
  "nvim-tree/nvim-web-devicons",
  -- end devicons 2}}}
  -- telescope {{{2
  { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { -- If encountering errors, see telescope-fzf-native README for install instructions
        "nvim-telescope/telescope-fzf-native.nvim",

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = "make",

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      { "nvim-telescope/telescope-ui-select.nvim" },
    },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })

      -- Enable telescope extensions, if they are installed
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      -- See `:help telescope.builtin`
      local builtin = require("telescope.builtin")
    end,
    keys = {
      { "<leader>sf", "<cmd>Telescope find_files<cr>", "n", desc = "[S]earch [F]iles" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", "n", desc = "[S]earch [H]elp" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", "n", desc = "[S]earch [K]eymaps" },
      { "<leader>sw", "<cmd>Telescope grep_string<cr>", "n", desc = "[S]earch current [W]ord" },
      { "<leader>sg", "<cmd>Telescope live_grep<cr>", "n", desc = "[S]earch by [G]rep" },
      { "<leader><leader>", "<cmd>Telescope buffers<cr>", "n", desc = "[ ] Find existing buffers" },
      -- Slightly advanced example of overriding default behavior and theme
      {
        "<leader>/",
        function()
          -- You can pass additional configuration to telescope to change theme, layout, etc.
          require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        "n",
        desc = "[/] Fuzzily search in current buffer",
      },
    },
  },
  -- end telescope 2}}}
  -- nvim-lspconfig {{{2
  { -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      -- Brief Aside: **What is LSP?**
      --
      -- LSP is an acronym you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          -- NOTE: Remember that lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself
          -- many times.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-T>.
          map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

          -- Find references for the word under your cursor.
          map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

          -- Fuzzy find all the symbols in your current workspace
          --  Similar to document symbols, except searches over your whole project.
          map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

          -- Rename the variable under your cursor
          --  Most Language Servers support renaming across files, etc.
          map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap
          map("K", vim.lsp.buf.hover, "Hover Documentation")

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP Specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        pyright = {
          -- NOTE: fix lag in python files, taken from <https://youtu.be/hp7FFr9oM1k?si=f-mY0WCFr2CP3266&t=698>
          capabilities = {
            workspace = {
              didChangeWatchedFiles = {
                dynamicRegistration = false,
              },
            },
          },
        },
        typst_lsp = {},
        ruff_lsp = {},
        marksman = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        -- tsserver = {},
        --

        lua_ls = {
          -- cmd = {...},
          -- filetypes { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              workspace = {
                checkThirdParty = false,
                -- Tells lua_ls where to find all the Lua files that you have loaded
                -- for your neovim configuration.
                library = {
                  "${3rd}/luv/library",
                  unpack(vim.api.nvim_get_runtime_file("", true)),
                },
                -- If lua_ls is really slow on your computer, you can try this instead:
                -- library = { vim.env.VIMRUNTIME },
              },
              completion = {
                callSnippet = "Replace",
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
        texlab = {
          settings = {
            texlab = {
              bibtexFormatter = nil,
              build = {
                executable = "tectonic",
                onSave = true,
                args = {
                  "%f",
                  "--synctex",
                  "--keep-logs",
                  "--keep-intermediates",
                },
              },
            },
          },
        },
        ltex = {
          settings = {
            ltex = {
              language = "en-GB",
              checkFrequency = "save",
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu
      require("mason").setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua", -- Used to format lua code
        "black", -- Used to format Python code
        "latexindent", -- Used to format latex
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },
  -- end nvim-lspconfig}}}
  -- nvim-cmp {{{2
  { -- Autocompletion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        "L3MON4D3/LuaSnip",
        build = (function()
          -- Build Step is needed for regex support in snippets
          -- This step is not supported in many windows environments
          -- Remove the below condition to re-enable on windows
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
      },
      "saadparwaiz1/cmp_luasnip",

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",

      -- If you want to add a bunch of pre-configured snippets,
      --    you can use this plugin to help you. It even has snippets
      --    for various frameworks/libraries/etc. but you will have to
      --    set up the ones that are useful for you.
      -- 'rafamadriz/friendly-snippets',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      luasnip.config.setup({})

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = "menu,menuone,noinsert" },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert({
          -- Select the [n]ext item
          ["<C-n>"] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ["<C-p>"] = cmp.mapping.select_prev_item(),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ["<C-Space>"] = cmp.mapping.complete({}),

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          ["<C-h>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        },
      })
    end,
  },
  -- end nvim-cmp}}}
  -- tpope {{{2
  "tpope/vim-unimpaired",
  "tpope/vim-rsi",
  "tpope/vim-fugitive",
  "tpope/vim-eunuch",
  "tpope/vim-abolish",
  "tpope/vim-surround",
  -- end tpope 2}}}
  -- wincent {{{2
  "wincent/pinnacle",
  -- end wincent 2}}}
  -- nvim-treesitter {{{2
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    -- enabled = false,
    build = ":TSUpdate",
    config = function()
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "html",
          "latex",
          -- "bash",
          -- "c",
          -- "lua",
          -- "markdown",
          -- "markdown_inline",
          -- "vim",
          -- "vimdoc",
          -- "python",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  -- end nvim-treesitter 2}}}
  -- diagnostics {{{2
  {
    dir = "vim.diagnostics",
    config = function()
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
      vim.diagnostic.config({
        float = { border = "rounded" },
        -- only show signs, underline & virtual text for errors
        signs = { severity = vim.diagnostic.severity.ERROR },
        underline = { severity = vim.diagnostic.severity.ERROR },
        virtual_text = { severity = vim.diagnostic.severity.ERROR },
      })
      -- better diagnostics signs (taken from wincent)
      local signs = { Error = "✖", Warn = "⚠", Hint = "➤", Info = "ℹ" }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end,
  },
  --- end diagnostics 2}}}
  -- mini {{{2
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.notify").setup()
      require("mini.align").setup()
      require("mini.sessions").setup()
      require("mini.pairs").setup({
        modes = { insert = true, command = true, terminal = false },
        skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
        skip_ts = { "string" },
        skip_unbalanced = true,
        markdown = true,
      })
      require("mini.indentscope").setup()
      require("mini.diff").setup()
      require("mini.git").setup()
      require("mini.tabline").setup()
      require("mini.statusline").setup()
      require("mini.files").setup()
      vim.keymap.set("n", "<leader>b", function()
        if not MiniFiles.close() then
          MiniFiles.open()
        end
      end, { desc = "File Explorer" })
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
          done = { pattern = "%f[%w]()DONE()%f[%W]", group = "MiniHipatternsNote" },
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
  },
  -- end mini 2}}}
  -- vimtex {{{2
  {
    "lervag/vimtex",
    config = function()
      vim.g.vimtex_fold_enabled = 1
      vim.g.vimtex_quickfix_mode = 0 -- don't open/close qf automatically
      vim.g.vimtex_view_method = "sioyek"
    end,
  },
  -- end vimtex 2}}}
})
-- end lazy }}}
