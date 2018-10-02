if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
  " Basics {{{
  Plug 'tpope/vim-sensible'
  Plug 'sheerun/vim-polyglot'
  Plug 'editorconfig/editorconfig-vim'
  " }}}

  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-git'
  Plug 'tpope/vim-markdown'

  Plug 'csexton/trailertrash.vim'
  Plug 'wellle/targets.vim'
  Plug 'Townk/vim-autoclose'

  Plug 'junegunn/vim-easy-align'
  Plug 'junegunn/vim-peekaboo'

  " Tmux {{{
  Plug 'tmux-plugins/vim-tmux'
  Plug 'tmux-plugins/vim-tmux-focus-events'
  Plug 'christoomey/vim-tmux-navigator'
  " }}}

  set rtp+=/usr/local/opt/fzf
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'

  Plug 'chriskempson/base16-vim'
call plug#end()

