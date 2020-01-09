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
" binding to open in split (<C-w><C-f>) is clunky and there is no option for
" opening in vertical split. I have not had a usecase for gF (same as gf but
" also jumps to a specific linenumber). So, we remap gf to open in split and gF
" to open in vertical split. The default <C-w>gf for opening in a new tab is
" fine since I rarely need it.
nnoremap gf <C-w>f
nnoremap gF <C-w>f<C-w>L
