augroup trailertrash
  autocmd!
  autocmd BufWritePre * if index(['markdown', 'vim', 'diff', 'git', 'txt'], &ft) < 0 | :TrailerTrim
augroup END
