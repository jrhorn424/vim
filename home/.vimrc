set nocompatible
set encoding=utf-8

set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)

set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation
set autoindent
set number
set history=1000
set cursorline
if has("unnamedplus")
  set clipboard=unnamedplus
elseif has("clipboard")
  set clipboard=unnamed
endif

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces
set expandtab                   " use spaces, not tabs
set backspace=indent,eol,start  " backspace through everything in insert mode
filetype indent plugin on
set softtabstop=2

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
set showmatch
