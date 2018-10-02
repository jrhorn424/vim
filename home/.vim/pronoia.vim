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
  autocmd InsertLeave * silent! update
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
