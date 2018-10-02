" vim:foldmethod=marker:foldenable
"
" $HOME/.vimrc
" Jeffrey R. Horn <jeff@jrhorn.me>

source $HOME/.vim/before.vim
source $HOME/.vim/defaults.vim
source $HOME/.vim/cursor.vim
source $HOME/.vim/wildmenu.vim
source $HOME/.vim/grep.vim
source $HOME/.vim/pronoia.vim

" Turn on per-project vimrc files, but disable unsafe commands in them
set exrc
set secure

source $HOME/.vim/bundles.vim

" Plugin settings {{{
if !exists('g:bundle_dir') | let g:bundle_dir =  expand('$HOME/.vim/bundle') | endif
if isdirectory(g:bundle_dir)

  augroup trailertrash
    autocmd!
    autocmd BufWritePre * if index(['markdown', 'vim', 'diff', 'git', 'txt'], &ft) < 0 | :TrailerTrim
  augroup END

  " Fuzzy {{{
  " Finders
  " nnoremap <Leader>t :Files<CR>
  nnoremap <Leader>t :GFiles<CR>
  " nnoremap <Leader>p :Files<CR>
  nnoremap <Leader>b :Buffers<CR>
  nnoremap <Leader>] :Tags<CR>

  " Mapping selecting mappings
  nmap <leader><tab> <plug>(fzf-maps-n)
  xmap <leader><tab> <plug>(fzf-maps-x)
  omap <leader><tab> <plug>(fzf-maps-o)

  " Insert mode completion
  imap <c-x><c-k> <plug>(fzf-complete-word)
  imap <c-x><c-f> <plug>(fzf-complete-path)
  imap <c-x><c-j> <plug>(fzf-complete-file-ag)
  imap <c-x><c-l> <plug>(fzf-complete-line)

  " Advanced customization using autoload functions
  inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})
  " }}}

  " EasyAlign {{{
  " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
  vmap <Enter> <Plug>(EasyAlign)

  " Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
  nmap <Leader>a <Plug>(EasyAlign)
  " }}}
endif


" Shortcuts {{{
nmap <leader>i mmgg=G`m<cr>

" buffer nav
nmap <leader>d :bp<bar>sp<bar>bn<bar>bd<cr>

" Map <leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <leader>ff [I:let nr = input("Which one: ")<bar>exe "normal " . nr ."[\t"<cr>
" }}}

" Folding {{{
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
" }}}

" }}}

source $HOME/.vim/status.vim

" Postamble {{{
set autoindent
set smartindent
filetype plugin indent on

if has("termguicolors") && exists('$TMUX') == 0 
  let base16colorspace=256
  set termguicolors
endif

if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
endif

set background=dark
syntax on
" }}}

source $HOME/.vim/after.vim
