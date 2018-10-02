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
source $HOME/.vim/status.vim

" Bundles & Their Configuration {{{
source $HOME/.vim/bundles.vim
source $HOME/.vim/trailertrash.vim
source $HOME/.vim/fuzzy.vim
source $HOME/.vim/align.vim
" }}}
"
source $HOME/.vim/after.vim

" Turn on per-project vimrc files, but disable unsafe commands in them
set exrc
set secure
