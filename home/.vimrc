set nocompatible
set encoding=utf-8
scriptencoding utf-8
nnoremap Q <nop>

inoremap <C-c> <Esc>
let mapleader = "\<space>"

source $HOME/.vimrc.pathogen
"=bundle tpope/vim-pathogen
"=bundle tpope/vim-eunuch
"=bundle tpope/vim-ragtag
"=bundle tpope/vim-surround
"=bundle tpope/vim-repeat
"=bundle tpope/vim-commentary
"=bundle tpope/vim-abolish
"=bundle tpope/vim-sensible
"=bundle csexton/trailertrash.vim
autocmd BufWritePre * :Trim
"=bundle christoomey/vim-tmux-navigator
"=bundle wesQ3/vim-windowswap
"=bundle scrooloose/nerdtree
nmap <Leader>e :NERDTreeToggle<CR>
"=bundle majutsushi/tagbar
nmap <Leader>t :TagbarToggle<CR>
"=bundle wellle/targets.vim
"=bundle terryma/vim-multiple-cursors
"=bundle junegunn/vim-easy-align
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
"=bundle msanders/snipmate.vim
"=bundle Townk/vim-autoclose
"=bundle Lokaltog/vim-easymotion
"=bundle scrooloose/syntastic
"=bundle vim-scripts/visualrepeat
"=bundle vim-scripts/ZoomWin
"=bundle altercation/vim-colors-solarized
"=bundle Shougo/vimproc.vim
"=bundle Shougo/unite.vim
"=bundle ervandew/supertab
"=bundle tpope/vim-fugitive
"=bundle airblade/vim-gitgutter
"=bundle vim-ruby/vim-ruby
"=bundle sunaku/vim-ruby-minitest
"=bundle tpope/vim-rails
"=bundle tpope/vim-bundler
"=bundle slim-template/vim-slim
"=bundle tpope/vim-rake
"=bundle tpope/vim-markdown

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
set backspace=indent,eol,start  " backspace through everything in insert mode
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set colorcolumn=80              " column border at 80 chars
" searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
set showmatch
map <leader>h :nohlsearch<cr>
" handle whitespace
set nowrap                      " don't wrap lines
set expandtab                   " soft tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set list listchars=tab:▸\ ,nbsp:×,trail:·,precedes:«,extends:»,eol:¬ " don't forget trailing whitespace after tab character
" don't highlight lines or columns, only highlight lines in insert mode
set nocursorline
set nocursorcolumn
au InsertEnter * setlocal cursorline
au InsertLeave * setlocal nocursorline

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk
" Easier horizontal scrolling
map zl zL
map zh zH
" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$
" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>
" For when you forget to sudo, really write the file.
cmap w!! w !sudo tee % >/dev/null

" Adjust viewports to the same size
map <leader>= <C-w>=
" Saner splits
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current

" ctags
set tags+=./tags

source $HOME/.vimrc.colors
source $HOME/.vimrc.statusline
source $HOME/.vimrc.shortcuts
source $HOME/.vimrc.paranoia
source $HOME/.vimrc.folding
source $HOME/.vimrc.unite
source $HOME/.vimrc.completion
source $HOME/.vimrc.markdown
