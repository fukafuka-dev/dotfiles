#!/bin/zsh

# -------------------------------------------
# options
# -------------------------------------------

# default dir
work_dir=$HOME/.memo

# set options
while [ $# -gt 0 ];
do
  case ${1} in
    --archive|-a)
      echo 'achive機能（未実装）'
    ;;

    --env|-e)
      work_dir=${2}
      shift
    ;;

    *)
      break
    ;;
  esac
  shift
done

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

function rename {
  if [ -n "$1" ]; then
    query=$1
    shift
  fi

  file=$(ls $work_dir | fzf -q "$query" --preview "head -100 $work_dir/{}")

  echo Name:
  read new_name

  if [ -n "$new_name" ]; then
    mv $work_dir/$file $work_dir/$new_name.md
  fi
}

function edit {
  if [ -n "$1" ]; then
    query=$1
  fi

  file=$(ls $work_dir | fzf -q "$query" --preview "head -100 $work_dir/{}")
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

  file=$(ls $work_dir | fzf -q "$query" --preview "head -100 $work_dir/{}")
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
case ${1} in
 new|n)
  create_new $2
  ;;

 edit|e)
  edit $2
  ;;

list|l)
  list $2
  ;;

grep|g)
  grep $2
  ;;
delete|d)
  remove $2
  ;;
rename|r)
  rename $2 $3
  ;;
server|s)
  server $2
  ;;
*)
  echo "[ERROR] Invalid subcommand '${1}'"
  exit 1
;;
esac
