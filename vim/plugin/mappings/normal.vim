" Toggle fold at current position.
nnoremap <Tab> za

" Repurpose cursor keys (accessible near homerow via "SpaceFN" layout) for one
" of my most oft-use key sequences.
nnoremap <Up> :cprevious<CR>
nnoremap <Down> :cnext<CR>
nnoremap <Left> :cpfile<CR>
nnoremap <Right> :cnfile<CR>

nnoremap <S-Up> :lprevious<CR>
nnoremap <S-Down> :lnext<CR>
nnoremap <S-Left> :lpfile<CR>
nnoremap <S-Right> :lnfile<CR>

" When I use gf I almost always want it to open in a new split. Vim's built in
" binding to open in split (<C-w>f or <C-w><C-f>) is clunky and there is no
" option for opening in vertical split. gF is similar to gf but also jumps to
" the line number (if given) and similarly <C-w>F for opening in split and
" following line number. So, we remap gf to gF and gF to <C-w>F followed by
" vertical split. The default <C-w>gf and <C-w>gF for opening in a new tab is
" fine since I rarely need it.
nnoremap gf <C-w>F
nnoremap gF <C-w>F<C-w>L

" mappings for yanking filename or filename+linenum of current buffer, useful
" when linking notes and opening files using gf or gF.
nnoremap <silent> <expr> yf aru#mappings#normal#yank_filename()
nnoremap <silent> <expr> yF aru#mappings#normal#yank_filename_and_linenum()
