set nocompatible
set encoding=utf-8

"
" Vundle
"
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" dependencies
Bundle 'gmarik/vundle'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'

Bundle 'tpope/vim-surround'
Bundle 'kien/ctrlp.vim'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'vim-scripts/restore_view.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-commentary'
Bundle 'chriskempson/base16-vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'takac/vim-hardtime'

set background=light
colorscheme base16-chalk
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation
syntax on

set autoindent
set history=1000
set nocursorline
set autowrite                  " automatically write a file when leaving a modified buffer
set shortmess+=filmnrxoOtT      " Abbrev. of messages (avoids 'hit enter')
scriptencoding utf-8
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore             " Allow for cursor beyond last character
set spell                           " Spell checking on
set hidden                          " Allow buffer switching without saving
set tabpagemax=15               " Only show 15 tabs
set showmode                    " Display the current mode
highlight clear SignColumn      " SignColumn should match background for
                                " things like vim-gitgutter

highlight clear LineNr          " Current line number row will have same background color in relative mode.
                                " Things like vim-gitgutter will match LineNr highlight

set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on

set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set foldenable                  " Auto fold code

"
" Handle whitespace
"
set nowrap                      " don't wrap lines
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set backspace=indent,eol,start  " backspace through everything in insert mode
filetype indent plugin on

" indent guides
set list
set listchars=trail:·,extends:»,precedes:«,nbsp:× " don't forget escaped trailing space

"
" Paranoia
"
set backup                  " Backups are nice ...
if has('persistent_undo')
    set undofile                " So is persistent undo ...
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
set showmatch

set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current

autocmd FileType c,cpp,java,go,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()
autocmd FileType go autocmd BufWritePre <buffer> Fmt

"
" Keybindings
"
inoremap <C-c> <Esc>
let mapleader = "\<space>"
nnoremap j VipJ " visually select the entire paragraph and then join the lines in it

" switch tabs types
nmap <Leader>t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nmap <Leader>T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
nmap <Leader>M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
nmap <Leader>m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>

" switch wrap
nmap <Leader>w :setlocal wrap!<CR>:setlocal wrap?<CR>

" Easier moving in tabs and windows
" The lines conflict with the default digraph mapping of <C-K>
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" Stupid shift key fixes
command! -bang -nargs=* -complete=file E e<bang> <args>
command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

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
nmap <silent> <leader>/ :set invhlsearch<CR>

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" Shortcuts
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Adjust viewports to the same size
map <Leader>= <C-w>=

" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Easier horizontal scrolling
map zl zL
map zh zH

let b:match_ignorecase = 1

" AutoCloseTag {
    " Make it so AutoCloseTag works for xml and xhtml files as well
    au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
    nmap <Leader>ac <Plug>ToggleAutoCloseMappings
" }

" Tabularize {
    nmap <Leader>a& :Tabularize /&<CR>
    vmap <Leader>a& :Tabularize /&<CR>
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:<CR>
    vmap <Leader>a: :Tabularize /:<CR>
    nmap <Leader>a:: :Tabularize /:\zs<CR>
    vmap <Leader>a:: :Tabularize /:\zs<CR>
    nmap <Leader>a, :Tabularize /,<CR>
    vmap <Leader>a, :Tabularize /,<CR>
    nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
" }

" ctrlp {
    let g:ctrlp_working_path_mode = 'ra'
    nnoremap <silent> <D-t> :CtrlP<CR>
    nnoremap <silent> <D-r> :CtrlPMRU<CR>
    let g:ctrlp_custom_ignore = {
        \ 'dir':  '\.git$\|\.hg$\|\.svn$',
        \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

    " On Windows use "dir" as fallback command.
    if has('win32') || has('win64')
        let g:ctrlp_user_command = {
            \ 'types': {
                \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                \ 2: ['.hg', 'hg --cwd %s locate -I .'],
            \ },
            \ 'fallback': 'dir %s /-n /b /s /a-d'
        \ }
    else
        let g:ctrlp_user_command = {
            \ 'types': {
                \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                \ 2: ['.hg', 'hg --cwd %s locate -I .'],
            \ },
            \ 'fallback': 'find %s -type f'
        \ }
    endif
"}

" indent_guides {
    let g:indent_guides_auto_colors = 1
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
    let g:indent_guides_enable_on_vim_startup = 1
" }

" vim-gitgutter {
    " https://github.com/airblade/vim-gitgutter/issues/106
    let g:gitgutter_realtime = 0
" }

" }

" GUI Settings {

" GVIM- (here instead of .gvimrc)
if has('gui_running')
    set guioptions-=T           " Remove the toolbar
    set lines=40                " 40 lines of text instead of 24
else
    if &term == 'xterm' || &term == 'screen'
        set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
    endif
    "set term=builtin_ansi       " Make arrow and other keys work
endif

" }

" Functions {

" Initialize directories {
function! InitializeDirectories()
    let parent = $HOME
    let prefix = 'vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

        let common_dir = parent . '/.' . prefix

    for [dirname, settingname] in items(dir_list)
        let directory = common_dir . dirname . '/'
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction
call InitializeDirectories()
" }

" Strip whitespace {
function! StripTrailingWhitespace()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " do the business:
  %s/\s\+$//e
  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
" }

" Shell command {
function! s:RunShellCommand(cmdline)
    botright new

    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal nobuflisted
    setlocal noswapfile
    setlocal nowrap
    setlocal filetype=shell
    setlocal syntax=shell

    call setline(1, a:cmdline)
    call setline(2, substitute(a:cmdline, '.', '=', 'g'))
    execute 'silent $read !' . escape(a:cmdline, '%#')
    setlocal nomodifiable
    1
endfunction

command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
" e.g. Grep current file for <search_term>: Shell grep -Hn <search_term> %
" }
