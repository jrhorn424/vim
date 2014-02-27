set nocompatible
set encoding=utf-8
scriptencoding utf-8
nnoremap Q <nop>

inoremap <C-c> <Esc>
let mapleader = "\<space>"

set eol                         " include a newline at the end of files
set autoread                    " automatically re-read changed files from disk if no pending writes
set history=1000
set autoindent
set autowrite                   " automatically write a file when leaving a modified buffer
set showmode                    " Display the current mode
set linespace=0                 " No extra spaces between rows
set number                      " this, along with relative numbers, enables hybrid number mode
set relativenumber              " Use relative line numbers
set shortmess=aTItoO            " disable splash screen
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
set colorcolumn=80              " column border at 80 chars
set list listchars=tab:▸\ ,nbsp:×,trail:·,precedes:«,extends:»,eol:¬ " don't forget trailing whitespace after tab character

" Vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

set t_Co=256
set background=dark
Bundle 'altercation/vim-colors-solarized'
let g:solarized_termtrans = 1
colorscheme solarized

" don't highlight lines or columns, only highlight lines in insert mode
set nocursorline
set nocursorcolumn
au InsertEnter * setlocal cursorline
au InsertLeave * setlocal nocursorline

" Handle whitespace
set nowrap                      " don't wrap lines
set expandtab                   " soft tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set backspace=indent,eol,start  " backspace through everything in insert mode
" no whitespace at end of lines
Bundle 'csexton/trailertrash.vim'
autocmd BufWritePre * :Trim

" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
set showmatch

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

" Search
map <leader>h :nohlsearch<cr>

" Saner splits
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current

" Markdown
Bundle 'tpope/vim-markdown'
let g:markdown_fenced_languages = ['ruby', 'vim']
au BufRead,BufNewFile *.md set filetype=markdown

source $HOME/.vimrc.statusline
source $HOME/.vimrc.shortcuts
source $HOME/.vimrc.unite
source $HOME/.vimrc.completion
source $HOME/.vimrc.bundles
source $HOME/.vimrc.git
source $HOME/.vimrc.ruby
source $HOME/.vimrc.rails
source $HOME/.vimrc.paranoia

" put me last
syntax on

filetype on
filetype indent on
filetype plugin on
highlight clear SignColumn
