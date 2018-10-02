if has("termguicolors") && exists('$TMUX') == 0
  let base16colorspace=256
  set termguicolors
endif

if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
endif

set background=dark
