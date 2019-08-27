#!/bin/zsh

local -A opthash
zparseopts -D -A opthash -- e:

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

  if [[ -n "${opthash[(i)-e]}" ]]; then
    INI_SECTION=${opthash[-e]}
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
# subcommand functions
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
# sub command case
# -------------------------------------------
subcmd=$1
if [ "$subcmd" = n ] || [ "$subcmd" = new ]; then
  create_new $2
elif [ "$subcmd" = e ] || [ "$subcmd" = edit ]; then
  edit $2
elif [ "$subcmd" = l ] || [ "$subcmd" = list ]; then
  list $2
elif [ "$subcmd" = g ] || [ "$subcmd" = grep ]; then
  grep $2
elif [ "$subcmd" = r ] || [ "$subcmd" = remove ]; then
  remove $2
elif [ "$subcmd" = s ] || [ "$subcmd" = server ]; then
  server $2
else
  echo 'command not found.'
fi
