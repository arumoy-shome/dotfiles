" Toggle fold at current position.
nnoremap <Tab> za

" Repurpose cursor keys (accessible near homerow via "SpaceFN" layout) for one
" of my most oft-use key sequences.
nnoremap <silent> <Up> :cprevious<CR>
nnoremap <silent> <Down> :cnext<CR>
nnoremap <silent> <Left> :cpfile<CR>
nnoremap <silent> <Right> :cnfile<CR>

nnoremap <silent> <S-Up> :lprevious<CR>
nnoremap <silent> <S-Down> :lnext<CR>
nnoremap <silent> <S-Left> :lpfile<CR>
nnoremap <silent> <S-Right> :lnfile<CR>

" When I use gf I almost always want it to open in a new split. Vim's built in
" binding to open in split (<C-w><C-f>) is clunky and there is no option for
" opening in vertical split. I have not had a usecase for gF (same as gf but
" also jumps to a specific linenumber). So, we remap gf to open in split and gF
" to open in vertical split. The default <C-w>gf for opening in a new tab is
" fine since I rarely need it.
nnoremap gf <C-w>f
nnoremap gF <C-w>f<C-w>L
