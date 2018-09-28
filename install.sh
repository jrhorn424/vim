curl -L https://bit.ly/janus-bootstrap | bash

brew install neovim

# https://robots.thoughtbot.com/my-life-with-neovim
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s ~/.vim $XDG_CONFIG_HOME/nvim
ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
