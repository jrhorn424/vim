" $HOME/.vimrc
" Jeffrey R. Horn <jeff@jrhorn.me>
"
" These require pathogen. Use csexton/infect to install.
" Pathogen bundle manifest {{{
"=bundle tpope/vim-pathogen
"=bundle tpope/vim-unimpaired
"=bundle tpope/vim-eunuch
"=bundle tpope/vim-ragtag
"=bundle tpope/vim-surround
"=bundle tpope/vim-repeat
"=bundle tpope/vim-commentary
"=bundle tpope/vim-abolish
"=bundle tpope/vim-sensible
"=bundle tpope/vim-markdown
"=bundle tpope/vim-endwise
"=bundle tpope/vim-fugitive
"=bundle tpope/vim-dispatch
"=bundle ton/vim-bufsurf
"=bundle AndrewRadev/splitjoin.vim
"=bundle rking/ag.vim
"=bundle vim-scripts/taglist.vim
"=bundle airblade/vim-gitgutter
"=bundle csexton/trailertrash.vim
"=bundle christoomey/vim-tmux-navigator
"=bundle wesQ3/vim-windowswap
"=bundle scrooloose/nerdtree
"=bundle wellle/targets.vim
"=bundle terryma/vim-multiple-cursors
"=bundle junegunn/vim-easy-align
"=bundle msanders/snipmate.vim
"=bundle Townk/vim-autoclose
"=bundle Lokaltog/vim-easymotion
"=bundle scrooloose/syntastic
"=bundle vim-scripts/visualrepeat
"=bundle vim-scripts/ZoomWin
"=bundle altercation/vim-colors-solarized
"=bundle wincent/Command-T
"=bundle ervandew/supertab
"=bundle vim-scripts/AutoComplPop
"=bundle tpope/vim-rails
"=bundle tpope/vim-bundler
"=bundle tpope/vim-rake
"=bundle vim-ruby/vim-ruby
"=bundle sunaku/vim-ruby-minitest
"=bundle slim-template/vim-slim
"=bundle thoughtbot/vim-rspec
"=bundle kchmck/vim-coffee-script
"=bundle pangloss/vim-javascript
"=bundle tpope/vim-haml                 " for scss
"=bundle csexton/jslint.vim
"=bundle nelstrom/vim-textobj-rubyblock " requires
"=bundle kana/vim-textobj-user          "
" }}}
"
" After installing or updating these bundles, recompile vimproc.vim and
" install snipmate-snippets by issuing `rake deploy_local`.

set nocompatible
set encoding=utf-8
scriptencoding utf-8
nnoremap Q <nop>
inoremap <C-c> <Esc>
let mapleader = "\<space>"

set eol                         " include a newline at the end of files
set autoread                    " automatically re-read changed files from disk if no pending writes
set history=1000
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
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set backspace=indent,eol,start  " backspace through everything in insert mode
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set colorcolumn=80              " column border at 80 chars

set hlsearch                    " highlight matches
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
" }}}

" Miscellaneous settings {{{
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
  " For when you forget to sudo, really write the file.
  cmap w!! w !sudo tee % >/dev/null
  " Saner splits
  set splitright                  " Puts new vsplit windows to the right of the current
  set splitbelow                  " Puts new split windows to the bottom of the current
  " ctags
  set tags+=./tags
" }}}

" Generic look {{{
  set t_Co=256
  set background=dark
  highlight clear SignColumn
  syntax on
" }}}

" Pathogen bundle settings {{{
  if !exists('g:bundle_dir') | let g:bundle_dir =  expand('$HOME/.vim/bundle') | endif
  if isdirectory(g:bundle_dir)

    runtime bundle/vim-pathogen/autoload/pathogen.vim
    execute pathogen#infect()

    autocmd BufWritePre * :Trim

    nmap <leader>se :NERDTreeToggle<cr>
    nmap <leader>st :TlistToggle<cr>

    vmap <Enter> <Plug>(EasyAlign)
    nmap <leader>a <Plug>(EasyAlign)
    let g:splitjoin_split_mapping = ''
    let g:splitjoin_join_mapping = ''

    nmap sj :SplitjoinSplit<cr>
    nmap sk :SplitjoinJoin<cr>

    let g:surround_{char2nr('s')} = " \r"
    let g:surround_{char2nr(':')} = ":\r"
    let g:surround_indent = 1

    " Git mappings {{{
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

    let g:SuperTabDefaultCompletionType = "context"
    let g:acp_enableAtStartup = 1
    let g:acp_ignorecaseOption = 1
    let g:acp_completeoptPreview = 1

    let g:ruby_indent_access_modifier_style = 'outdent'

    let g:markdown_fenced_languages = ['ruby', 'vim']
    au BufRead,BufNewFile *.md set filetype=markdown

    let g:solarized_termtrans = 1
    colorscheme solarized
    highlight clear SignColumn
  endif
" }}}
filetype plugin indent on

" Shortcuts {{{
  nmap <leader>x :exec getline(".")<cr>
  nmap <leader>r :source $MYVIMRC<cr>
  nmap <leader>ev :edit $MYVIMRC<cr>
  nmap <leader>ss :source %<cr>
  nmap <leader>i mmgg=G`m<cr>
  " convert hashrockets to 1.9 syntax
  nmap <leader>hr :%s/:\([^=,'"]*\) =>/\1:/gc"'<cr>

  " buffer nav
  nmap <leader>c :bp<bar>sp<bar>bn<bar>bd<cr>
  nmap <leader>n :BufSurfForward<cr>
  nmap <leader>p :BufSurfBack<cr>

  " Map <leader>ff to display all lines with keyword under cursor
  " and ask which one to jump to
  nmap <leader>ff [I:let nr = input("Which one: ")<bar>exe "normal " . nr ."[\t"<cr>
" }}}

" Completion {{{
  " set completefunc=syntaxcomplete#Complete
  " Omnicomplete settings {{{
    augroup omnicomplete_group
      autocmd FileType css             setlocal omnifunc=csscomplete#CompleteCSS
      autocmd FileType html,markdown   setlocal omnifunc=htmlcomplete#CompleteTags
      autocmd FileType javascript      setlocal omnifunc=javascriptcomplete#CompleteJS
      autocmd FileType python          setlocal omnifunc=pythoncomplete#Complete
      autocmd FileType xml             setlocal omnifunc=xmlcomplete#CompleteTags
      autocmd FileType ruby,eruby      set omnifunc=rubycomplete#Complete
      autocmd FileType ruby,eruby      let g:rubycomplete_buffer_loading=1
      autocmd FileType ruby,eruby      let g:rubycomplete_classes_in_global=1
      autocmd FileType ruby,eruby      let g:rubycomplete_rails=1
      autocmd FileType ruby,eruby let g:rubycomplete_include_object = 1
      autocmd FileType ruby,eruby let g:rubycomplete_include_objectspace = 1
    augroup END
  " }}}
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

" Paranoia {{{
  " Save your backups to a less annoying place than the current directory.
  " If you have .vim-backup in the current directory, it'll use that.
  " Otherwise it saves it to ~/.vim/backup or . if all else fails.
  if isdirectory($HOME . '/.vim/backup') == 0
    :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
  endif
  set backupdir-=.
  set backupdir+=.
  set backupdir-=~/
  set backupdir^=~/.vim/backup/
  set backupdir^=./.vim-backup/
  set backup

  " Save your swp files to a less annoying place than the current directory.
  " If you have .vim-swap in the current directory, it'll use that.
  " Otherwise it saves it to ~/.vim/swap, ~/tmp or .
  if isdirectory($HOME . '/.vim/swap') == 0
    :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
  endif
  set directory=./.vim-swap/
  set directory+=~/.vim/swap/
  set directory+=~/tmp/
  set directory+=.

  " viminfo stores the the state of your previous editing session
  set viminfo+=n~/.vim/viminfo

  if exists("+undofile")
    " undofile - This allows you to use undos after exiting and restarting
    " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
    " :help undo-persistence
    " This is only present in 7.3+
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

" Status line {{{
  set statusline =%#identifier#
  set statusline+=[%{pathshorten(expand('%'))}] " abbreviated relative path
  set statusline+=%*

  "display a warning if fileformat isnt unix
  set statusline+=%#warningmsg#
  set statusline+=%{&ff!='unix'?'['.&ff.']':''}
  set statusline+=%*

  "display a warning if file encoding isnt utf-8
  set statusline+=%#warningmsg#
  set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
  set statusline+=%*

  set statusline+=%h      "help file flag
  set statusline+=%y      "filetype

  "read only flag
  set statusline+=%#identifier#
  set statusline+=%r
  set statusline+=%*

  "modified flag
  set statusline+=%#identifier#
  set statusline+=%m
  set statusline+=%*

  set statusline+=%{fugitive#statusline()}

  "display a warning if &et is wrong, or we have mixed-indenting
  set statusline+=%#error#
  set statusline+=%{StatuslineTabWarning()}
  set statusline+=%*

  set statusline+=%{StatuslineTrailingSpaceWarning()}

  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  "display a warning if &paste is set
  set statusline+=%#error#
  set statusline+=%{&paste?'[paste]':''}
  set statusline+=%*

  set statusline+=%=      "left/right separator
  set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
  set statusline+=%c,     "cursor column
  set statusline+=%l/%L   "cursor line/total lines
  set statusline+=\ %P    "percent through file
  set laststatus=2

  "recalculate the trailing whitespace warning when idle, and after saving
  autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

  "return '[\s]' if trailing white space is detected
  "return '' otherwise
  function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")

      if !&modifiable
        let b:statusline_trailing_space_warning = ''
        return b:statusline_trailing_space_warning
      endif

      if search('\s\+$', 'nw') != 0
        let b:statusline_trailing_space_warning = '[\s]'
      else
        let b:statusline_trailing_space_warning = ''
      endif
    endif
    return b:statusline_trailing_space_warning
  endfunction


  "return the syntax highlight group under the cursor ''
  function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
      return ''
    else
      return '[' . name . ']'
    endif
  endfunction

  "recalculate the tab warning flag when idle and after writing
  autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

  "return '[&et]' if &et is set wrong
  "return '[mixed-indenting]' if spaces and tabs are used to indent
  "return an empty string if everything is fine
  function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
      let b:statusline_tab_warning = ''

      if !&modifiable
        return b:statusline_tab_warning
      endif

      let tabs = search('^\t', 'nw') != 0

      "find spaces that arent used as alignment in the first indent column
      let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

      if tabs && spaces
        let b:statusline_tab_warning =  '[mixed-indenting]'
      elseif (spaces && !&et) || (tabs && &et)
        let b:statusline_tab_warning = '[&et]'
      endif
    endif
    return b:statusline_tab_warning
  endfunction
" }}}

" Whitespace settings for different filetypes {{{
  augroup whitespace_group
    autocmd FileType javascript,coffee            setlocal et sw=2 sts=2 isk+=$
    autocmd FileType html,xhtml,css,scss,scss.css setlocal et sw=2 sts=2 isk+=-
    autocmd FileType eruby,yaml,ruby              setlocal et sw=2 sts=2
    autocmd FileType cucumber                     setlocal et sw=2 sts=2
    autocmd FileType gitcommit                    setlocal spell
    autocmd FileType ruby                         setlocal comments=:#\  tw=79
    autocmd FileType vim                          setlocal et sw=2 sts=2 keywordprg=:help
    autocmd FileType python                       setlocal sts=4 ts=4 shiftwidth=4 textwidth=79
    autocmd FileType c                            setlocal et sw=2 sts=2
    autocmd FileType objc,objcpp                  setlocal et sw=4 sts=4

    autocmd FileType markdown                     setlocal linebreak formatoptions=1 breakat=\ @-+;:,./?^I
  augroup END
" }}}

" vim: foldmethod=indent:nofoldenable
