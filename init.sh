#!/bin/sh
set -eu

# lib
sudo apt update
sudo apt upgrade
sudo apt install language-pack-ja automake gcc pkg-config libpcre3-dev liblzma-dev zlib1g-dev libevent-dev libncursesw5-dev bison -y

# TimeZone
sudo timedatectl set-timezone Asia/Tokyo

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

echo 'finish'
