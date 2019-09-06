# ----------------------------------------------------------------
# 環境設定
# ----------------------------------------------------------------
export LANG=ja_JP.UTF-8
export TERM=xterm-256color

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

# bin
export PATH="$HOME/bin":"$PATH"

# emacs風bindkey
bindkey -e

# 色
autoload -Uz colors
colors

# neovim
export XDG_CONFIG_HOME=~/.config

# ----------------------------------------------------------------
# プロンプト
# ----------------------------------------------------------------

# Git連携
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}+"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}*"
zstyle ':vcs_info:*' formats "%F{yellow}[%f%F{cyan}%c%u%b%F{yellow}]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
  vcs_info
}

PROMPT='
💬 %F{blue}%n%f '
RPROMPT='%F{yellow}➜ %f %F{cyan}%~%f ${vcs_info_msg_0_} %F{yellow}ϟ%f'

# ----------------------------------------------------------------
# alias
# ----------------------------------------------------------------
alias vim8='/usr/bin/vim'
alias vim=$EDITOR
alias view='() { $EDITOR -R $1 }' # viewコマンドは元々あるがviが使われる
alias ls='ls -GF'

# ゴミ箱付きrm
alias rm='mv -t /tmp/garvage -b --suffix=.$(date +%Y%m%d)'
alias _rm='/bin/rm'

# vim
alias vin='() { vim $(ls $1 | fzf) }'

# ghq
alias repo='() { cd $(ghq list -p | fzf -q "$*"  --preview "tree -C {} | head -200") }'

# メモ関係
alias note="memo.zsh -e ~/doc/memo"
alias memo="memo.zsh -e ~/Dropbox/plane/memo"

alias dia="dialy.zsh"
dropbox_dir=~/Dropbox/plane
alias todo='vim $dropbox_dir/todo/todo.txt'
alias todo-ls='cat $dropbox_dir/todo/todo.txt | fzf'

# 特定のコマンドを実行した時背景色を変える（終了したら戻る）
alias ssh-login='(){tmux select-pane -P "fg=colour15,bg=magenta"; ssh $1; tmux select-pane -P "fg=default,bg=default" }'

# Docker
docker_login() {
  local login_command=bash
  if [ $# = 2 ]; then login_command=$2 fi
  docker exec -it $1 $login_command
}
alias docker-login='docker_login $1 $2'

# プロジェクト固有
alias ui-start='foreman start -f Procfile.dev'
alias ss='bin/spring stop'

# ----------------------------------------------------------------
# 補完
# ----------------------------------------------------------------

autoload -Uz compinit
compinit

# ほとんどの補完の定義を削除する。
# special contexts の定義のみ残す (see: man zshcompsys)
fix_comp_assoc() {
  local var=$1
  shift
    for key in "$argv[@]"; do
      case $key in
      -redirect-,\<,*) unset "${var}[$key]";;
      -redirect-,\>,*) unset "${var}[$key]";;
      -value-,-*) ;;
      -value-,*) unset "${var}[$key]";;
      -*) ;;
      *) unset "${var}[$key]";;
      esac
    done
}
fix_comp_assoc _comps        "${(k)_comps[@]}"
fix_comp_assoc _services     "${(k)_services[@]}"
fix_comp_assoc _patcomps     "${(k)_patcomps[@]}"
fix_comp_assoc _postpatcomps "${(k)_postpatcomps[@]}"

# ----------------------------------------------------------------
# 環境別設定を読み込む
# ----------------------------------------------------------------
#load_if_exists () {
#    if [ -f $1 ]; then
#        source $1
#    fi
#}
#
#load_if_exists "$HOME/.zshrc_local"

case ${OSTYPE} in
  darwin*)
    eval "$(direnv hook zsh)" # direnv

    # GNU Command
    # brew install coreutils
    alias date="gdate"
    alias mv="gmv"
    ;;

  linux*)
    ;;
esac

# ----------------------------------------------------------------
# zplugin
# ----------------------------------------------------------------

source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zplugin light zsh-users/zsh-syntax-highlighting
zplugin light zsh-users/zsh-autosuggestions

# ----------------------------------------------------------------
# fzf
# ----------------------------------------------------------------
function history-fzf() {
  local tac

  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi

  BUFFER=$(history -n 1 | eval $tac | fzf-tmux --query "$LBUFFER")
  CURSOR=$#BUFFER

  zle reset-prompt
}
zle -N history-fzf
bindkey '^r' history-fzf

# ----------------------------------------------------------------
# fzf
# ----------------------------------------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ----------------------------------------------------------------
# anyenv
# ----------------------------------------------------------------
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"


# ----------------------------------------------------------------
# node
# ----------------------------------------------------------------
# npm global moduleのパスを通す
NODE_PATH=`npm root -g`
export NODE_PATH

# ----------------------------------------------------------------
# go
# ----------------------------------------------------------------
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:$PATH"
