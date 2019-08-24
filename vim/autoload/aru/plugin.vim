function! aru#plugin#packadd(pack, plugin) abort
  if has('packages')
    execute 'packadd ' . a:pack
  else
    call s:infect(a:plugin)
  end
endfunction

function! s:infect(plugin) abort
  if !exists('g:loaded_pathogen')
    source $HOME/.vim/pack/bundle/opt/vim-pathogen/autoload/pathogen.vim
  endif
  call pathogen#infect('pack/bundle/opt/{}')
  execute 'runtime! plugin/' . a:plugin
endfunction
