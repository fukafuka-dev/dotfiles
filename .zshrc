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
zstyle ':vcs_info:*' formats "%F{cyan} %F{yellow}[%f%c%u%b%F{yellow}]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
  vcs_info
}

PROMPT='
%F{red}$%f %F{blue}%n %f'

RPROMPT='%F{yellow}➜ %f %F{cyan}%~%f ${vcs_info_msg_0_} %F{yellow}ϟ %f'

# ----------------------------------------------------------------
# alias
# ----------------------------------------------------------------

alias vim=$EDITOR
alias view='() { $EDITOR -R $1 }' # viewコマンドは元々あるがviが使われる
alias ls='ls -GF'

# vim
alias vin='() { vim $(ls $1 | fzf) }'

# ghq
alias repo='() { cd $(ghq list -p | fzf -q "$*"  --preview "tree -C {} | head -200") }'

# メモ関係
alias note="memo.zsh"
alias memo="memo.zsh -e private"

alias dia="dialy.zsh"
dropbox_dir=~/Dropbox/plane
alias todo='vim $dropbox_dir/todo/todo.txt'
alias todo-ls='cat $dropbox_dir/todo/todo.txt | fzf'

# 特定のコマンドを実行した時背景色を変える（終了したら戻る）
alias ssh-login='(){tmux select-pane -P "fg=colour15,bg=magenta"; ssh $1; tmux select-pane -P "fg=default,bg=default" }'

# Docker
alias docker-login='() { docker exec -it $1 bash }'

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
load_zsh() {
  local x=$1
  ZSHHOME="${HOME}/${x}"

  if [ -d $ZSHHOME -a -r $ZSHHOME -a \
       -x $ZSHHOME ]; then
      for i in $ZSHHOME/*; do
          [[ ${i##*/} = *.zsh ]] &&
              [ \( -f $i -o -h $i \) -a -r $i ] && . $i
      done
  fi
}

echo 'load below'
load_zsh '.zsh_local'

# ----------------------------------------------------------------
# zplugin
# ----------------------------------------------------------------

source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zplugin light zsh-users/zsh-syntax-highlighting
zplugin light zsh-users/zsh-autosuggestions
zplugin light b4b4r07/zsh-gomi

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
