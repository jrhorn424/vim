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
set list listchars=nbsp:×,trail:·,precedes:«,extends:»,eol:¬,tab:▸\

"statusline setup
set statusline =%#identifier#
set statusline+=[%t]    "tail of the filename
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

set statusline+=%{StatuslineLongLineWarning()}

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

"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
  if !exists("b:statusline_long_line_warning")

    if !&modifiable
      let b:statusline_long_line_warning = ''
      return b:statusline_long_line_warning
    endif

    let long_line_lens = s:LongLines()

    if len(long_line_lens) > 0
      let b:statusline_long_line_warning = "[" .
            \ '#' . len(long_line_lens) . "," .
            \ 'm' . s:Median(long_line_lens) . "," .
            \ '$' . max(long_line_lens) . "]"
    else
      let b:statusline_long_line_warning = ""
    endif
  endif
  return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
  let threshold = (&tw ? &tw : 80)
  let spaces = repeat(" ", &ts)
  let line_lens = map(getline(1,'$'), 'len(substitute(v:val, "\\t", spaces, "g"))')
  return filter(line_lens, 'v:val > threshold')
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
  let nums = sort(a:nums)
  let l = len(nums)

  if l % 2 == 1
    let i = (l-1) / 2
    return nums[i]
  else
    return (nums[l/2] + nums[(l/2)-1]) / 2
  endif
endfunction

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

" this option needs to come after the colorscheme
" definition
syntax on

filetype on
filetype indent on
filetype plugin on

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

" Vim shortcuts
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

map <Leader>x :exec getline(".")<cr>
map <Leader>r :source $MYVIMRC<cr>
map <Leader>ev :edit $MYVIMRC<cr>
map <Leader>ss :source %<cr>
map <Leader>i mmgg=G`m<cr>

" buffer nav
map <Leader>c :bp<bar>sp<bar>bn<bar>bd<CR>
map <Leader>n :bn<CR>
map <Leader>p :bp<CR>

" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
map <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Search
map <leader>h :nohlsearch<cr>

" Saner splits
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current

" make split navigation work with tmux
Bundle 'christoomey/vim-tmux-navigator'
" yank a paste window splits
Bundle 'wesQ3/vim-windowswap'
" Navigate files
Bundle 'scooloose/nerdtree'
nmap <Leader>e :NERDTreeToggle<CR>
" Navigate tags
Bundle 'majutsushi/tagbar'

" fuzzy find files in project and more
Bundle 'Shougo/vimproc.vim'
Bundle 'Shougo/unite.vim'
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
" call unite#custom#source('ag,ack,grep,find','ignore_pattern',join(['\.log$','coverage/'], '\|'))

let g:unite_source_history_yank_enable = 1
let g:unite_data_directory='~/.vim/cache'

if executable('ag')
  let g:unite_source_grep_command='ag'
  let g:unite_source_grep_default_opts='--nocolor --nogroup -S -C4'
  let g:unite_source_grep_recursive_opt=''
  let g:unite_source_async_command='ag --nocolor --nogroup'
elseif executable('ack')
  let g:unite_source_grep_command='ack'
  let g:unite_source_grep_default_opts='--no-heading --no-color -a -C4'
  let g:unite_source_grep_recursive_opt=''
  let g:unite_source_async_command='ack -f --nofilter'
endif

nmap <Leader>f :Unite -no-split -start-insert file_rec/async:! file/new<CR>
nmap <Leader>b :Unite -no-split buffer<CR>
nmap <Leader>y :Unite -no-split history/yank<CR>
nmap <Leader>/ :Unite grep:.<CR>

"
Bundle 'msanders/snipmate.vim'
" use (and customize) tab for completion
Bundle 'ervandew/supertab'
" autoclose brackets, parentheses, quotes
Bundle 'Townk/vim-autoclose'
" close html/xml tags
Bundle 'tpope/vim-ragtag'
"
Bundle 'Lokaltog/vim-easymotion'
" better linting and errors
Bundle 'scrooloose/syntastic'
" Rename, move, etc.
Bundle 'tpope/vim-eunuch'
" change single/double quotes, etc.
Bundle 'tpope/vim-surround'
" allow other plugins to use repeat operator
Bundle 'tpope/vim-repeat'
" gcap to comment a whole paragraph, for example
Bundle 'tpope/vim-commentary'
" git inside vim
Bundle 'tpope/vim-fugitive'
" crc to camelCase crs to snake_case cru to UPCASE
Bundle 'tpope/vim-abolish'
" sensible defaults for different languages
Bundle 'tpope/vim-sensible'

" Zoom windows with <C-w>o
Bundle 'vim-scripts/ZoomWin'

" Markdown
Bundle 'tpope/vim-markdown'
let g:markdown_fenced_languages = ['ruby', 'vim']
au BufRead,BufNewFile *.md set filetype=markdown

" Ruby
Bundle 'vim-ruby/vim-ruby'
" automatically add 'end' when appropriate
if !exists( "*RubyEndToken" )

  function RubyEndToken()
    let current_line = getline( '.' )
    let braces_at_end = '{\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'
    let stuff_without_do = '^\s*\(class\|if\|unless\|begin\|case\|for\|module\|while\|until\|def\)'
      let with_do = 'do\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'

      if match(current_line, braces_at_end) >= 0
        return "\<CR>}\<C-O>O"
      elseif match(current_line, stuff_without_do) >= 0
        return "\<CR>end\<C-O>O"
      elseif match(current_line, with_do) >= 0
        return "\<CR>end\<C-O>O"
      else
        return "\<CR>"
      endif
    endfunction

endif

imap <buffer> <CR> <C-R>=RubyEndToken()<CR>

" minitest completion and syntax highlighting
Bundle 'sunaku/vim-ruby-minitest'
set completefunc=syntaxcomplete#Complete

" Rails
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-bundler'
" slim syntax highlighting
Bundle 'slim-template/vim-slim'
" Rails.vim for non-rails projects
Bundle 'tpope/vim-rake'

"
Bundle 'vim-scripts/vim-auto-save'
let g:auto_save = 1

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
