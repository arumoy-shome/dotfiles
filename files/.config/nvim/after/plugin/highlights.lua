local has_pinnacle, pinnacle = pcall(require, "wincent.pinnacle")
local group = vim.api.nvim_create_augroup("AruHighlights", { clear = true })

if has_pinnacle then
  -- change the highlights after loading the colorscheme
  vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
    group = group,
    pattern = "*",
    callback = function()
      pinnacle.set("DiagnosticError", pinnacle.italicize("DiagnosticError"))
      pinnacle.set("DiagnosticWarn", pinnacle.italicize("DiagnosticWarn"))
      pinnacle.set("DiagnosticHint", pinnacle.italicize("DiagnosticHint"))
      pinnacle.set("DiagnosticInfo", pinnacle.italicize("DiagnosticInfo"))

      -- pinnacle.set("Search", pinnacle.embolden("Underlined"))
      -- pinnacle.set("Comment", pinnacle.italicize("Comment"))
    end,
  })
end

vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
  group = group,
  pattern = '*',
  callback = function ()
    vim.cmd('highlight clear VertSplit')
  end
})

-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

vim.api.nvim_create_autocmd({ "FocusGained", "UIEnter"}, {
  group = group,
  pattern = "*",
  callback = function ()
    local config_file = vim.fn.expand('~/.local/share/yob/background')

    if vim.fn.filereadable(config_file) then
      local background = unpack(vim.fn.readfile(config_file, '', 1))

      if background == 'dark' or background == 'light' then
        vim.opt.background = background
      else
        echoerr('Bad background ' .. background .. ' in ' .. config_file)
      end

      -- reload the colorscheme (just to be safe)
      vim.cmd('colorscheme default')
    else -- default
      vim.opt.background = 'dark'
      vim.cmd('colorscheme default')
    end
  end
})
