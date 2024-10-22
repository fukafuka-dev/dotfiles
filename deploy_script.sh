#!/bin/sh
set -eu

# Scripts
repodir=$(cd $(dirname $0); pwd)
ln -sf $repodir/bin/memo.sh $HOME/bin/memo.sh
