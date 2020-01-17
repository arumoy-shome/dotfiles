command! -nargs=* -complete=file Preview call aru#commands#preview(<f-args>)
command -nargs=? -complete=command SPlit call aru#commands#SPlit(<q-args>)
