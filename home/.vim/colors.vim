set t_Co=256

if has("termguicolors") && exists('$TMUX') == 0
  let base16colorspace=256
  set termguicolors
endif

if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
endif

highlight Comment ctermfg=lightblue

highlight Pmenu ctermfg=black ctermbg=lightmagenta
highlight PmenuSel ctermfg=white ctermbg=darkmagenta

highlight clear SpellBad
highlight SpellBad cterm=underline gui=underline
