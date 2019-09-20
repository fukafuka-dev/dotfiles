#!/bin/sh
set -eu

repodir=$(cd $(dirname $0); pwd)
mkdir -p $HOME/bin

# CLI Settings
ln -sf $repodir/zshrc $HOME/.zshrc
ln -sf $repodir/vimrc $HOME/.vimrc
ln -sf $repodir/tigrc $HOME/.tigrc
ln -sf $repodir/tmux.conf $HOME/.tmux.conf
ln -sf $repodir/gitconfig $HOME/.gitconfig

# Scripts
ln -sf $repodir/bin/memo.zsh $HOME/bin/memo.zsh

# Neovim
mkdir -p $HOME/.config
mkdir -p ~/.vim/plugged
mkdir -p ~/.vim/colors

ln -sf $HOME/.vim $HOME/.config/nvim
ln -sf $HOME/.vimrc $HOME/.config/nvim/init.vim

echo 'finish'
