#!/bin/sh

repodir=~/dev/github.com/albtrs/dotfiles
mkdir -p ~/bin
ln -sf $repodir/bin/dialy.zsh ~/bin/dialy.zsh
ln -sf $repodir/bin/show_colors.sh ~/bin/show_colors.sh
ln -sf $repodir/.zshrc ~/.zshrc
ln -sf $repodir/.vimrc ~/.vimrc
ln -sf $repodir/.tigrc ~/.tigrc
ln -sf $repodir/.tmux.conf ~/.tmux.conf

mkdir -p ~/.config
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
