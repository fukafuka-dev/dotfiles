#!/bin/sh
set -eu

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#  THIS IS WIP SO NO TEST
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# neovim
if [ -z "$(which nvim)" ]; then
  # 最新版
  sudo apt install -y software-properties-common
  sudo add-apt-repository ppa:neovim-ppa/stable
  sudo apt update
  sudo apt install -y neovim
fi

# Zplugin
if [ ! -e "$HOME/.zplugin" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
fi

# vim-plug
if [ ! -e "$HOME/.vim/autoload/plug.vim"]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  mkdir -p ~/.vim/colors
  mkdir -p ~/.vim/plugged
fi

# fzf
if [ -z "$(which fzf)" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  .fzf/install
fi

# tmux
if [ -z "$(which fzf)" ]; then
  git clone https://github.com/tmux/tmux.git ./tmux
  cd ./tmux && sh autogen.sh && ./configure --prefix=/usr/local && make && sudo make install
  rm -rf ./tmux
fi

# anyenv
git clone https://github.com/riywo/anyenv $HOME/.anyenv
source ~/.zshrc
anyenv install

anyenv install rbenv
anyenv install pyenv
anyenv install nodenv

