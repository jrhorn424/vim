homeshick link vim
brew install neovim

# https://robots.thoughtbot.com/my-life-with-neovim
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s $HOME/.vim $XDG_CONFIG_HOME/nvim
ln -s $HOME/.vimrc $XDG_CONFIG_HOME/nvim/init.vim

curl -fLo $HOME/vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
