" vim:foldmethod=marker:foldenable
"
" $HOME/.vimrc
" Jeffrey R. Horn <jeff@jrhorn.me>

source $HOME/.vim/before.vim

" Preamble {{{
set nocompatible
if &encoding
  set encoding=utf-8
  scriptencoding utf-8
endif

nnoremap Q <nop>
inoremap <C-c> <Esc>
let mapleader = "\<space>"
nnoremap ; :

" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

" Turn on per-project vimrc files, but disable unsafe commands in them
set exrc
set secure

set eol                         " include a newline at the end of files
set history=1000
set showmode                    " Display the current mode
set linespace=0                 " No extra spaces between rows
set number                      " this, along with relative numbers, enables hybrid number mode
set relativenumber              " Use relative line numbers
set shortmess=aTItoO            " disable splash screen
set shortmess+=filmnrxoOtT      " Abbrev. of messages (avoids 'hit enter')
set showcmd                     " display incomplete commands
set virtualedit=onemore         " Allow for cursor beyond last character
set tabpagemax=15               " Only show 15 tabs
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set backspace=indent,eol,start  " backspace through everything in insert mode
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set colorcolumn=80              " column border at 80 chars
set formatoptions+=ro           " autocomment new lines

set nohlsearch                  " do not highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
set showmatch

set nowrap                      " don't wrap lines
set expandtab                   " soft tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set list listchars=tab:▸\ ,nbsp:×,trail:·,precedes:«,extends:»,eol:¬ " don't forget trailing whitespace after tab character
set viewoptions=cursor,folds,slash,unix
set lazyredraw

set modeline
set modelines=5
" }}}

source $HOME/.vim/wildmenu.vim
source $HOME/.vim/cursor.vim

" Miscellaneous settings {{{
" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk
" Easier horizontal scrolling
map zl zL
map zh zH
" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$
" For when you forget to sudo, really write the file.
cmap w!! w !sudo tee % >/dev/null
" Saner splits
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
" }}}

source $HOME/.vim/grep.vim
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

" Pronoia {{{
set nohidden        " Do not allow buffer switching without saving
set nobackup        " Do not keep backups
set nowritebackup   " Do not use backups
set noswapfile      " Do not use swap files
set viminfo="NONE"  " Do not store buffer lists, global variables, marks, etc.

set autoread        " automatically re-read changed files from disk if no pending writes
set autowrite       " automatically write a file when leaving a modified buffer
set autowriteall    " automatically write a file when leaving vim
set timeout         " enable timeout feature for mappings
set ttimeout        " enable timeout feature for multi-key commands
set timeoutlen=500  " how long before timeout (in ms)
set updatetime=1000 " how long before CursorHold is triggered (in ms)

augroup save_auto
  autocmd!
  if has("gui_running")
    autocmd FocusLost * silent! wall
  endif
  autocmd BufLeave * silent! update
  " autocmd InsertLeave * silent! update
  " autocmd CursorHold * silent! update
augroup END

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " :help undo-persistence
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo/
  set undodir+=~/.vim/undo/
  set undofile
  if has('persistent_undo')
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
  endif
endif
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
