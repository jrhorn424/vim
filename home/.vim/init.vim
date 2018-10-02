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

" Bundles & Their Configuration {{{
source $HOME/.vim/bundles.vim

" Plugin settings {{{
  augroup trailertrash
    autocmd!
    autocmd BufWritePre * if index(['markdown', 'vim', 'diff', 'git', 'txt'], &ft) < 0 | :TrailerTrim
  augroup END


" Shortcuts {{{
nmap <leader>i mmgg=G`m<cr>

" buffer nav
nmap <leader>d :bp<bar>sp<bar>bn<bar>bd<cr>

" Map <leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <leader>ff [I:let nr = input("Which one: ")<bar>exe "normal " . nr ."[\t"<cr>
" }}}

source $HOME/.vim/fuzzy.vim
source $HOME/.vim/align.vim
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
