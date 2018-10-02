if executable('ag')
  set grepprg=ag\ --nogroup
endif

" bind L to grep word under cursor
nnoremap L :grep! "\b<C-R><C-W>\b"<cr>:cw<cr>
