-- use :close instead of :cclose, works for quickfix and location list
vim.keymap.set('n', 'q', ':close<cr>', { buffer = true })
vim.wo.number = false
vim.wo.relativenumber = false
