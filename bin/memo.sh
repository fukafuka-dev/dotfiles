#!/bin/bash

useage() {
  echo "TODO"
}

get_working_dir() {
  dir=$(eval echo $base_dir) # ~を展開
  if [[ "$base_dir" != */ ]]; then
    dir="${dir}/"
  fi

  echo $dir
}

open_fzf() {
  local working_dir=$(get_working_dir)
  local filename=$(ls "$working_dir" | fzf -q "$query" --preview "head -100 $working_dir/{}")

  if [ -z "$filename" ]; then
    echo ""
  else
    echo "${working_dir}${filename}"
  fi
}

create_new_file() {
  read -p "Title: " title

  local formatted_title="${title// /-}" # 空白を-に変換
  local date_prefix=$(date +"%Y-%m-%d") # 日付を取得
  local filename="${date_prefix}-${formatted_title}.md"

  # ディレクトリ名を取得
  local working_dir=$(get_working_dir)

  # フルパス生成
  local path="${working_dir}${filename}"

  # ファイル作成
  mkdir -p "$working_dir"
  vim "$path" -c "r! echo \"$title\n=========\"" -c "normal G$"
}

list_and_open_file() {
  local file=$(open_fzf)
  if [ -z "$file" ]; then
    return
  fi

  vim "$file"
}

delete_file() {
  local file=$(open_fzf)

  # ファイルが選択されなかった場合は終了
  if [ -z "$file" ]; then
    return
  fi

  # 削除確認
  read -p "remove '$file' ? (y/n): " confirm
  if [ "$confirm" = "y" ]; then
    rm "$file"
  fi
}

rename_file() {
  local file=$(open_fzf)
  if [ -z "$file" ]; then
    return
  fi

  read -p "New filename: " newname
  if [ -z "$newname" ]; then
    return
  fi

  local dir=$(dirname "$file")
  local date=$(basename "$file" | cut -d'-' -f1-3)
  local newfile="$dir/$date-$newname.md"
  mv "$file" $newfile
  echo $newfile
}

grep_file() {
  # TODO: agの結果をfzfで絞り込むなどする
  echo "grep"
}

# --------------------------------------------

base_dir="~/doc/memo"

# オプションと引数の解析
opt_base_dir=""
while getopts "p:" opt; do
  case $opt in
    p)
      opt_base_dir=$OPTARG
      ;;
    *)
      usage
      ;;
  esac
done
shift $((OPTIND -1))

# 変数処理
if [ -n "$opt_base_dir" ]; then
  base_dir=$opt_base_dir
fi

# サブコマンド
COMMAND=$1
shift

case $COMMAND in
  new | n)
    create_new_file
    ;;
  list | l)
    list_and_open_file
    ;;
  delete | d)
    delete_file
    ;;
  rename | r)
    rename_file
    ;;
  grep | g)
    grep_file
    ;;
  debug )
    echo $FILE
    ;;
  *)
    create_new_file
    ;;
esac
