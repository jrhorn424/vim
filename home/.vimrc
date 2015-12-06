" vim:foldmethod=marker:foldenable
"
" $HOME/.vimrc
" Jeffrey R. Horn <jeff@jrhorn.me>

set nocompatible
set encoding=utf-8
scriptencoding utf-8
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

" Wildmenu {{{
set wildmenu
set wildmode=list:longest
set wildmode=longest:full,full
set wildignore+=*~
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files
set wildignore+=vendor,tmp,log                   " Rails project cruft
set wildignore+=app/assets/images
set wildignore+=app/assets/fonts
" }}}

" Miscellaneous settings {{{
" don't highlight lines or columns, only highlight lines in insert mode
set nocursorline
set nocursorcolumn
augroup highlighting
  autocmd!
  autocmd InsertEnter * setlocal cursorline
  autocmd InsertLeave * setlocal nocursorline
augroup END
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

" Generic look {{{
set background=dark
highlight clear SignColumn
syntax enable
syntax sync minlines=256

" upon hitting escape to change modes,
" send successive move-left and move-right
" commands to immediately redraw the cursor
inoremap <special> <Esc> <Esc>jk

" don't blink the cursor
set guicursor+=i:blinkwait0

" tmux will only forward escape sequences to the terminal if surrounded by a DCS sequence
" http://sourceforge.net/mailarchive/forum.php?thread_name=AANLkTinkbdoZ8eNR1X2UobLTeww1jFrvfJxTMfKSq-L%2B%40mail.gmail.com&forum_name=tmux-users

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" }}}

" Help Navigation {{{
augroup helpnav
  autocmd!
  autocmd filetype help nnoremap <buffer><cr> <c-]>
  autocmd filetype help nnoremap <buffer><bs> <c-T>
  autocmd filetype help nnoremap <buffer>q :q<cr>
augroup END
" }}}

" Grep {{{
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  "let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  "let g:ctrlp_use_caching = 0
endif

" bind L to grep word under cursor
nnoremap L :grep! "\b<C-R><C-W>\b"<cr>:cw<cr>
" }}}

" Plugins {{{
call plug#begin('~/.vim/bundle')
" Editor {{{
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-speeddating'
Plug 'sheerun/vim-polyglot'
Plug 'csexton/trailertrash.vim'
Plug 'wellle/targets.vim'
Plug 'Townk/vim-autoclose'
Plug 'scrooloose/syntastic'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
" }}}

" Look {{{
Plug 'altercation/vim-colors-solarized'
" }}}
"
" System Integration {{{
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tyru/open-browser.vim'
set rtp+=/usr/local/opt/fzf " required by
Plug 'junegunn/fzf.vim'
" }}}
"
" Front-End {{{
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-jdaddy'
" }}}
"
" Ruby {{{
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rake'
Plug 'kana/vim-textobj-user' | Plug 'nelstrom/vim-textobj-rubyblock'
" }}}
"
" Rails {{{
Plug 'tpope/vim-rails'
" }}}
"
" Git {{{
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'mattn/webapi-vim' | Plug 'mattn/gist-vim'
" }}}
"
" Markdown {{{
Plug 'tpope/vim-markdown'
Plug 'jtratner/vim-flavored-markdown'
Plug 'amiorin/vim-fenced-code-blocks'
" }}}
call plug#end()
" }}}

" Plugin settings {{{
if !exists('g:bundle_dir') | let g:bundle_dir =  expand('$HOME/.vim/bundle') | endif
if isdirectory(g:bundle_dir)

  augroup trailertrash
    autocmd!
    autocmd BufWritePre * if index(['markdown', 'vim', 'diff', 'git', 'txt'], &ft) < 0 | :TrailerTrim
  augroup END

  " Clam {{{
  nnoremap ! :Clam<space>
  vnoremap ! :ClamVisual<space>
  " }}}

  " Git {{{
  cabbrev git Git
  nnoremap <leader>gb :Gblame<cr>
  nnoremap <leader>gd :Gdiff<cr>
  nnoremap <leader>gp :Git pull --rebase<cr><cr>
  nnoremap <leader>gr :Gremove<cr>
  nnoremap <leader>ga :Gwrite<cr>
  nnoremap <leader>gf :Git fetch<cr>
  nnoremap <leader>gs :Gstatus<cr>
  nnoremap <leader>gc :Gcommit<cr>
  nnoremap <leader>gu :Git push<cr>
  nnoremap <leader>gl :Git log --decorate --oneline --graph --all<cr>
  nnoremap <leader>g :Git<space>
  " }}}

  " Gist {{{
  let g:gist_clip_command = 'pbcopy'
  let g:gist_detect_filetype = 1
  let g:gist_open_browser_after_post = 0
  let g:gist_post_private = 1
  let g:gist_show_privates = 1
  " }}}

  " Fuzzy {{{
  " Finders
  nnoremap <Leader>p :Files<CR>
  nnoremap <Leader>t :GitFiles<CR>
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

  " surrounded {{{
  let g:surround_{char2nr('s')} = " \r"
  let g:surround_{char2nr(':')} = ":\r"
  let g:surround_indent = 1
  " }}}

  " EasyAlign {{{
  " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
  vmap <Enter> <Plug>(EasyAlign)

  " Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
  nmap <Leader>a <Plug>(EasyAlign)
  " }}}

  " Syntastic {{{
  let g:syntastic_javascript_checkers = ['jshint']
  let g:syntastic_html_tidy_exec = 'tidy5'
  let g:syntastic_html_tidy_ignore_errors = [ 'proprietary attribute "ng' ]
  " }}}

  " Colors {{{
  " Required for uxrvt and Terminal.app but conflicts with toggling
  " background.
  " let g:solarized_termtrans=1
  call togglebg#map("<F5>")

  if has('gui_running')
    set showtabline=2
    set background=light
  else
    set background=dark
  endif

  colorscheme solarized
  highlight clear SignColumn " must appear after colorscheme
  " }}}

  let g:ruby_indent_access_modifier_style = 'outdent'
endif

" This has to come after pathogen
set autoindent
set smartindent
filetype plugin indent on
" }}}

" Shortcuts {{{
nmap <leader>x :exec getline(".")<cr>
nmap <leader>ev :edit $MYVIMRC<cr>
nmap <leader>sv :source $MYVIMRC<cr>
nmap <leader>ss :source %<cr>
nmap <leader>i mmgg=G`m<cr>
" convert hashrockets to 1.9 syntax
nmap <leader>hr :%s/:\([^=,'"]*\) =>/\1:/gc"'<cr>
" convert end erb tags to -%>
nmap <leader>-% :%s/[^-]%>/ -%>/gc<cr>
" convert beginning erb tags to <%-
nmap <leader>%- :%s/<%[^-=]/<%-\ /gc<cr>

" buffer nav
nmap <leader>c :bp<bar>sp<bar>bn<bar>bd<cr>

" Map <leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <leader>ff [I:let nr = input("Which one: ")<bar>exe "normal " . nr ."[\t"<cr>
" }}}

" Completion {{{
" http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
" http://vim.wikia.com/wiki/Improve_completion_popup_menu
" http://robots.thoughtbot.com/vim-you-complete-me
set complete=.,b,u,]
set completeopt=longest,menuone " choose longest common match
set completefunc=syntaxcomplete#Complete
inoremap <expr> <C-cr> pumvisible() ? '<C-y>' : '<cr>'
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
      \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<cr>'
inoremap <expr> <C-p> pumvisible() ? '<C-p>' :
      \ '<C-p><C-r>=pumvisible() ? "\<lt>Up>" : ""<cr>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
      \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<cr>'

augroup omnicomplete_group
  autocmd!
  autocmd FileType css             setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown   setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType ghmarkdown      setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType txt             setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript      setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python          setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml             setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType ruby,eruby      set omnifunc=rubycomplete#Complete
  autocmd FileType ruby,eruby      let g:rubycomplete_buffer_loading=1
  autocmd FileType ruby,eruby      let g:rubycomplete_classes_in_global=1
  autocmd FileType ruby,eruby      let g:rubycomplete_rails=1
  autocmd FileType ruby,eruby      let g:rubycomplete_include_object = 1
  autocmd FileType ruby,eruby      let g:rubycomplete_include_objectspace = 1
augroup END
" }}}

" Folding {{{
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default

map <leader>fi :setlocal foldmethod=indent<cr>
map <leader>fs :setlocal foldmethod=syntax<cr>
nmap <leader>f0 :set foldlevel=0<cr>
nmap <leader>f1 :set foldlevel=1<cr>
nmap <leader>f2 :set foldlevel=2<cr>
nmap <leader>f3 :set foldlevel=3<cr>
nmap <leader>f4 :set foldlevel=4<cr>
nmap <leader>f5 :set foldlevel=5<cr>
nmap <leader>f6 :set foldlevel=6<cr>
nmap <leader>f7 :set foldlevel=7<cr>
nmap <leader>f8 :set foldlevel=8<cr>
nmap <leader>f9 :set foldlevel=9<cr>
" }}}

" Mail {{{
augroup mail
  autocmd!
  autocmd filetype mail setlocal nolist wrapmargin=0 textwidth=0 wrap linebreak
  autocmd bufnewfile,bufread *.muttrc set filetype=muttrc
augroup END
" }}}

" Ruby {{{
let g:ruby_path = $RUBY_ROOT
" }}}

" Markdown {{{
augroup markdown
  autocmd!
  autocmd BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn,txt} set filetype=ghmarkdown
  autocmd FileType markdown,ghmarkdown setlocal wrap linebreak nolist textwidth=0 wrapmargin=0 "comments+=b:-
augroup END
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
  autocmd FocusLost * silent! wall
  autocmd InsertLeave * silent! update
  autocmd BufLeave * silent! update
  autocmd CursorHold * silent! update
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

" Spelling {{{
set spelllang=en_us
augroup spelling_group
  autocmd!
  autocmd BufRead,BufNewFile *.md,*.txt setlocal spell
  autocmd FileType markdown,ghmarkdown,gitcommit,mail setlocal spell
augroup END
" }}}

" Whitespace settings for different filetypes {{{
augroup whitespace_group
  autocmd!
  autocmd FileType javascript,js                setlocal expandtab shiftwidth=2 softtabstop=2 isk+=$
  autocmd FileType coffee                       setlocal expandtab shiftwidth=2 softtabstop=2 isk+=$
  autocmd FileType html,xhtml,css,scss,scss.css setlocal expandtab shiftwidth=4 softtabstop=4 isk+=-
  autocmd FileType eruby,yaml,ruby              setlocal expandtab shiftwidth=2 softtabstop=2
  autocmd FileType cucumber                     setlocal expandtab shiftwidth=2 softtabstop=2
  autocmd FileType ruby                         setlocal textwidth=79 comments=:#\ 
  autocmd FileType vim                          setlocal expandtab shiftwidth=2 softtabstop=2 keywordprg=:help
  autocmd FileType python                       setlocal softtabstop=4 ts=4 shiftwidth=4 textwidth=79
  autocmd FileType c                            setlocal expandtab shiftwidth=2 softtabstop=2
  autocmd FileType objc,objcpp                  setlocal expandtab shiftwidth=4 softtabstop=4
augroup END
" }}}

source $HOME/.vim/status.vim
