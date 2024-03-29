local has_pinnacle, pinnacle = pcall(require, "wincent.pinnacle")

if has_pinnacle then
  -- change the highlights after loading the colorscheme
  vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
    group = vim.api.nvim_create_augroup("AruHighlights", { clear = true }),
    pattern = "*",
    callback = function()
      pinnacle.set("DiagnosticError", pinnacle.italicize("DiagnosticError"))
      pinnacle.set("DiagnosticWarn", pinnacle.italicize("DiagnosticWarn"))
      pinnacle.set("DiagnosticHint", pinnacle.italicize("DiagnosticHint"))
      pinnacle.set("DiagnosticInfo", pinnacle.italicize("DiagnosticInfo"))

      pinnacle.set("Search", pinnacle.embolden("Underlined"))
      pinnacle.set("Comment", pinnacle.italicize("Comment"))
    end,
  })
end
