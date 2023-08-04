#!/bin/sh
set -eu

# lib
sudo apt update
sudo apt upgrade -y
sudo apt install zsh language-pack-ja build-essential automake pkg-config libpcre3-dev liblzma-dev zlib1g-dev libevent-dev libncurses5-dev libncursesw5-dev bison -y

# TimeZone
sudo update-locale LANG=ja_JP.UTF-8

# fd
fd_name=fd-v8.1.1-i686-unknown-linux-musl
wget https://github.com/sharkdp/fd/releases/download/v8.1.1/${fd_name}.tar.gz -O ${fd_name}.tar.gz
tar -zxvf ${fd_name}.tar.gz
sudo mv ${fd_name}/fd /usr/local/bin
rm -rf ${fd_name} ${fd_name}.tar.gz

# ag
sudo apt install silversearcher-ag

# tmux
git clone https://github.com/tmux/tmux.git
cd tmux
sh autogen.sh
./configure --prefix=/usr/local
make
sudo make install
cd ../
rm -rf tmux
sudo apt remove tmux -y

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

# ZInit
sh -c "$(curl -fsSL https://git.io/get-zi)" --

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
