#!/bin/sh

repodir=$HOME/dev/github.com/albtrs/dotfiles
mkdir -p $HOME/bin
ln -sf $repodir/bin/dialy.zsh $HOME/bin/dialy.zsh
ln -sf $repodir/bin/show_colors.sh $HOME/bin/show_colors.sh
ln -sf $repodir/.zshrc $HOME/.zshrc
ln -sf $repodir/.vimrc $HOME/.vimrc
ln -sf $repodir/.tigrc $HOME/.tigrc
ln -sf $repodir/.tmux.conf $HOME/.tmux.conf

mkdir -p $HOME/.config
ln -sf $HOME/.vim $HOME/.config/nvim
ln -sf $HOME/.vimrc $HOME/.config/nvim/init.vim
