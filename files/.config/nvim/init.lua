pcall(function() vim.loader.enable() end)

-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })

-- Use 'mini.deps'. `now()` and `later()` are helpers for a safe two-stage
-- startup and are optional.
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  require('mini.basics').setup({
    options = {
      basic = true, -- default
      extra_ui = true,
      win_borders = 'double',
    },
    mappings = {
      basic = true, -- default
      windows = true,
      move_with_alt = true,
    }
  })

  vim.keymap.del({ 'n', 'v', 'i' }, '<C-s>') -- remove since it conflicts with tmux leader
end)

now(function() require('mini.icons').setup() end)
now(function() require('mini.indentscope').setup() end)
now(function() require('mini.statusline').setup() end)
now(function() require('mini.tabline').setup() end)
now(function() require('mini.trailspace').setup() end)

now(function()
  local hipatterns = require('mini.hipatterns')
  hipatterns.setup({
    highlighters = {
      -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
      fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
      hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
      todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
      note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

      -- Highlight hex color strings (`#rrggbb`) using that color
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })
end)

later(function() require('mini.bracketed').setup() end)
later(function() require('mini.notify').setup() end)
later(function() require('mini.surround').setup() end)
-- NOTE: builtin from version 0.10
-- later(function() require('mini.comment').setup() end)

later(function()
  require('mini.completion').setup({
    lsp_completion = {
      source_func = 'omnifunc',
      auto_setup = false,
      process_items = function(items, base)
        -- NOTE: don't show 'Text' and 'Snippet' suggestions
        items = vim.tbl_filter(function(x) return x.kind ~= 1 and x.kind ~= 15 end, items)
        return MiniCompletion.default_process_items(items, base)
      end,
    },
    window = {
      info = { border = 'double' },
      signature = { border = 'double' },
    }
  })
end)

later(function()
  require('mini.misc').setup()
  vim.keymap.set('n', '<leader>z', function() MiniMisc.zoom() end)
end)

later(function()
  add('williamboman/mason.nvim')
  -- TODO: figure out how to auto install stuff
  require('mason').setup()
end)

-- TODO: setup formatting using conform (it didn't work too well in the past for me)

later(function()
  add('neovim/nvim-lspconfig')
  local lspconfig = require('lspconfig')
  local on_attach_custom = function(client, buf_id)
    vim.bo[buf_id].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
  end

  local diagnostic_opts = {
    float = { border = 'double' },
    signs = {
      priority = 9999, -- highest priority
      severity = { min = 'WARN', max = 'ERROR' },
    },
    virtual_text = {
      severity = { min = 'ERROR', max = 'ERROR' },
    },
    update_in_insert = false,
  }
  vim.diagnostic.config(diagnostic_opts)

  -- better diagnostics signs (taken from wincent)
  local signs = { Error = "✖", Warn = "⚠", Hint = "➤", Info = "ℹ" }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  lspconfig.texlab.setup({
    on_attach = on_attach_custom,
    settings = {
      texlab = {
        bibtexFormatter = nil, -- I do this manually using bib-tool
        build = {
          -- TODO: put safety check on tectonic
          executable = 'tectonic',
          onSave = true,
          args = {
            '%f',
            '--synctex',
            '--keep-logs',
            '--keep-intermediates'
          }
        }
      }
    }
  })

  lspconfig.ltex.setup({
    on_attach = on_attach_custom,
    settings = {
      ltex = {
        language = 'en-GB',
        checkFrequency = 'save',
      }
    }
  })
end)
