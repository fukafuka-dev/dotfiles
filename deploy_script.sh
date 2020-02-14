#!/bin/sh
set -eu

# Scripts
repodir=$(cd $(dirname $0); pwd)
ln -sf $repodir/bin/memo.zsh $HOME/bin/memo.zsh
ln -sf $repodir/bin/memo.rb $HOME/bin/memo.rb
ln -sf $repodir/bin/memo.py $HOME/bin/memo.py
