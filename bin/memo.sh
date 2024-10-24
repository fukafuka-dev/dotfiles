#!/bin/bash
#
load_config() {
  . "$HOME/.memo/config"
}

usage() {
  echo $opt_archive
}

init_working_dir() {
  # defulat dir
  local dir="~/doc/memo"

  # configファイルから読み込み
  if [ -n "$CONFIG_WORKING_DIR" ]; then
    dir=$CONFIG_WORKING_DIR
  fi

  # ~を展開してスラッシュを追加
  dir=$(eval echo $dir)
  if [[ "$dir" != */ ]]; then
    dir="${dir}/"
  fi

  inbox_dir="${dir}inbox/"
  archive_dir="${dir}archive/"

  # inbox/archive切り替え
  if "$opt_archive"; then
    working_dir=$archive_dir
  else
    working_dir=$inbox_dir
  fi
}

open_fzf() {
  local working_dir=$1
  local filename=$(ls "$working_dir" | fzf -q "$query" --preview "head -100 $working_dir/{}")

  if [ -z "$filename" ]; then
    echo ""
  else
    echo "$filename"
  fi
}

open_fzf_with_working_dir() {
  local file=$(open_fzf $working_dir)
  if [ -n "$file" ]; then
    echo ${working_dir}${file}
  fi
}

convert_spaces() {
  local input_string="$1"
  echo "$input_string" | tr ' ' '-'
}

create_new_file() {
  read -p "Title: " title
  local formatted_title=$(convert_spaces "$title")
  local date_prefix=$(date +"%Y-%m-%d") # 日付を取得
  local filename="${date_prefix}-${formatted_title}.md"

  # フルパス生成
  local path="${working_dir}${filename}"

  # ファイル作成
  mkdir -p "$working_dir"
  vim "$path" -c "r! echo \"$title\n=========\"" -c "normal G$"
}

list_and_open_file() {
  local file=$(open_fzf_with_working_dir)
  if [ -z "$file" ]; then
    return
  fi

  echo $file

  if [ -n "$file" ]; then
    vim "$file"
  fi
}

delete_file() {
  local file=$(open_fzf_with_working_dir)

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
  local file=$(open_fzf_with_working_dir)
  if [ -z "$file" ]; then
    return
  fi

  read -p "New filename: " newname
  if [ -z "$newname" ]; then
    return
  fi

  local dir=$(dirname "$file")
  local date=$(basename "$file" | cut -d'-' -f1-3)
  local formatted_filename=$(convert_spaces "$newname")
  local newfile="$dir/$date-$formatted_filename.md"
  mv "$file" "$newfile"
}

grep_file() {
  echo "TODO"
}

archive() {
  local file=$(open_fzf $inbox_dir)

  if [ -n "$file" ]; then
    mv $inbox_dir$file $archive_dir$file
  fi
}

# --------------------------------------------

# configファイル読み込み
load_config

# オプションと引数の解析
opt_archive=false
while getopts "a" opt; do
  case $opt in
    a)
      opt_archive=true
      ;;
    *)
      usage
      ;;
  esac
done
shift $((OPTIND -1))

# 作業ディレクトリの指定
init_working_dir

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
    grep_file $@
    ;;
  archive | a)
    archive
    ;;
  debug )
    usage
    ;;
  *)
    create_new_file
    ;;
esac
