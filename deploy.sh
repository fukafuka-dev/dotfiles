#!/bin/sh

set -eu

rm -f ~/.zshrc
rm -f ~/.vimrc

repodir=$(cd $(dirname $0); pwd)
mkdir -p $HOME/bin

# CLI Settings
ln -sf $repodir/zshrc $HOME/.zshrc
ln -sf $repodir/vimrc $HOME/.vimrc
ln -sf $repodir/tigrc $HOME/.tigrc
ln -sf $repodir/tmux.conf $HOME/.tmux.conf

# Scripts
ln -sf $repodir/bin/memo.zsh $HOME/bin/memo.zsh

# Neovim
mkdir -p $HOME/.config
ln -sf $HOME/.vim $HOME/.config/nvim
ln -sf $HOME/.vimrc $HOME/.config/nvim/init.vim

echo 'finish'
