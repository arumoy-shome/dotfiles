---
title: Neovim config archive
---

Bits and pieces of neovim config that I don't use anymore but keep
around for reference.

# lualine.nvim
I used this plugin for the statusline and tabline but reverted back to
my minimal settings soon after. I noticed that the statusline provided
by the package does not play well when I fire autocmds on focus to
change the colorscheme.

```lua
use 'nvim-lualine/lualine.nvim'
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
```

# fzf
I switched to telescope.nvim.

```lua
-- fzf {{{
vim.opt.rtp = vim.opt.rtp + "/usr/local/opt/fzf"
vim.keymap.set('n', '<leader>p', ":Files<cr>")
vim.keymap.set('n', '<leader>b', ":Buffers<cr>")
vim.keymap.set('n', '<leader>.', ":BTags<cr>")
vim.keymap.set('n', '<leader>l', ":Lines<cr>")
vim.keymap.set('n', '<leader>h', ":Helptags<cr>")
-- }}}

```
