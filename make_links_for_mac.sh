#!/bin/sh
set -eu

repodir=$(cd $(dirname $0); pwd)
ln -sf $repodir/zshrc $HOME/.zshrc
ln -sf $repodir/vimrc $HOME/.vimrc
ln -sf $repodir/tigrc $HOME/.tigrc
ln -sf $repodir/tmux.conf $HOME/.tmux.conf
ln -sf $repodir/gitconfig $HOME/.gitconfig
ln -sf $repodir/gitconfig.special $HOME/.gitconfig.special

ln -sf ~/config/dotfiles/zshrc_mac $HOME/.zshrc_mac
ln -sf ~/config/dotfiles/zshrc_ubuntu $HOME/.zshrc_ubuntu
