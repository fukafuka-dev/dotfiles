#!/bin/zsh

local -A opthash
zparseopts -D -M -A opthash -- \
  v: -env \
  a -archive \
  n -new \
  e -edit \
  l -list \
  g -grep \
  r -remove \
  s -server

# -------------------------------------------
# init
# -------------------------------------------

# default dir
work_dir=$HOME/.memo
config_dir=$HOME/.memo_config

# custom dir
if [ -f $config_dir ]; then
  INI_SECTION=main
  INI_FILE=$config_dir

  if [[ -n "${opthash[(i)-v]}" ]]; then
    INI_SECTION=${opthash[-v]}
  fi

  eval `sed -e 's/[[:space:]]*\=[[:space:]]*/=/g' \
      -e 's/;.*$//' \
      -e 's/[[:space:]]*$//' \
      -e 's/^[[:space:]]*//' \
      -e "s/^\(.*\)=\([^\"']*\)$/\1=\"\2\"/" \
     < $INI_FILE \
      | sed -n -e "/^\[$INI_SECTION\]/,/^\s*\[/{/^[^;].*\=.*/p;}"`

  # sedの区切り文字はs以降の一文字目
  post_dir=$(echo $dir | sed "s@^~@$HOME@")
  if [ -e "$post_dir" ]; then
    work_dir=$post_dir
  else
    echo $post_dir: directory not found.
    exit 1
  fi
fi

mkdir -p $work_dir

# -------------------------------------------
# option functions
# -------------------------------------------
function create_new {
  if [ -n "$1" ]; then
    title=$1
  else
    echo Title:
    read title
    title=$(echo "$title" | sed 's/ /-/g')
  fi

  if [ -n "$title" ]; then
    file=$(date "+%Y-%m-%d-$title.md")
    $EDITOR $work_dir/$file
  else
    echo 'empty filename.'
  fi
}

function edit {
  if [ -n "$1" ]; then
    query=$1
  fi

  file=$(ls $work_dir | fzf -q "$query")
  if [ -n "$file" ]; then
    $EDITOR $work_dir/$file
  fi
}

function list {
  ls -1 $work_dir
}

function grep {
  ag "$1" $work_dir
}

function remove {
  if [ -n "$1" ]; then
    query=$1
  fi

  file=$(ls $work_dir | fzf -q "$query")
  if [ -n "$file" ]; then
    echo $work_dir/$file
    echo "ok?(y/N): "
    if read -q; then
      rm $work_dir/$file
    else
      echo Cancelled.
    fi
  fi
}

function server {
  cd $work_dir
  markserv .
  cd -
}

# -------------------------------------------
# run option case
# -------------------------------------------
if [[ -n "${opthash[(i)-n]}" ]]; then
  create_new $2
elif [[ -n "${opthash[(i)-e]}" ]]; then
  edit $2
elif [[ -n "${opthash[(i)-l]}" ]]; then
  list $2
elif [[ -n "${opthash[(i)-g]}" ]]; then
  grep $2
elif [[ -n "${opthash[(i)-r]}" ]]; then
  remove $2
elif [[ -n "${opthash[(i)-s]}" ]]; then
  server $2
else
  echo 'option not found.'
fi
