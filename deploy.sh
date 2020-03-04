#!/bin/sh
set -eu

# use tools memo
# zsh, Zplugin, vim-plug, tmux, tig

# ZPlugin
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# tmux-plugin
#git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

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

# Neovim
# mkdir -p $HOME/.config
# ln -sf $HOME/.vim $HOME/.config/nvim
# ln -sf $HOME/.vimrc $HOME/.config/nvim/init.vim

echo 'finish'
