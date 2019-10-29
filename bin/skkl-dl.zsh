#!/bin/zsh

root_dir=$HOME

if [ ! -d "$root_dir" ];then
  echo $root_dir is not found.
  exit 1
fi

dir=$root_dir/.eskk
if [ ! -d "$dir" ];then
  mkdir $dir
fi

curl -L http://openlab.jp/skk/dic/SKK-JISYO.L.gz -o $dir/SKK-JISYO.L.gz
gzip -d $dir/SKK-JISYO.L.gz
