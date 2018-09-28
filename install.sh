brew install neovim

# https://robots.thoughtbot.com/my-life-with-neovim
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s $XDG_CONFIG_HOME/nvim ~/.vim 
ln -s $XDG_CONFIG_HOME/nvim/init.vim ~/.vimrc 
