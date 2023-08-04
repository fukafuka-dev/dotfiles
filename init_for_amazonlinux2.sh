#!/bin/sh
set -eu

# lib
sudo yum -y update
sudo yum -y groupinstall "Development Tools"
sudo yum -y install zsh pcre-devel xz-devel zlib-devel libevent-devel ncurses-devel util-linux-user

# TimeZone

# fd
fd_name=fd-v8.1.1-i686-unknown-linux-musl
wget https://github.com/sharkdp/fd/releases/download/v8.1.1/${fd_name}.tar.gz -O ${fd_name}.tar.gz
tar -zxvf ${fd_name}.tar.gz
sudo mv ${fd_name}/fd /usr/local/bin
rm -rf ${fd_name} ${fd_name}.tar.gz

# ag
git clone https://github.com/ggreer/the_silver_searcher.git
cd ./the_silver_searcher
./build.sh
sudo make install
cd ../
rm -rf the_silver_searcher

# tmux
git clone https://github.com/tmux/tmux.git
cd tmux
sh autogen.sh
./configure --prefix=/usr/local
make
sudo make install
cd ../
rm -rf tmux

# tig
git clone https://github.com/jonas/tig.git
cd tig
./autogen.sh
./configure
make
sudo make install
cd ..
rm -rf tig

# asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.12.0

# ZPlugin
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# make dir
mkdir -p $HOME/bin
mkdir -p ~/.vim/plugged
mkdir -p ~/.vim/colors

# CLI Settings
repodir=$(cd $(dirname $0); pwd)
ln -sf $repodir/zshrc $HOME/.zshrc
ln -sf $repodir/vimrc $HOME/.vimrc
ln -sf $repodir/tigrc $HOME/.tigrc
ln -sf $repodir/tmux.conf $HOME/.tmux.conf
ln -sf $repodir/gitconfig $HOME/.gitconfig
ln -sf $repodir/gitconfig.special $HOME/.gitconfig.special

# default shell
sudo chsh -s /usr/bin/zsh $(whoami)

echo 'finish'
