function! aru#plugins#abolish() abort
  call aru#plugin#packadd('vim-abolish', 'abolish.vim')

  Abolish aboud about
  Abolish ahve have
  Abolish funciton{,ed,s} function{}
  Abolish paramater parameter
  Abolish provied{,d,s} provide{}
  Abolish submodlue{,s} submodule{}
  Abolish {hte,teh} the
  Abolish updaet{,ed,es} update{}
  Abolish varient{,s} variant{}
  Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}
endfunction
