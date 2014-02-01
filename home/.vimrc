set nocompatible
set encoding=utf-8
inoremap <C-c> <Esc>
let mapleader = "\<space>"
syntax on
filetype plugin indent on       " load file type plugins + indentation

"
" Vundle
"
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
"""

Bundle 'tpope/vim-eunuch'

set t_Co=256
set background=dark
Bundle 'altercation/vim-colors-solarized'
let g:solarized_termtrans = 1
colorscheme solarized

set autoindent
set history=1000
"set cursorline
"set cursorcolumn
set autowrite                   " automatically write a file when leaving a modified buffer
scriptencoding utf-8
set showmode                    " Display the current mode
set linespace=0                 " No extra spaces between rows
set relativenumber              " Use relative line numbers

"
" Handle whitespace
"
set nowrap                      " don't wrap lines
set expandtab                   " soft tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set backspace=indent,eol,start  " backspace through everything in insert mode

" indent guides and special characters
set list
set listchars=tab:\ \ ,trail:·,extends:»,precedes:«,nbsp:× " don't forget escaped trailing space

"
" Paranoia
"
set backup                  " Backups are nice ...
set backupdir=~/tmp,/tmp
set directory=~/tmp,/tmp

if has('persistent_undo')
  set undofile                " So is persistent undo ...
  set undolevels=1000         " Maximum number of changes that can be undone
  set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif

"
" Searching
"
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
set showmatch
"""

set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Adjust viewports to the same size
map <Leader>= <C-w>=

" Easier horizontal scrolling
map zl zL
map zh zH

Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-commentary'

set shortmess+=filmnrxoOtT      " Abbrev. of messages (avoids 'hit enter')
set showcmd                     " display incomplete commands

set virtualedit=onemore         " Allow for cursor beyond last character
set hidden                      " Allow buffer switching without saving
set tabpagemax=15               " Only show 15 tabs

set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set foldenable                  " Auto fold code

set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)

" close buffers by default instead of closing vim
:cnoreabbrev wq w<bar>bd
:cnoreabbrev q bd

"
" Vim shortcuts
" see more at https://github.com/r00k/dotfiles
"
map <Leader>x :exec getline(".")<cr>
map <Leader>r :source $MYVIMRC<cr>
map <Leader>ev :edit $MYVIMRC<cr>
map <Leader>ss :source %<cr>
map <Leader>i mmgg=G`m<cr>
map <Leader>p :set paste<cr>o<esc>"*]p:set nopaste<cr>

" Code folding options
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>

" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
map <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Search
map <leader>h :nohlsearch<cr>
map <silent> <leader>/ :set invhlsearch<CR>

"
" Vim utilities
"
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'jeetsukumaran/vim-buffergator'
Bundle 'scrooloose/nerdtree'

"
" Markdown
"
Bundle 'tpope/vim-markdown'
let g:markdown_fenced_languages = ['ruby', 'vim']
au BufRead,BufNewFile *.md set filetype=markdown

"
" Rails
"
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-bundler'

"
" Local configuration for pairing sessions
"
"so $HOME/.vimrc.local
"""
