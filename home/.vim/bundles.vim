if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if !exists('g:bundle_dir') | let g:bundle_dir =  expand('$HOME/.vim/bundle') | endif
if isdirectory(g:bundle_dir)
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

    Plug 'w0rp/ale'
    Plug 'wellle/targets.vim'
    Plug 'Townk/vim-autoclose'

    Plug 'junegunn/vim-easy-align'
    Plug 'junegunn/vim-peekaboo'

    Plug 'janko-m/vim-test'

    " Tmux {{{
    Plug 'tmux-plugins/vim-tmux'
    Plug 'tmux-plugins/vim-tmux-focus-events'
    Plug 'christoomey/vim-tmux-navigator'
    " }}}

    " JavaScript & TypeScript {{{
    Plug 'moll/vim-node'
    Plug 'leafgarland/typescript-vim'
    Plug 'Quramy/tsuquyomi'
    Plug 'Quramy/vim-js-pretty-template'
    Plug 'jason0x43/vim-js-indent'
    Plug 'Valloric/YouCompleteMe'
    " }}}

    set rtp+=/usr/local/opt/fzf
    Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'

    Plug 'chriskempson/base16-vim'
  call plug#end()
endif
